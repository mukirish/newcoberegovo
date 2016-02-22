<%@ Page Language="C#" AutoEventWireup="true" Inherits="Bitrix.UI.BXPublicPage, Main" Title="Задайте вопрос" %>

<asp:Content ID="Content1" ContentPlaceHolderID="bxcontent" runat="server" > 

  <bx:IncludeComponent 
	  id="Feedback" 
	  runat="server" 
	  componentname="bitrix:iblock.element.webform" 
	  template="template1" 
	  IBlockTypeId="" 
	  IBlockId="<%$ Options:Bitrix.BankSite:FeedBackIBlockId,int %>" 
	  ElementId="0" 
	  EditFields="PROPERTY_TOPIC;Name;PROPERTY_EMAIL;PROPERTY_PHONE;DetailText;Captcha" 
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
	  EmailTo="<%$ Options:Bitrix.BankSite:ContactsEmail %>"  
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
	  DetailTextCustomTitle="Сообщение или вопрос" 
	  DetailImageCustomTitle="" 
	  CaptchaCustomTitle="Символы на картинке" 
	  Template_UserCssClass="feedback-form" 
	  Template_ShowAsterisk="False" 
  />
 
 </asp:Content>
