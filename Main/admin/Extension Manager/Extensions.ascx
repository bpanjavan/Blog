<%@ Control Language="C#" AutoEventWireup="true" CodeFile="~/admin/Extension Manager/Extensions.ascx.cs" Inherits="User_controls_xmanager_ExtensionsList" %>
<asp:Literal ID="Literal1" runat="server" Text="<h1>Extensions</h1>" />
<div id="lblErrorMsg" style="padding:5px; color:Red;" runat="server"></div>
<asp:Label ID="lblExtensions" runat="server" Text="Not found"></asp:Label>

<br /><br />
<div style="text-align:right">
  <asp:Button runat="Server" ID="btnRestart" 
    Text="Apply changes" 
    OnClientClick="return confirm('The website will be unavailable for a few seconds.\nAre you sure you wish to continue?')" 
  />
</div>