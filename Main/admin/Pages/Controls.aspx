<%@ Page Language="C#" MasterPageFile="~/admin/admin1.master" ValidateRequest="False" AutoEventWireup="true" CodeFile="Controls.aspx.cs" Inherits="admin_Pages_Controls" Title="Control settings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphAdmin" Runat="Server">
<br />
<div class="settings">

  <h1><%=Resources.labels.recentPosts %></h1>
  <label for="<%=txtNumberOfPosts.ClientID %>"><%=Resources.labels.numberOfPosts %></label>
  <asp:TextBox runat="server" ID="txtNumberOfPosts" Width="30" />
  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNumberOfPosts" ErrorMessage="Required" />
  <asp:CompareValidator runat="Server" ControlToValidate="txtNumberOfPosts" Operator="dataTypeCheck" Type="integer" ErrorMessage="Please enter a valid number" /><br />
  
  <label for="<%=cbDisplayComments.ClientID %>"><%=Resources.labels.displayCommentsOnRecentPosts %></label>
  <asp:CheckBox runat="Server" ID="cbDisplayComments" /><br />
  
  <label for="<%=cbDisplayRating.ClientID %>"><%=Resources.labels.displayRatingsOnRecentPosts %></label>
  <asp:CheckBox runat="Server" ID="cbDisplayRating" />

</div>

<div class="settings">

  <h1><%=Resources.labels.recentComments %></h1>
  <label for="<%=txtNumberOfPosts.ClientID %>"><%=Resources.labels.numberOfComments %></label>
  <asp:TextBox runat="server" ID="txtNumberOfComments" Width="30" />
  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNumberOfComments" ErrorMessage="Required" />
  <asp:CompareValidator runat="Server" ControlToValidate="txtNumberOfComments" Operator="dataTypeCheck" Type="integer" ErrorMessage="Please enter a valid number" /><br />

</div>

<div class="settings">

  <h1><%=Resources.labels.searchField %></h1>
  <label for="<%=txtSearchButtonText.ClientID %>"><%=Resources.labels.buttonText %></label>
  <asp:TextBox runat="server" ID="txtSearchButtonText" />
  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtSearchButtonText" ErrorMessage="Required" /><br />
  
  <label for="<%=txtDefaultSearchText.ClientID %>"><%=Resources.labels.searchFieldText %></label>
  <asp:TextBox runat="server" ID="txtDefaultSearchText" /> <%=Resources.labels.defaultTextShownInSearchField %>
  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDefaultSearchText" ErrorMessage="Required" /><br />
  
  <label for="<%=cbEnableCommentSearch.ClientID %>"><%=Resources.labels.enableCommentSearch %></label>
  <asp:CheckBox runat="Server" ID="cbEnableCommentSearch" /><br />
  
  <label for="<%=txtCommentLabelText.ClientID %>"><%=Resources.labels.commentLabelText %></label>
  <asp:TextBox runat="server" ID="txtCommentLabelText" />
  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCommentLabelText" ErrorMessage="Required" /><br />

</div>

<div class="settings">

  <h1><%=Resources.labels.contactForm %></h1>
  <label for="<%=txtFormMessage.ClientID %>"><%=Resources.labels.formMessage %></label>
  <asp:TextBox runat="server" ID="txtFormMessage" TextMode="multiLine" Rows="5" Columns="40" /><br />
  
  <label for="<%=txtThankMessage.ClientID %>"><%=Resources.labels.thankYouMessage %></label>
  <asp:TextBox runat="server" ID="txtThankMessage" TextMode="multiLine" Rows="5" Columns="40" />
  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtThankMessage" ErrorMessage="Required" /><br />
  
  <label for="<%=cbEnableAttachments.ClientID %>"><%=Resources.labels.enableAttachments %></label>
  <asp:CheckBox runat="Server" ID="cbEnableAttachments" />
  
</div>

<div style="text-align: right">
  <asp:Button runat="server" ID="btnSave" />
</div><br />
</asp:Content>

