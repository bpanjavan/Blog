<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ViewStateMasterCore.master" AutoEventWireup="true" CodeFile="Page2.aspx.cs" Inherits="Page2" %>

<asp:Content ID="contentHead" ContentPlaceHolderID="contentplaceholderHead" Runat="Server">
    <title>Page 2</title>
</asp:Content>
<asp:Content ID="contentMain" ContentPlaceHolderID="contentplaceholderMain" Runat="Server">
   This page contains several controls.  
   <hr />
   <br />
   <asp:Label ID="labelMain" runat="server" />
   <asp:TextBox ID="textboxMain" runat="server" />
   <asp:DropDownList ID="dropdownlistStates" runat="server">
    <asp:ListITem Value="Alaska" />
    <asp:ListITem Value="California" />
    <asp:ListITem Value="Colorado" />
    <asp:ListITem Value="Florida" />
    <asp:ListITem Value="Nebraska" />
    <asp:ListITem Value="Texas" />
   </asp:DropDownList>
   <asp:Label ID="label1" runat="server" />
   <asp:TextBox ID="textbox1" runat="server" />
   <asp:Label ID="label2" runat="server" />
   <asp:TextBox ID="textbox2" runat="server" />
   <asp:Label ID="label3" runat="server" />
   <asp:TextBox ID="textbox3" runat="server" />
   <asp:Label ID="label4" runat="server" />
   <asp:TextBox ID="textbox4" runat="server" />
   <asp:Label ID="label5" runat="server" />
   <asp:TextBox ID="textbox5" runat="server" />
   <asp:Label ID="label6" runat="server" />
   <asp:TextBox ID="textbox6" runat="server" />
   <asp:Label ID="label7" runat="server" />
   <asp:TextBox ID="textbox7" runat="server" />
   <asp:Label ID="label8" runat="server" />
   <asp:TextBox ID="textbox8" runat="server" />
   <asp:Label ID="label9" runat="server" />
   <asp:TextBox ID="textbox9" runat="server" />
   <asp:Label ID="label10" runat="server" />
   <asp:TextBox ID="textbox10" runat="server" />
   <asp:Label ID="label11" runat="server" />
   <asp:TextBox ID="textbox11" runat="server" />
   <asp:Label ID="label12" runat="server" />
   <asp:TextBox ID="textbox12" runat="server" />
   <asp:Label ID="label13" runat="server" />
   <asp:TextBox ID="textbox13" runat="server" />
   <asp:Label ID="label14" runat="server" />
   <asp:TextBox ID="textbox14" runat="server" />
   <asp:Label ID="label15" runat="server" />
   <hr />
    <br />
    You'd think there will be a very heavy ViewState but you'll be surprised.   
    Well, it's not very big but maybe it's because there's no default values.
    <br />
    <pre>
    input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="/wEPDwUKLTIyMTA1NzczMmRkgSBG1wKggDtgOjjbzNj/Xdyktcg="
    </pre>
</asp:Content>

