﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Bitrix.UI.BXPublicPage, Main"  Title="Вход на сайт" %>

<asp:Content ID="Content" ContentPlaceHolderID="BXContent" runat="server" > 
<bx:IncludeComponent 
	id="systemauth1" 
	runat="server" 
	componentname="bitrix:system.auth" 
	template="main" 
	ProfilePath="" 
	RegistrationDoAuthentication="False" 
	RegistrationRedirectUrl="" 
	FirstNameFieldMode="require" 
	LastNameFieldMode="require" 
	DisplayNameFieldMode="hide" 
	RegistrationAllow="False" 
	EnableSEF="True" 
	SEFFolder="<%$ Options:Bitrix.CorporateSite:LoginSEFFolder %>" 
	ActionVariable="act" 
	RegisterTemplate="/register/" 
	PasswordRecoveryTemplate="/recovery/" 
	PasswordResetTemplate="/reset/" 
	SendConfirmationRequest="False" 
	UseCaptcha="True" 
	ConfirmationTemplate="/confirmation/" 
/> 
</asp:Content>
