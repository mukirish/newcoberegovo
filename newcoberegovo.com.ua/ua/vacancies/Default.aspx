<%@ Page Language="C#" Inherits="Bitrix.UI.BXPublicPage, Main"     Title="Вакансії" %>
<script runat="server" id="@__bx_pagekeywords">
	public override void SetPageKeywords(System.Collections.Generic.IDictionary<string, string> keywords)
	{
		keywords[@"keywords"]=@"";
		keywords[@"description"]=@"";
	}
</script>



<asp:Content runat="server" ContentPlaceHolderID="bxcontent" > 
    <div class="container">

    <h3>Вакансії <img src="/img/banner.png"/></h3>
 
        
        
<bx:IncludeComponent
 id="iblockelement_webform1"
 runat="server"
 componentname="bitrix:iblock.element.webform"
 template="modal"
 IBlockTypeId="3"
 IBlockId="25"
 EditFields="Name;PROPERTY_FILE;PROPERTY_FIRST_NAME;PROPERTY_LAST_NAME;PROPERTY_EMAIL;PreviewText;PROPERTY_VACANCY;PROPERTY_PHONE"
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
 />
        
        
        

    <div class="page">
        <div class="row">
            <bx:IncludeComponent
             id="newslist1"
             runat="server"
             componentname="bitrix:news.list"
             template="vacancies"
             IBlockId="18"
             PagingRecordsPerPage="20"
             IBlockTypeId="3"
             ShowDetailText="False"
             HideLinkWhenNoDetail="False"
             ActiveDateFormat="dd.MM.yyyy"
             ShowDate="True"
             SetTitle="False"
             ShowTitle="True"
             PreviewTruncateLen=""
             ShowPreviewPicture="True"
             ShowPreviewText="True"
             PropertyCode="'EDUCATION';'TIMETABLE';'EXPERIENCE'"
             SortOrder2="Desc"
             SortOrder1="Desc"
             SortBy2="Sort"
             SortBy1="ActiveFromDate"
             ParentSectionId="0"
             IncludeSubsections="True"
             ShowActiveElements="True"
             GroupPermissions=""
             UsePermissions="False"
             DisplayPanel="False"
             DetailUrl="NewsDetail.aspx?id=#ELEMENT_ID#"
             PagingMinRecordsInverse="1"
             PagingMaxPages="10"
             PagingAllow="True"
             PagingMode="direct"
             PagingTemplate=".default"
             PagingShowOne="False"
             PagingAllowAll="False"
             PagingTitle="Сторінки"
             PagingPosition="both"
             CacheDuration="31536000"
             CacheMode="Auto"
             />
 
            </div><%--row--%>
        </div><%--Page--%>
    </div><%--container--%>
</asp:Content>
