<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CommentView.ascx.cs" Inherits="User_controls_CommentView" %>
<%@ Import Namespace="BlogEngine.Core" %>

<% if (Post.Comments.Count > 0){ %>
<h1 id="comment"><%=Resources.labels.comments %></h1>
<%} %>

<div id="commentlist" style="display:none">
  <asp:PlaceHolder runat="server" ID="phComments" />
</div>

<% if (Post.Comments.Count > 0){ %>
<script type="text/javascript">$('commentlist').style.display='block';</script>
<%} %>

<asp:PlaceHolder runat="Server" ID="phAddComment">

<img src="<%=Utils.RelativeWebRoot %>pics/ajax-loader.gif" alt="Saving the comment" style="display:none" id="ajaxLoader" />  
<span id="status"></span>

<div class="commentForm">
  <h1 id="addcomment"><%=Resources.labels.addComment %></h1>

  <label for="<%=txtName.ClientID %>"><%=Resources.labels.name %>*</label>
  <asp:TextBox runat="Server" ID="txtName" TabIndex="1" ValidationGroup="AddComment" />
  <asp:CustomValidator runat="server" ControlToValidate="txtName" ErrorMessage=" <%$Resources:labels, chooseOtherName %>" Display="dynamic" ClientValidationFunction="CheckAuthorName" EnableClientScript="true" ValidationGroup="AddComment" />
  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtName" ErrorMessage="<%$Resources:labels, required %>" Display="dynamic" ValidationGroup="AddComment" /><br />

  <label for="<%=txtEmail.ClientID %>"><%=Resources.labels.email %>*</label>
  <asp:TextBox runat="Server" ID="txtEmail" TabIndex="2" ValidationGroup="AddComment" />
  <span id="gravatarmsg">
  <%if (BlogSettings.Instance.Avatar != "none" && BlogSettings.Instance.Avatar != "monster"){ %>
  (<%=string.Format(Resources.labels.willShowGravatar, "<a href=\"http://www.gravatar.com\" target=\"_blank\">Gravatar</a>")%>)
  <%} %>
  </span>
  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" ErrorMessage="<%$Resources:labels, required %>" Display="dynamic" ValidationGroup="AddComment" />
  <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmail" ErrorMessage="<%$Resources:labels, enterValidEmail   %>" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="AddComment" /><br />

  <label for="<%=txtWebsite.ClientID %>"><%=Resources.labels.website %></label>
  <asp:TextBox runat="Server" ID="txtWebsite" TabIndex="3" ValidationGroup="AddComment" />
  <asp:RegularExpressionValidator runat="Server" ControlToValidate="txtWebsite" ValidationExpression="(http://|https://|)([\w-]+\.)+[\w-]+(/[\w- ./?%&=;~]*)?" ErrorMessage="<%$Resources:labels, enterValidUrl %>" Display="Dynamic" ValidationGroup="AddComment" /><br />
  
  <% if(BlogSettings.Instance.EnableCountryInComments){ %>
  <label for="<%=ddlCountry.ClientID %>"><%=Resources.labels.country %></label>
  <asp:DropDownList runat="server" ID="ddlCountry" onchange="SetFlag(this.value)" TabIndex="4" EnableViewState="false" ValidationGroup="AddComment" />&nbsp;
  <asp:Image runat="server" ID="imgFlag" AlternateText="Country flag" Width="16" Height="11" EnableViewState="false" /><br /><br />
  <%} %>

  <span class="bbcode" title="BBCode tags"><%=BBCodes() %></span>
  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtContent" ErrorMessage="<%$Resources:labels, required %>" Display="dynamic" ValidationGroup="AddComment" /><br />

  <% if (BlogSettings.Instance.ShowLivePreview) { %>  
  <ul id="commentMenu">
    <li id="compose" class="selected" onclick="ToggleCommentMenu(this)"><%=Resources.labels.comment%></li>
    <li id="preview" onclick="ToggleCommentMenu(this)"><%=Resources.labels.livePreview%></li>
  </ul>
  <% } %> 
  <div id="commentCompose">
    <asp:TextBox runat="server" ID="txtContent" TextMode="multiLine" Columns="50" Rows="10" TabIndex="5" ValidationGroup="AddComment" />
  </div>
  <div id="commentPreview">
    <img src="<%=Utils.RelativeWebRoot %>pics/ajax-loader.gif" alt="Loading" />  
  </div>
  
  <br />
  <input type="checkbox" id="cbNotify" style="width: auto" tabindex="6" />
  <label for="cbNotify" style="width:auto;float:none;display:inline"><%=Resources.labels.notifyOnNewComments %></label><br /><br />
 
  <input type="button" id="btnSaveAjax" value="<%=Resources.labels.saveComment %>" onclick="if(Page_ClientValidate('AddComment')){AddComment()}" tabindex="7" />    
  <asp:HiddenField runat="server" ID="hfCaptcha" />
</div>

<script type="text/javascript">
<!--//
var flagImage = $("<%= imgFlag.ClientID %>");
var contentBox = $("<%=txtContent.ClientID %>");
var moderation = <%=BlogSettings.Instance.EnableCommentsModeration.ToString().ToLowerInvariant() %>;
var checkName = <%=(!Page.User.Identity.IsAuthenticated).ToString().ToLowerInvariant() %>;
var postAuthor = "<%=Post.Author %>";

var nameBox = $("<%=txtName.ClientID %>");
var emailBox = $("<%=txtEmail.ClientID %>");
var websiteBox = $("<%=txtWebsite.ClientID %>");
var countryDropDown =$("<%=ddlCountry.ClientID %>"); 
var captchaField = $('<%=hfCaptcha.ClientID %>');
var controlId = '<%=this.UniqueID %>';
//-->
</script>

<% if (BlogSettings.Instance.IsCoCommentEnabled){ %>
<script type="text/javascript">
// this ensures coComment gets the correct values
coco =
{
     tool          : "BlogEngine",
     siteurl       : "<%=Utils.AbsoluteWebRoot %>",
     sitetitle     : "<%=BlogSettings.Instance.Name %>",
     pageurl       : "<%=Request.Url %>",
     pagetitle     : "<%=this.Post.Title %>",
     author        : "<%=this.Post.Title %>",
     formID        : "<%=Page.Form.ClientID %>",
     textareaID    : "<%=txtContent.UniqueID %>",
     buttonID      : "btnSaveAjax"
}
</script>
<script id="cocomment-fetchlet" src="http://www.cocomment.com/js/enabler.js" type="text/javascript">
</script>
<%} %>
</asp:PlaceHolder>

<asp:label runat="server" id="lbCommentsDisabled" visible="false"><%=Resources.labels.commentsAreClosed %></asp:label>