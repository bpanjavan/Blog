<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DataBindingSnapshot.aspx.cs" Inherits="DataBindingSnapshot" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="formMain" runat="server">
    <div>
        Simple case.  Get the collection, set the datasource, then databind.
        <asp:GridView ID="gridviewOne"
            AutoGenerateColumns="true" 
            runat="server">
        </asp:GridView>
        <br />
        2nd case.  Get the collection, set the datasource, then ZERO everyone's age, then databind.
        <asp:GridView ID="gridviewTwo"
            AutoGenerateColumns="true" 
            runat="server">
        </asp:GridView>
        <br />
        3nd case.  Get the collection, set the datasource, then databind, then ZERO everyone's age.
        <asp:GridView ID="gridviewThree"
            AutoGenerateColumns="true" 
            runat="server">
        </asp:GridView>
        <br />
        4th Case.  Same as third but using a datalist
        <asp:DataList ID="datalistOne" runat="server">
            <ItemTemplate>
                <%#Eval("Name") %>
                &nbsp;
                <%#Eval("Age") %>
            </ItemTemplate>
        </asp:DataList>
        <br />
        So DataBind is like a snapshot from the data source onto the data control.<br />
        The data controls maintain a reference to the data source through the DataSource property.
        So it's possible to have a situation where the data in the data source is different 
        then the data shown on the data control.
        <br />
        These textboxes get databound from the same variable, but the top one gets
            bound first.  Then the variable changes, then the bottom gets bound.
            It's the same variable but the snapshot taken at different times
        <br />
        <asp:TextBox ID="textboxRatingOne" runat="server" Text='<%#this.rating %>'>
        </asp:TextBox>
        <br />
        <asp:TextBox ID="textboxRatingTwo" runat="server" Text='<%#this.rating %>'>
        </asp:TextBox>
    </div>
    </form>
</body>
</html>
