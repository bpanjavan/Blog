<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ViewStateMasterCore.master" AutoEventWireup="true" CodeFile="Page4.aspx.cs" Inherits="Page4" %>

<asp:Content ID="contentHead" ContentPlaceHolderID="contentplaceholderHead" Runat="Server">
    <title>Page 4</title>
</asp:Content>
<asp:Content ID="contentMain" ContentPlaceHolderID="contentplaceholderMain" Runat="Server">
   This page contains several controls.  
   <hr />
    <br />
   <asp:Label ID="labelMain" runat="server" Text="Goodbye Cruel World" />
   <asp:TextBox ID="textboxMain" runat="server" Text="Goodbye Cruel World" />
   <asp:DropDownList ID="dropdownlistStates" runat="server">
    <asp:ListITem Value="Alaska" />
    <asp:ListITem Value="California" Selected="True"/>
    <asp:ListITem Value="Colorado" />
    <asp:ListITem Value="Florida" />
    <asp:ListITem Value="Nebraska" />
    <asp:ListITem Value="Texas" />
   </asp:DropDownList>
   <asp:Label ID="label1" runat="server" Text="Goodbye Cruel World" />
   <asp:TextBox ID="textbox1" runat="server" Text="Goodbye Cruel World" />
   <asp:Label ID="label2" runat="server" Text="Goodbye Cruel World" />
   <asp:TextBox ID="textbox2" runat="server" Text="Goodbye Cruel World" />
   <asp:Label ID="label3" runat="server" Text="Goodbye Cruel World" />
   <asp:TextBox ID="textbox3" runat="server" Text="Goodbye Cruel World" />
   <asp:Label ID="label4" runat="server" Text="Goodbye Cruel World" />
   <asp:TextBox ID="textbox4" runat="server" Text="Goodbye Cruel World" />
   <asp:Label ID="label5" runat="server" Text="Goodbye Cruel World" />
   <asp:TextBox ID="textbox5" runat="server" Text="Goodbye Cruel World" />
   <asp:Label ID="label6" runat="server" Text="Goodbye Cruel World" />
   <asp:TextBox ID="textbox6" runat="server" Text="Goodbye Cruel World" />
   <asp:Label ID="label7" runat="server" Text="Goodbye Cruel World" />
   <asp:TextBox ID="textbox7" runat="server" Text="Goodbye Cruel World" />
   <asp:Label ID="label8" runat="server" Text="Goodbye Cruel World" />
   <asp:TextBox ID="textbox8" runat="server" Text="Goodbye Cruel World" />
   <asp:Label ID="label9" runat="server" Text="Goodbye Cruel World" />
   <asp:TextBox ID="textbox9" runat="server" Text="Goodbye Cruel World" />
   <asp:Label ID="label10" runat="server" Text="Goodbye Cruel World" />
   <asp:TextBox ID="textbox10" runat="server" Text="Goodbye Cruel World" />
   <asp:Label ID="label11" runat="server" Text="Goodbye Cruel World" />
   <asp:TextBox ID="textbox11" runat="server" Text="Goodbye Cruel World" />
   <asp:Label ID="label12" runat="server" Text="Goodbye Cruel World" />
   <asp:TextBox ID="textbox12" runat="server" Text="Goodbye Cruel World" />
   <asp:Label ID="label13" runat="server" Text="Goodbye Cruel World" />
   <asp:TextBox ID="textbox13" runat="server" Text="Goodbye Cruel World" />
   <asp:Label ID="label14" runat="server" Text="Goodbye Cruel World" />
   <asp:TextBox ID="textbox14" runat="server" Text="Goodbye Cruel World" />
   <asp:Label ID="label15" runat="server" Text="Goodbye Cruel World" />
   <br />
    <hr />
    You'd think there will be a very heavy ViewState but you'll be surprised.   
    This time we do have default values
<pre>
input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="/wEPDwUKLTIyMTA1NzczMmRk/EW+E8nZsXrJJPJdhGWkjpJTLbg="
</pre>
</asp:Content>


