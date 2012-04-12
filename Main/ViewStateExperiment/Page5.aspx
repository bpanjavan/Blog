<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ViewStateMasterCore.master" AutoEventWireup="true" CodeFile="Page5.aspx.cs" Inherits="Page5" %>

<asp:Content ID="contentHead" ContentPlaceHolderID="contentplaceholderHead" Runat="Server">
    <title>Page 5</title>
</asp:Content>
<asp:Content ID="contentMaint" ContentPlaceHolderID="contentplaceholderMain" Runat="Server">
   This page contains one label with value set on load
   <hr />
   <br />
   <asp:Label ID="labelMain" runat="server" />
    <hr />
    It's a little baffling just how much setting the value of one label greatly increases the size of my ViewState
    <pre>
    input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="/wEPDwULLTE1MjQ5ODA0NjkPZBYCZg9kFgICAw9kFgICA
    Q9kFgICAQ8PFgIeBFRleHQFFEdvb2RieWUgQ3J1ZWwgV29ybGQhZGRk6u2zlJpMJfyvAZJwtDuQ8qLF9Cc="
    </pre>
    This is what's in my code behind:
    <br />
    labelMain.Text = "Goodbye Cruel World!";
</asp:Content>


