<%@ Page Language="C#" MasterPageFile="~/admin/admin1.master" AutoEventWireup="true" CodeFile="Blogroll.aspx.cs" Inherits="admin_Pages_blogroll" Title="Blogroll" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphAdmin" runat="Server">

<br />

<div class="settings">
  <h1 style="margin: 0 0 5px 0"><%=Resources.labels.settings %></h1>
  
 <label for="<%=ddlVisiblePosts.ClientID %>" class="wide"><%=Resources.labels.numberOfDisplayedItems %></label>
  <asp:DropDownList runat="server" id="ddlVisiblePosts">
    <asp:ListItem Text="0" />
    <asp:ListItem Text="1" />
    <asp:ListItem Text="2" />
    <asp:ListItem Text="3" />
    <asp:ListItem Text="4" />
    <asp:ListItem Text="5" />
    <asp:ListItem Text="6" />
    <asp:ListItem Text="7" />
    <asp:ListItem Text="8" />
    <asp:ListItem Text="9" />
    <asp:ListItem Text="10" />
  </asp:DropDownList><br />
  
  <label for="<%=txtMaxLength.ClientID %>" class="wide"><%=Resources.labels.maxLengthOfItems %></label>
  <asp:TextBox runat="server" ID="txtMaxLength" MaxLength="3" Width="50" />
  <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="txtMaxLength" Operator="dataTypeCheck" Type="integer" ValidationGroup="settings" ErrorMessage="Not a valid number" /><br />
  
  <label for="<%=txtUpdateFrequency.ClientID %>" class="wide"><%=Resources.labels.updateFrequenzy %></label>
  <asp:TextBox runat="server" ID="txtUpdateFrequency" MaxLength="3" Width="50" />
  <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="txtUpdateFrequency" Operator="dataTypeCheck" Type="integer" ValidationGroup="settings" ErrorMessage="Not a valid number" />
  
  <div style="text-align:right">
    <asp:Button runat="server" ID="btnSaveSettings" ValidationGroup="settings" />
  </div>
  
 </div>
 
<div class="settings">
  
  <h1 style="margin: 0 0 5px 0"><%=Resources.labels.add %> blog</h1>

  <label for="<%=txtTitle.ClientID %>" class="wide"><%=Resources.labels.title %></label>
  <asp:TextBox runat="server" ID="txtTitle" Width="600px" />
  <asp:RequiredFieldValidator runat="Server" ControlToValidate="txtTitle" ErrorMessage="required" /><br />
  
  <label for="<%=txtDescription.ClientID %>" class="wide"><%=Resources.labels.description %></label>
  <asp:TextBox runat="server" ID="txtDescription" Width="600px" />
  <asp:RequiredFieldValidator runat="Server" ControlToValidate="txtDescription" ErrorMessage="required" /><br />
  
  <label for="<%=txtWebUrl.ClientID %>" class="wide"><%=Resources.labels.website %></label>
  <asp:TextBox runat="server" ID="txtWebUrl" Width="600px" />
  <asp:RequiredFieldValidator runat="Server" ControlToValidate="txtWebUrl" ErrorMessage="required" /><br />
  
  <label for="<%=txtFeedUrl.ClientID %>" class="wide">RSS url</label>
  <asp:TextBox runat="server" ID="txtFeedUrl" Width="600px" />
  <asp:RequiredFieldValidator runat="Server" ControlToValidate="txtFeedUrl" ErrorMessage="required" /><br />
  
  <label for="<%=cblXfn.ClientID %>" class="wide">XFN tag</label>
  <asp:CheckBoxList runat="server" ID="cblXfn" CssClass="nowidth" RepeatColumns="8">
    <asp:ListItem Text="contact" />
    <asp:ListItem Text="acquaintance " />
    <asp:ListItem Text="friend " />
    <asp:ListItem Text="met" />
    <asp:ListItem Text="co-worker" />
    <asp:ListItem Text="colleague " />
    <asp:ListItem Text="co-resident" />
    <asp:ListItem Text="neighbor " />
    <asp:ListItem Text="child" />
    <asp:ListItem Text="parent" />
    <asp:ListItem Text="sibling" />
    <asp:ListItem Text="spouse" />
    <asp:ListItem Text="kin" />
    <asp:ListItem Text="muse" />
    <asp:ListItem Text="crush" />
    <asp:ListItem Text="date" />
    <asp:ListItem Text="sweetheart" />
    <asp:ListItem Text="me" />
  </asp:CheckBoxList>
  
  <div style="text-align:right">
    <asp:Button runat="server" ID="btnSave" />
  </div>
  
</div>
  
  <asp:Repeater runat="Server" ID="rep">
    <HeaderTemplate>
      <table style="width:100%;background-color:White" cellspacing="0" cellpadding="3" summary="Blogroll">
    </HeaderTemplate>
    <ItemTemplate>
      <tr>
        <td>
          <a href="<%#((System.Xml.XmlNode)Container.DataItem).Attributes["xmlUrl"].Value %>"><img src="../../pics/rssButton.gif" alt="RSS feed" /></a>
          <a href="<%#((System.Xml.XmlNode)Container.DataItem).Attributes["htmlUrl"].Value %>"><%#((System.Xml.XmlNode)Container.DataItem).Attributes["title"].Value %></a>
          &nbsp;<%#((System.Xml.XmlNode)Container.DataItem).Attributes["description"].Value %>
          &nbsp;(<%#((System.Xml.XmlNode)Container.DataItem).Attributes["xfn"].Value.Replace(";", " ")%>)
        </td>
        <td style="width:50px">
          <a href="?delete=<%#((System.Xml.XmlNode)Container.DataItem).Attributes["title"].Value %>" onclick="return confirm('Are you sure?')"><%=Resources.labels.delete %></a>
        </td>
      </tr>
    </ItemTemplate>
    <AlternatingItemTemplate>
      <tr class="alt">
        <td>
          <a href="<%#((System.Xml.XmlNode)Container.DataItem).Attributes["xmlUrl"].Value %>"><img src="../../pics/rssButton.gif" alt="RSS feed" /></a>
          <a href="<%#((System.Xml.XmlNode)Container.DataItem).Attributes["htmlUrl"].Value %>"><%#((System.Xml.XmlNode)Container.DataItem).Attributes["title"].Value %></a>
          &nbsp;<%#((System.Xml.XmlNode)Container.DataItem).Attributes["description"].Value %>
          &nbsp;(<%#((System.Xml.XmlNode)Container.DataItem).Attributes["xfn"].Value.Replace(";", " ") %>)
        </td>
        <td style="width:50px">
          <a href="?delete=<%#((System.Xml.XmlNode)Container.DataItem).Attributes["title"].Value %>" onclick="return confirm('Are you sure?')"><%=Resources.labels.delete %></a>
        </td>
      </tr>
    </AlternatingItemTemplate>
    <FooterTemplate>
      </Table>
    </FooterTemplate>
  </asp:Repeater>
  

  
</asp:Content>
