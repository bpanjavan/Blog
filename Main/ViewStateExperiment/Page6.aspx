<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ViewStateMasterCore.master" AutoEventWireup="true" CodeFile="Page6.aspx.cs" Inherits="Page6" %>

<asp:Content ID="contentHead" ContentPlaceHolderID="contentplaceholderHead" Runat="Server">
    <title>Page 6</title>
</asp:Content>
<asp:Content ID="contentMaint" ContentPlaceHolderID="contentplaceholderMain" Runat="Server">
   This page contains one label with value set on page init
   <hr />
   <br />
   <asp:Label ID="labelMain" runat="server" OnInit="labelMain_Init"/>
   <hr />
   My ViewState is identical to when I set it in the Page_Load.  While I'm doing this in the Page_Init, the Label's OnInit event has already fired, and ViewState tracking is on.
    <pre>
   input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="/wEPDwULLTE1MjQ5ODA0NjkPZBYCZg9kFgICAw9kFgICAQ9kFgICAQ8P
   FgIeBFRleHQFFEdvb2RieWUgQ3J1ZWwgV29ybGQhZGRkqJV6Ytuowp5Nfsrn4jqXu4KTfZ0=" 
   </pre>
</asp:Content>


