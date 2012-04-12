using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text;
using System.Diagnostics;
using Jayrock.Json.Conversion;
using Jayrock.Json;
using System.IO;
using TaskOrganizer;

public partial class _Default : System.Web.UI.Page 
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
        }
        HandleCallBacks();
    }

    /// <summary>
    /// General callback handler
    /// </summary>
    private void HandleCallBacks()
    {
        // function to handle all callback variables
        string callback = Request.Params["Callback"];
        if (string.IsNullOrEmpty(callback))
            return;

        // *** We have an action try and match it to a handler
        if (callback == "Data_Tasks")
        {
            LoadData();
        }
        else if (callback == "Save_Tasks")
        {
            string data = Request.Params["Data"];
            if (string.IsNullOrEmpty(data))
                return;
            SaveData(data);
        }
        else
        {
            Response.StatusCode = 500;
            Response.Write("Invalid Callback Method");
            Response.End();
        }
    }

    private void SaveData(string data)
    {
        List<Task> colTask = new List<Task>();
        Task currTask = null;
        // read the data into a .NET object and save
        using (JsonTextReader reader = new JsonTextReader(new StringReader(data)))
        {
            bool toContinue = true;
            do
            {
                if (reader.TokenClass == JsonTokenClass.BOF)
                    reader.Read();  // read to get in the file
                else if (reader.TokenClass == JsonTokenClass.Object)
                {
                    currTask = new Task();
                    reader.Read();  // read to get to the first member
                }
                else if (reader.TokenClass == JsonTokenClass.Member
                            && reader.Text == "taskID")
                {
                    reader.Read();                                      //  Read to get to the member data
                    currTask.TaskID = new Guid(reader.ReadString());    // then read the data
                }
                else if (reader.TokenClass == JsonTokenClass.Member
                            && reader.Text == "isComplete")
                {
                    reader.Read();                                 //  Read to get to the member data
                    currTask.IsComplete = reader.ReadBoolean();    // then read the data
                }
                else if (reader.TokenClass == JsonTokenClass.Member
                            && reader.Text == "description")
                {
                    reader.Read();                                 //  Read to get to the member data
                    currTask.Description = reader.ReadString();    // then read the data
                }
                else if (reader.TokenClass == JsonTokenClass.Member
                            && reader.Text == "dueDate")
                {
                    reader.Read();                                 //  Read to get to the member data
                    currTask.DueDate = DateTime.Parse(reader.ReadString());    // then read the data
                }
                else if (reader.TokenClass == JsonTokenClass.EndObject)
                {
                    colTask.Add(currTask);
                    reader.Read();
                }
                else if (reader.TokenClass == JsonTokenClass.EndArray)
                    toContinue = false;
                else
                    reader.Read();  // just continue reading, don't want to get stuck

            } while (toContinue == true);

        }
        
        // prioratize them according to the order they were saved
        int counter = 0;
        foreach (Task task in colTask)
        {
            task.Priority = counter++;
        }

        // Don't allow them to have more than 10
        while (colTask.Count > 10)
        {
            colTask.Remove(colTask[10]);
        }

        // Now call SQL and save it
        // make DB call to get tasks
        SqlConnection conn = null;
        SqlTransaction transaction = null;
        try
        {
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["PTO_Procs"].ConnectionString);
            conn.Open();
            transaction = conn.BeginTransaction();
            SqlCommand cmd = new SqlCommand("sp_DeleteAllTasks", conn, transaction);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.ExecuteNonQuery();

            SqlCommand cmdInsert = null; 
            foreach (Task task in colTask)
            {
                cmdInsert = new SqlCommand("sp_InsertTask", conn, transaction);
                cmdInsert.CommandType = CommandType.StoredProcedure;
                cmdInsert.Parameters.Add(new SqlParameter("@taskID", task.TaskID));
                cmdInsert.Parameters.Add(new SqlParameter("@description", task.Description));
                cmdInsert.Parameters.Add(new SqlParameter("@dueDate", task.DueDate));
                cmdInsert.Parameters.Add(new SqlParameter("@isComplete", task.IsComplete));
                cmdInsert.Parameters.Add(new SqlParameter("@priority", task.Priority));

                cmdInsert.ExecuteNonQuery();
            }

            transaction.Commit();        
        }
        catch (Exception ex)
        {
            if (transaction != null)
                transaction.Rollback();
            throw ex;
        }
        finally
        {
            if (conn != null)
                conn.Close();
        }
        


        Response.ContentType = "application/json";
        Response.Write("Saved");
        Response.End();
    }

    /// <summary>
    /// Load all tasks.  This will be a method called by the Javascript
    /// </summary>
    private void LoadData()
    {
        // dataset for our tasks
        DataSet dsTask = new DataSet();

        // make DB call to get tasks
        SqlConnection conn = null;
        try
        {
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["PTO_Procs"].ConnectionString);
            conn.Open();
            SqlCommand cmd = new SqlCommand("sp_GetTasks", conn);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);

            sda.Fill(dsTask);
        }
        catch(Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (conn != null)
                conn.Close();
        }

        // output dataset
        /*
        StringBuilder sb = new StringBuilder();
        foreach (DataRow dr in dsTask.Tables[0].Rows)
        {

            foreach (DataColumn dc in dsTask.Tables[0].Columns)
            {
                sb.Append(dc.ColumnName + ": ");
                sb.Append(dr[dc]);
            }
            Debug.WriteLine(sb.ToString());
            sb = new StringBuilder();
        }
        */

        List<Task> colTask = new List<Task>();
        foreach (DataRow dr in dsTask.Tables[0].Rows)
        {
            Task newTask = new Task();
            newTask.TaskID = (Guid)dr["pt_taskid"];
            newTask.IsComplete = (bool)dr["pt_iscomplete"];
            newTask.Description = (string)dr["pt_description"];
            newTask.DueDate = (DateTime)dr["pt_duedate"];
            newTask.Priority = (int)dr["pt_priority"];
            colTask.Add(newTask);
        }

        string jsonTaskList = JsonConvert.ExportToString(colTask);
        Debug.WriteLine(jsonTaskList);

        Response.ContentType = "application/json";
        Response.Write(jsonTaskList);
        Response.End();
    }
}







