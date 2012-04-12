using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DataBindingSnapshot : System.Web.UI.Page
{
    protected string rating = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        /*
         * Trying to figure out if data binding truly is a snapshot.  
         * In this example, I create the collection, set the datasource, THEN databind
        */

        var colPersonOne = GetPersonCollection();
        gridviewOne.DataSource = colPersonOne;
        gridviewOne.DataBind();

        /*
         * In this example, I get the data, set the datasource,
         *  ALTER the data, THEN call databind
        */

        var colPersonTwo = GetPersonCollection();
        gridviewTwo.DataSource = colPersonTwo;
        // zero everone's age
        colPersonTwo[0].Age = 0;
        colPersonTwo[1].Age = 0;
        colPersonTwo[2].Age = 0;
        gridviewTwo.DataBind();

        /*
         * In this example, I get the data, set the datasource,
         *  THEN call databind, THEN ALTER the data, 
        */
        var colPersonThree = GetPersonCollection();
        gridviewThree.DataSource = colPersonThree;
        gridviewThree.DataBind();
        // zero everone's age
        colPersonThree[0].Age = 0;
        colPersonThree[1].Age = 0;
        colPersonThree[2].Age = 0;

        /*
         * 4th example, I get the data, set the datasource,
         *  THEN call databind, THEN ALTER the data, 
         *  Just like 3rd example but with datalist
        */
        // At this point, datalistOne.Items.Count == 0
        var colPersonFour = GetPersonCollection();
        datalistOne.DataSource = colPersonFour;
        datalistOne.DataBind();
        // After databinding, you can get the item literal control text:
        //  ((DataBoundLiteralControl)((DataListItem)datalistOne.Items[0]).Controls[0]).Text
        // zero everone's age
        colPersonFour[0].Age = 0;
        colPersonFour[1].Age = 0;
        colPersonFour[2].Age = 0;

        rating = "BEFORE";
        textboxRatingOne.DataBind();
        rating = "AFTER";
        textboxRatingTwo.DataBind();
    }

    public List<Person> GetPersonCollection()
    {
        List<Person> colPerson = new List<Person>();
        colPerson.Add(new Person() { Name = "Bryan", Age = 26 });
        colPerson.Add(new Person() { Name = "Xuan", Age = 28 });
        colPerson.Add(new Person() { Name = "Alyssa", Age = 20 });
        return colPerson;
    }

    public class Person
    {
        public string Name { get; set; }
        public int Age{get;set;}
    }
}
