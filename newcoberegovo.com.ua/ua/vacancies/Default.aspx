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
