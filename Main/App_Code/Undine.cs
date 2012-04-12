using System;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Activation;
using Lumina.Model;
using System.Collections.Generic;
using LightData.DataObjects;
using Lumina.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Diagnostics;

[ServiceContract(Namespace = "")]
[AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
public class Undine
{
    [OperationContract]
    public string GetParadigmDeckTest()
    {
        try
        {
            Lumina.Model.ParadigmDeck toReturn = ParadigmDeckAgent.GetParadigmDeck("Demo-Empty", false);
            // Not inflating the Paradigm List since Silverlight won't bring them over
            return "Hello World";
        }
        catch (Exception ex)
        {
            return ex.Message + ", " + ex.StackTrace;
        }

    }

    [OperationContract]
    public Lumina.Model.ParadigmDeck GetParadigmDeck()
    {
        try
        {
            Lumina.Model.ParadigmDeck toReturn = ParadigmDeckAgent.GetParadigmDeck("Demo-Empty", false);
            // Not inflating the Paradigm List since Silverlight won't bring them over
            return toReturn;
        }
        catch (Exception ex)
        {

        }
        return null;
    }

    [OperationContract]
    public Lumina.Model.ParadigmDeck GetParadigmDeckByNameKey(string nameKey)
    {
        try
        {
            Lumina.Model.ParadigmDeck toReturn = ParadigmDeckAgent.GetParadigmDeck(nameKey, false);
            // Not inflating the Paradigm List since Silverlight won't bring them over
            return toReturn;
        }
        catch (Exception ex)
        {

        }
        return null;
    }

    [OperationContract]
    public List<Lumina.Model.Paradigm> GetRelatedParadigms(string paradigmDeckNameKey)
    {
        var toReturn = ParadigmAgent.GetRelatedParadigms(paradigmDeckNameKey);
        return toReturn;
    }

    [OperationContract]
    public List<Lumina.Model.ParadigmControl> GetRelatedParadigmControls(string paradigmNameKey)
    {
        List<Lumina.Model.ParadigmControl> toReturn =
            ParadigmControlAgent.GetRelatedParadigmControls(paradigmNameKey);

        return toReturn;
    }


    [OperationContract]
    public Lumina.Model.Paradigm ParadigmShift(string paradigmDeckNameKey, string selectedParadigmNameKey)
    {
        Lumina.Model.ParadigmDeck paradigmDeck = ParadigmDeckAgent.GetParadigmDeck(paradigmDeckNameKey, true);
        Lumina.Model.Paradigm paradigm = null;
        if (selectedParadigmNameKey != null)
            paradigm = (from p in paradigmDeck.Paradigms
                        where p.NameKey == selectedParadigmNameKey
                        select p).First<Lumina.Model.Paradigm>();

        return ParadigmDeckCoordinator.ParadigmShift(paradigmDeck, paradigm);
    }

    [OperationContract]
    public LightDataTable GetParadigmControlDataByParadigmControl(Lumina.Model.ParadigmControl paradigmControl)
    {
        EventLog.WriteEntry("Sylphid:GetParadigmControlData - by paradigmControl",
            string.Format("ParadigmControl: {0}, DataSourceKey: {1}, DataKey: {2}",
                paradigmControl.Name,
                paradigmControl.DataSourceKey,
                paradigmControl.DataKey),
            EventLogEntryType.Information);

        LightDataTable toReturn = GetParadigmControlDataHelper(paradigmControl.DataSourceKey);
        return toReturn;
    }

    [OperationContract]
    public LightDataTable GetParadigmControlDataBySourceKey(string dataSourceKey)
    {
        //EventLog.WriteEntry("Sylphid:GetParadigmControlData - by DataSourceKey",
        //    string.Format("DataSourceKey: {0}", dataSourceKey),
        //    EventLogEntryType.Information);

        LightDataTable toReturn = GetParadigmControlDataHelper(dataSourceKey);
        toReturn.AdditionalProperties.Add("DataSourceKey", dataSourceKey);  // Echo the 

        return toReturn;
    }

    private LightDataTable GetParadigmControlDataHelper(string dataSourceKey)
    {
        LightDataTable toReturn = new LightDataTable();
        string[] arrDataSourceKey = dataSourceKey.Split(new char[] { '|' });
        string sourceDB = arrDataSourceKey[0].ToLower();

        switch (sourceDB)
        {
            case "none":
                toReturn.Status = "GOOD";
                break;
            default:
                string connStringName = sourceDB + "DB";
                ConnectionStringSettings css = ConfigurationManager.ConnectionStrings[connStringName];
                if (css == null)
                {
                    toReturn.Status = "ERROR";
                    toReturn.ErrorMessage = "Unrecognized source DB: " + sourceDB;
                    break;
                }

                SqlConnection conn = null;
                var dsData = new DataSet();
                string procName = arrDataSourceKey[2];  // ex: DBName|sp|MyStoredProcName

                try
                {
                    string connString = css.ConnectionString;
                    conn = new SqlConnection(connString);
                    conn.Open();
                    SqlCommand cmd = new SqlCommand(procName, conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandTimeout = conn.ConnectionTimeout;

                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    adapter.Fill(dsData);

                    toReturn = LightData.LightDataConverter.ConvertDataSetToLightDataTable(dsData);
                    toReturn.Status = "GOOD";
                }
                catch (Exception ex)
                {
                    toReturn.Status = "ERROR";
                    toReturn.ErrorMessage = ex.Message + ", " + ex.StackTrace;
                }
                finally
                {
                    if (conn != null)
                        conn.Close();
                }

                break;
        }
        return toReturn;
    }


    /// <summary>
    /// Created to establish the contract of the light data table
    /// </summary>
    /// <returns></returns>
    [OperationContract]
    public LightDataTable GetSampleLightDataTable()
    {
        return null;
    }
}
