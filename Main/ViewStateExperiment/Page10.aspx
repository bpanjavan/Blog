<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ViewStateMasterCore.master" AutoEventWireup="true" CodeFile="Page10.aspx.cs" Inherits="Page4" %>

<asp:Content ID="contentHead" ContentPlaceHolderID="contentplaceholderHead" Runat="Server">
    <title>Page 10</title>
</asp:Content>
<asp:Content ID="contentMain" ContentPlaceHolderID="contentplaceholderMain" Runat="Server">
   Party time.  This page contains several controls, ALL of which are set in the Page_Load
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
    <hr />
    The result is a massive ViewState proportional to the number of controls I placed and set the value of on the page
    <pre>
    input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="/wEPDwUKLTIyMTA1NzczMg9kFgJmD2QWAgIDD2QWAgIBD2QWIAIBDw8W
    Ah4EVGV4dAUNR28gTG9uZ2hvcm5zIWRkAgcPDxYCHwAFDUdvIExvbmdob3JucyFkZAILDw8WAh8ABQ1HbyBMb25naG9ybnMhZGQCDw8PFgIfAAUNR28gTG9
    uZ2hvcm5zIWRkAhMPDxYCHwAFDUdvIExvbmdob3JucyFkZAIXDw8WAh8ABQ1HbyBMb25naG9ybnMhZGQCGw8PFgIfAAUNR28gTG9uZ2hvcm5zIWRkAh8PDx
    YCHwAFDUdvIExvbmdob3JucyFkZAIjDw8WAh8ABQ1HbyBMb25naG9ybnMhZGQCJw8PFgIfAAUNR28gTG9uZ2hvcm5zIWRkAisPDxYCHwAFDUdvIExvbmdob
    3JucyFkZAIvDw8WAh8ABQ1HbyBMb25naG9ybnMhZGQCMw8PFgIfAAUNR28gTG9uZ2hvcm5zIWRkAjcPDxYCHwAFDUdvIExvbmdob3JucyFkZAI7Dw8WAh8A
    BQ1HbyBMb25naG9ybnMhZGQCPw8PFgIfAAUNR28gTG9uZ2hvcm5zIWRkZHQ85dgtMNHDpux0TWtwAhLyNQuB"    
    </pre>
</asp:Content>


