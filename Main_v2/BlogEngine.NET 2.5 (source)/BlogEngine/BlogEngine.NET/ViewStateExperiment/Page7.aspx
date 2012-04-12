<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ViewStateMasterCore.master" AutoEventWireup="true" CodeFile="Page7.aspx.cs" Inherits="Page7" %>

<asp:Content ID="contentHead" ContentPlaceHolderID="contentplaceholderHead" Runat="Server">
    <title>Page 7</title>
</asp:Content>
<asp:Content ID="contentMaint" ContentPlaceHolderID="contentplaceholderMain" Runat="Server">
   This page contains one label with value set on the label Init
   <hr />
   <br />
   <asp:Label ID="labelMain" runat="server" OnInit="labelMain_Init"/>
   <br />
   I get a small ViewState, beacuse setting the value during the Label's OnInit event happens BEFORE Viewstate tracking turns on
   <pre>
   input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="/wEPDwULLTE1MjQ5ODA0NjlkZMzACcSN2Gt8syIZc3rVhh44pm6V"   </pre>
</asp:Content>


