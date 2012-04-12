<%@ Control Language="C#" AutoEventWireup="true" CodeFile="tinyMCE.ascx.cs" Inherits="admin_tinyMCE" %>
<%@ Import Namespace="BlogEngine.Core" %>
<%@ Import Namespace="BlogEngine.Core.Web.Controls" %>

<script type="text/javascript" src="<%=Utils.RelativeWebRoot %>editors/tiny_mce/tiny_mce.js"></script>
<script language="javascript" type="text/javascript">
  tinyMCE.init({
	  mode : "exact",
    elements : "<%=txtContent.ClientID %>",
	  theme : "advanced",
	  //plugins : "style,layer,table,save,advhr,advimage,advlink,emotions,iespell,media,searchreplace,contextmenu,paste,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras",
	  
	  <%if (Request.UserAgent != null && Request.UserAgent.Contains("MSIE")){ %>
	    plugins : "inlinepopups,fullscreen,contextmenu,cleanup,emotions,table,iespell",
	  <%}else{ %>
	    plugins : "inlinepopups,fullscreen,contextmenu,cleanup,emotions,table",
	  <%} %>
	  
	  theme_advanced_buttons1_add_before : "fullscreen,code,separator,cut,copy,paste,separator,undo,redo,separator",
	  theme_advanced_buttons1_add : "separator,bullist,numlist,outdent,indent,separator,iespell,link,unlink,sub,sup,removeformat,cleanup,charmap,emotions,separator,formatselect,fontselect,fontsizeselect",
	  theme_advanced_buttons2_add : "",
	  button_tile_map : true,
	  //theme_advanced_buttons2_add_before: "",
	  theme_advanced_disable : "styleselect,code,hr,charmap,sub,sup,visualaid,separator,removeformat,bullist,numlist,outdent,indent,undo,redo,link,unlink,anchor,help,cleanup,image,formatselect",
	  //theme_advanced_buttons3_add_before : "tablecontrols,separator",
	  //theme_advanced_buttons3_add : "emotions,iespell,media,advhr",
	  //theme_advanced_buttons4 : "insertlayer,moveforward,movebackward,absolute,|,styleprops,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,",
	  theme_advanced_toolbar_location : "top",
	  theme_advanced_toolbar_align : "left",
	  theme_advanced_path_location : "bottom",
	  //content_css : "<%= VirtualPathUtility.ToAbsolute("~/") + "themes/" + BlogSettings.Instance.Theme %>/style.css",
      plugin_insertdate_dateFormat : "%Y-%m-%d",
      plugin_insertdate_timeFormat : "%H:%M:%S",
	  extended_valid_elements : "hr[class|width|size|noshade],font[face|size|color|style],span[class|align|style],script[charset|defer|language|src|type],code,iframe[src|width|height|frameborder|name|style]",
	  //external_link_list_url : "example_link_list.js",
	  //external_image_list_url : "example_image_list.js",
	  //flash_external_list_url : "example_flash_list.js",
	  //media_external_list_url : "example_media_list.js",
	  //template_external_list_url : "example_template_list.js",
	  file_browser_callback : "fileBrowserCallBack",
	  theme_advanced_resize_horizontal : false,
	  theme_advanced_resizing : true,
	  nonbreaking_force_tab : true,
	  apply_source_formatting : true,
	  relative_urls : false
//	  template_replace_values : {
//		  username : "Jack Black",
//		  staffid : "991234"
//	  }
  });
</script>

<asp:TextBox runat="Server" ID="txtContent" CssClass="post" Width="100%" Height="250px" TextMode="MultiLine" />