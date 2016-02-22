<%@ Page Language="C#" AutoEventWireup="true" Inherits="Bitrix.UI.BXPublicPage, Main"  Title="Обратная связь" %>
<asp:Content ID="Content" ContentPlaceHolderID="BXContent" runat="server" >
<bx:IncludeComponent 
	id="Feedback" 
	runat="server" 
	componentname="bitrix:iblock.element.webform" 
	template=".default" 
	IBlockTypeId="" 
	IBlockId="<%$ Options:Bitrix.PersonalSite:ContactsFeedbackIBlockId,int %>" 
	ElementId="0" 
	EditFields="Name;PROPERTY_EMAIL;DetailText;Captcha" 
	RequiredFields="Name;DetailText" 
	EnableActivationPeriodProcessing="False" 
	DaysBeforeActivationPeriodStart="0" 
	ActivationPeriodLengthInDays="0" 
	MannerOfUserIdentification="Current" 
	CustomUserId="0" 
	RolesAuthorizedToManage="Guest" 
	RolesAuthorizedToAdminister="" 
	MaxUserElements="0" 
	MannerOfIssueModificationPermission="Active" 
	RolesAuthorizedToManageOfActivation="" 
	ElementActiveAfterSave="Active" 
	MannerOfUserAssociation="CreatedBy" 
	UserAssociatedByCustomIBlockProperty="" 
	MaxSectionSelect="3" 
	OnlyLeafSelect="False" 
	MaxFileSizeUpload="1024" 
	ActiveFromDateShowTime="False" 
	ActiveToDateShowTime="False" 
	NameFieldMacros="" 
	TextBoxSize="30" 
	CreateButtonTitle="Отправить" 
	UpdateButtonTitle="" 
	SuccessMessageAfterCreateElement="Ваше сообщение отправлено" 
	SuccessMessageAfterUpdateElement="" 
	RedirectPageUrl="" 
	SendEmailAfterCreate="True" 
	EmailSubject="#SITE_NAME#: обратная связь" 
	EmailTo="<%$ Options:Bitrix.PersonalSite:ContactsEmail %>" 
	EmailMessageTemplate="Посетитель #Name# написал Вам:

#DetailText#

--------------------
Вы можете ответить ему по адресу: #Property_EMAIL#" 
	ActiveCustomTitle="" 
	NameCustomTitle="Ваше имя" 
	ActiveFromDateCustomTitle="" 
	ActiveToDateCustomTitle="" 
	SectionsCustomTitle="" 
	PreviewTextCustomTitle="" 
	PreviewImageCustomTitle="" 
	DetailTextCustomTitle="Сообщение" 
	DetailImageCustomTitle="" 
	CaptchaCustomTitle="Символы на картинке" 
	Template_UserCssClass="feedback-form" 
	Template_ShowAsterisk="False" 
/>




<h1>Контактная информация</h1>
 
<div class="hr"></div>
 
<ul> 	 
  <li>E-mail: <a href="mailto:19Victoria84@gmail.com">19Victoria84@gmail.com</a>.</li>
  <li>Skype: <a href="callto:Fadeeva_Victoria">Fadeeva_Victoria</a>.</li>
 </ul>
 </asp:Content>