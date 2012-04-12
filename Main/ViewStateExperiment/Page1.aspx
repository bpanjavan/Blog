<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ViewStateMasterCore.master" AutoEventWireup="true" CodeFile="Page1.aspx.cs" Inherits="Page1" %>

<asp:Content ID="contentHead" ContentPlaceHolderID="contentplaceholderHead" Runat="Server">
    <title>Page 1</title>
</asp:Content>
<asp:Content ID="contentMaint" ContentPlaceHolderID="contentplaceholderMain" Runat="Server">
   This page contains one label with NO default value.
   <hr />
   <br />
   <asp:Label ID="labelMain" runat="server" />
   <br />
   <hr />
   I expect a very thin ViewState
   <br />
  <pre>
   input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="/wEPDwULLTE1MjQ5ODA0NjlkZIab3DqgZn3OuD1SzY4M9bhDZrgb"
    </pre>
</asp:Content>

