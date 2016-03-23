<%@ Page Language="C#" Inherits="Bitrix.UI.BXPublicPage, Main" Title="New Page (2)" %>
<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="bxcontent" > 
<bx:IncludeComponent
 id="iblockelement_webform1"
 runat="server"
 componentname="bitrix:iblock.element.webform"
 template="flat"
 IBlockTypeId="3"
 IBlockId="25"
 EditFields="Name;PROPERTY_FILE;PROPERTY_FIRST_NAME;PROPERTY_LAST_NAME;PROPERTY_MID_NAME;PROPERTY_EMAIL;PreviewText;PROPERTY_VACANCY;PROPERTY_PHONE"
 RequiredFields=""
 EnableActivationPeriodProcessing="False"
 DaysBeforeActivationPeriodStart="0"
 ActivationPeriodLengthInDays="0"
 ElementId="0"
 CustomUserId="0"
 MannerOfUserIdentification="Current"
 RolesAuthorizedToAdminister="'Guest'"
 MaxUserElements="0"
 MannerOfIssueModificationPermission="Always"
 RolesAuthorizedToManageOfActivation="'Guest'"
 ElementActiveAfterSave="Active"
 MannerOfUserAssociation="CreatedBy"
 UserAssociatedByCustomIBlockProperty=""
 RolesAuthorizedToManage="'Guest'"
 MaxSectionSelect="3"
 OnlyLeafSelect="False"
 MaxFileSizeUpload="1024"
 ActiveFromDateShowTime="False"
 ActiveToDateShowTime="False"
 NameFieldMacros="#DetailText#-#DateCreate#-#CreatedBy#"
 TextBoxSize="30"
 UpdateButtonTitle="Save"
 SuccessMessageAfterCreateElement="Element has been created successfully."
 SuccessMessageAfterUpdateElement="Element has been updated successfully."
 RedirectPageUrl=""
 CreateButtonTitle="Add"
 SendEmailAfterCreate="False"
 EmailSubject="#SITE_NAME#: new element in #IBlockName#"
 EmailTo=""
 EmailMessageTemplate="

     

A user #CurrentUserName#

has added a new element to &quot;#IBlockName#&quot;.

New element properties:

 Name: #Name#,

 Preview text:#PreviewText#,

 Full text:#DetailText#

 Active state: #Active#

 Active period: #ActiveFromDate# through #ActiveToDate#

 Small image:

 #PreviewImageUrl#

 Full image link:

 #DetailImageUrl#

 INFO property (must exist):

 #Property_INFO#"
 CaptchaCustomTitle=""
 NameCustomTitle=""
 ActiveFromDateCustomTitle=""
 ActiveToDateCustomTitle=""
 SectionsCustomTitle=""
 PreviewTextCustomTitle=""
 PreviewImageCustomTitle=""
 DetailTextCustomTitle=""
 DetailImageCustomTitle=""
 ActiveCustomTitle=""
 /> </asp:Content>
