<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ViewStateMasterCore.master" AutoEventWireup="true" CodeFile="Page3.aspx.cs" Inherits="Page3" %>

<asp:Content ID="contentHead" ContentPlaceHolderID="contentplaceholderHead" Runat="Server">
    <title>Page 3</title>
</asp:Content>
<asp:Content ID="contentMaint" ContentPlaceHolderID="contentplaceholderMain" Runat="Server">
   This page contains one label with a default value.
   <hr />
   <br />
   <asp:Label ID="labelMain" runat="server" Text="Goodbye Cruel World!"/>
   <br />
   <hr />
   I still expect a very thin ViewState
   <pre>
    input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="/wEPDwULLTE1MjQ5ODA0NjlkZFauh0Umcvi5SNREPv0FdIniOsWV"
   </pre>
</asp:Content>


