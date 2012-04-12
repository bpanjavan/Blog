<%@ Page Language="C#" MasterPageFile="~/admin/admin1.master" AutoEventWireup="true" ValidateRequest="False" CodeFile="Profiles.aspx.cs" Inherits="admin_profiles" Title="Modify Profiles" %>
<%@ Register Src="~/admin/htmlEditor.ascx" TagPrefix="Blog" TagName="TextEditor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphAdmin" runat="Server">
<br />
    <div class="settings" id="dropdown" runat="server">
        
        <h1>
            <%=Resources.labels.userProfiles %>
        </h1>
        <asp:Panel ID="pnlAdmin" runat="server" Visible='<%# User.IsInRole("Administrator") %>'>
            <asp:DropDownList ID="ddlUserList" runat="server" 
                onselectedindexchanged="ddlUserList_SelectedIndexChanged">
            </asp:DropDownList>
            <asp:LinkButton ID="lbChangeUserProfile" runat="server" 
                OnClick="lbChangeUserProfile_Click"><%= Resources.labels.switchUserProfile %></asp:LinkButton>
        </asp:Panel>
        <br />
    </div>
    <br />
    
    <div class="settings" style="padding: 0 10px">
      <br />
      <label for="<%=cbIsPublic.ClientID %>"><%=Resources.labels.isPrivate %></label>
      <asp:CheckBox ID="cbIsPublic" runat="server" />       <br />
       
      <label for="<%=tbDisplayName.ClientID %>"> <%=Resources.labels.displayName %></label>
      <asp:TextBox ID="tbDisplayName" runat="server"></asp:TextBox><br />
      
      <label for="<%=tbFirstName.ClientID %>"> <%=Resources.labels.firstName %></label>
      <asp:TextBox ID="tbFirstName" runat="server"></asp:TextBox><br />
      
      <label for="<%=tbMiddleName.ClientID %>"><%=Resources.labels.middleName %></label>
      <asp:TextBox ID="tbMiddleName" runat="server"></asp:TextBox><br />
      
      <label for="<%=tbLastName.ClientID %>"><%=Resources.labels.lastName %></label>
      <asp:TextBox ID="tbLastName" runat="server"></asp:TextBox>
      <br /><br />    


      <label for="<%=tbPhoneMain.ClientID %>"><%=Resources.labels.phoneMain %></label>
      <asp:TextBox ID="tbPhoneMain" runat="server"></asp:TextBox><br />
      
      <label for="<%=tbPhoneMobile.ClientID %>"><%=Resources.labels.phoneMobile %></label>   <asp:TextBox ID="tbPhoneMobile" runat="server"></asp:TextBox><br />
      
      <label for="<%=tbPhoneFax.ClientID %>"><%=Resources.labels.phoneFax %></label>
      <asp:TextBox ID="tbPhoneFax" runat="server"></asp:TextBox><br />
      
      <label for="<%=tbEmailAddress.ClientID %>"><%=Resources.labels.emailAddress %></label>
      <asp:TextBox ID="tbEmailAddress" runat="server"></asp:TextBox>
      <br /><br />
              

      <label for="<%=tbCityTown.ClientID %>"><%=Resources.labels.cityTown %></label>
      <asp:TextBox ID="tbCityTown" runat="server"></asp:TextBox><br />
      
      <label for="<%=tbRegionState.ClientID %>"><%=Resources.labels.regionState %></label>
      <asp:TextBox ID="tbRegionState" runat="server"></asp:TextBox><br />
      
      <label for="<%=ddlCountry.ClientID %>"><%=Resources.labels.country %></label>
      <asp:DropDownList ID="ddlCountry" runat="server" AutoPostBack="false" />
      <br /><br />
      
      
      <label for="<%=tbCompany.ClientID %>"><%=Resources.labels.company %></label>
      <asp:TextBox runat="server" id="tbCompany" /><br /> 
      
      <label for="<%=tbPhotoUrl.ClientID %>"><%=Resources.labels.photoURL %></label>
      <asp:TextBox ID="tbPhotoUrl" runat="server" Columns="50"></asp:TextBox><br />    
      
      <label for="<%=tbBirthdate.ClientID %>"><%=Resources.labels.birthday %></label>
      <asp:TextBox ID="tbBirthdate" runat="server"></asp:TextBox>
      <asp:CompareValidator runat="server" ControlToValidate="tbBirthdate" Type="date" Operator="datatypecheck" ErrorMessage="Please enter a valid date (yyyy-mm-dd)" />
      <br /><br />
      
      <label for="<%=tbAboutMe.ClientID %>"><%=Resources.labels.aboutMe %></label><br />
      <Blog:TextEditor runat="server" id="tbAboutMe" Rows="5" Width="50px" TextMode="MultiLine"  /><br /> 
    </div>
        
    <p style="text-align:right;"><br />
        <asp:button ID="lbSaveProfile" runat="server" OnClick="lbSaveProfile_Click" />
    </p>
    
</asp:Content>
