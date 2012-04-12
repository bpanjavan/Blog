<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ViewStateMasterCore.master" AutoEventWireup="true" CodeFile="Page9.aspx.cs" Inherits="Page9" %>

<asp:Content ID="contentHead" ContentPlaceHolderID="contentplaceholderHead" Runat="Server">
    <title>Page 9</title>
</asp:Content>
<asp:Content ID="contentMain" ContentPlaceHolderID="contentplaceholderMain" Runat="Server">
   This page contains one label with a default value.  I'm setting the ForeColor property to Red on the Page Load.<br />
   <hr />
   <br />
   <asp:Label ID="labelMain" runat="server">Goodbye Cruel World!</asp:Label>
    <hr />
   <br />
   This INCREASES my ViewState, just like setting the Text value would
   <br />
    <pre>
    input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="/wEPDwUKMTMwNjIzNjgzNQ9kFgJmD2QWAgIDD2QWAgIBD2
    QWAgIBDw8WBB4JRm9yZUNvbG9yCo0BHgRfIVNCAgRkZGRrq+ac2nzvPvN5n/qUi70u3ldMJQ=="
    </pre>
</asp:Content>


