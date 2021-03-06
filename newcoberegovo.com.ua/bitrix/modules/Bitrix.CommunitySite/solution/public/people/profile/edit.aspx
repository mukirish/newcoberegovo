﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Bitrix.UI.BXPublicPage, Main" Title="Настройки профиля" EnableCsrfValidation="False" %>

<script runat="server">
	protected override void OnLoad(EventArgs e)
	{
		base.OnLoad(e);
		MasterTitleHtml = "";
	}
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="bxcontent" runat="server">

<bx:IncludeComponent 
	id="UserProfileEdit" 
	runat="server" 
	componentname="bitrix:user.profile.edit" 
	template="fieldset" 
	UserId="<%$ Request:user %>" 
	EditFields="@Личные данные;DisplayName;FirstName;LastName;Image;Gender;BirthdayDate;Property_OCCUPATION;Property_REGION;Property_ABOUT;BitrixForum_Signature;@Контактная информация;Property_URL;Property_TWITTER;Property_SKYPE;Property_INTERESTS;Property_MSN;Property_ICQ;Property_GTALK;Property_JABBER;@Пароль;Password" 
	RequiredFields="" 
	RedirectPageUrl="" 
	ProfileUrlTemplate="<%$ Options:Bitrix.CommunitySite:UserProfileUrlTemplate %>" 
	SuccessMessage="" />

</asp:Content>