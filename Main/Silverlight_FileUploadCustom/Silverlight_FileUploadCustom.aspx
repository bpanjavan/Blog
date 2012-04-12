<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Silverlight_FileUploadCustom.aspx.cs" Inherits="Silverlight_FileUploadCustom_Silverlight_FileUploadCustom" %>
<%@ Register Assembly="System.Web.Silverlight" Namespace="System.Web.UI.SilverlightControls" TagPrefix="asp" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml"  style="height:100%;">
<head id="Head1" runat="server">
    <title>Silverlight File Upload Custom</title>
</head>
<body style="height:100%;margin:0; text-align:center;">
    <form id="form1" runat="server" 
        style="height:100%;">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        
        <div  style="height:100%;">
            <asp:Silverlight ID="Silverlight0" runat="server" Source="~/Silverlight_FileUploadCustom/ClientBin/Silverlight_FileUploadCustom.xap" MinimumVersion="2.0.31005.0" Width="400px" Height="100%" />
        </div>
    </form>
</body>
</html>
