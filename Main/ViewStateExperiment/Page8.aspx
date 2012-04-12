<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ViewStateMasterCore.master" AutoEventWireup="true" CodeFile="Page8.aspx.cs" Inherits="Page8" %>

<asp:Content ID="contentHead" ContentPlaceHolderID="contentplaceholderHead" Runat="Server">
    <title>Page 8</title>
</asp:Content>
<asp:Content ID="contentMaint" ContentPlaceHolderID="contentplaceholderMain" Runat="Server">
   This page contains one label with a default value which it gets from an inline code call
   <hr />
   <br />
   <asp:Label ID="labelMain" runat="server"><%=GetMainString() %></asp:Label>
    <hr />
   <br />
   I expect a very thin ViewState, and I get it.  When you bind through inline code, the values are grabbed pre-Initialization of the Page itself.
   <br />
   Aside from not having to re-compile, this is IMO another reason to set as many values declaratively as possible.
    <pre>
    input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="/wEPDwULLTE1MjQ5ODA0NjlkZIp1NN3nfXG2G5u4rgPNMbOUdjaK" 
    </pre>
</asp:Content>

