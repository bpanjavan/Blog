<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Showcase.master" AutoEventWireup="true" CodeFile="FileUpload.aspx.cs" Inherits="Showcase_FileRouter" %>
<%@ Register Assembly="System.Web.Silverlight" Namespace="System.Web.UI.SilverlightControls" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>Silverlight File Upload</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" Runat="Server">
    <asp:Silverlight ID="Silverlight0" runat="server" Source="~/Silverlight_FileUploadCustom/ClientBin/Silverlight_FileUploadCustom.xap" MinimumVersion="2.0.31005.0" Width="400px" Height="100%" />
</asp:Content>

