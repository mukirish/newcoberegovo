<%@ Page Language="C#" Inherits="Bitrix.UI.BXPublicPage, Main" Title="Документация" %>

<script runat="server" id="@__bx_pagekeywords">
    public override void SetPageKeywords(System.Collections.Generic.IDictionary<string, string> keywords)
    {
        keywords[@"keywords"] = @"";
        keywords[@"description"] = @"";
    }
</script>



<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="bxcontent" >
    <div class="container">
        <h3>Документація <img src="/img/cont_img.png"/></h3>
    
        <div class="page">
            <div class="row">
    
            <bx:IncludeComponent
             id="news1"
             runat="server"
             componentname="bitrix:news"
             template="news_documentation"
             IBlockTypeId="7"
             IBlockId="21"
             PagingRecordsPerPage="12"
             SortOrder1="Desc"
             SortOrder2="Desc"
             SortBy1="ActiveFromDate"
             SortBy2="ID"
             IncludeSubsections="True"
             DisplayPanel="False"
             UsePermissions="False"
             GroupPermissions="'Guest'"
             GenerateMenu="False"
             GenerateMenuType="top"
             ShowActiveElements="True"
             ListSetTitle="False"
             ListShowTitle="True"
             PreviewTruncateLen="0"
             ListShowPreviewPicture="True"
             ListShowDetailText="False"
             ListShowPreviewText="True"
             PropertyCode="'DOCUMENTS'"
             HideLinkWhenNoDetail="False"
             ActiveDateFormat="dd.MM.yyyy"
             ListShowDate="True"
             DetailPropertyCode=""
             DetailShowTitle="True"
             DetailSetTitle="True"
             DetailShowDetailPicture="True"
             DetailShowPreviewPicture="True"
             DetailShowPreviewText="False"
             DetailShowDate="True"
             DetailActiveDateFormat="dd.MM.yyyy"
             IBlockUrlTitle="Повернутися до списку"
             UseRss="False"
             RssDaysCount=""
             RssElementsCount="20"
             AllowComments="False"
             CommentsPerPage="5"
             CommentsForumId="0"
             CommentAuthorProfileUrlTemplate=""
             DisplayEmailForGuestComment="True"
             RequireEmailForGuestComment="True"
             DisplayCaptchaForGuestComment="True"
             CommentMaxWordLength="15"
             Sef_Detail_Comment_Operation="/#SectionId#/news-#ElementId#/comment-#CommentId#/act-#Operation#/"
             Sef_Detail_Comment_Read="/#SectionId#/news-#ElementId#/comment-#CommentId#/"
             Sef_Section_ShowAll="/#SectionId#/all"
             Sef_Section_Page="/#SectionId#/page-#pageId#"
             Sef_ShowAll="/all"
             Sef_Page="/page-#pageId#"
             Sef_Rss_Section="/rss/#SectionId#/"
             ParamShowAll="showall"
             ParamPage="page"
             ParamNews="news"
             ParamSection="section"
             Sef_Section="/#SectionId#/"
             Sef_Rss="/rss/"
             Sef_News="/#SectionId#/news-#ElementId#/"
             ParamCommentPage="page"
             ParamCommentOperation="act"
             ParamComment="comment"
             EnableSEF="True"
             Sef_Detail_Comment_Page="/#SectionId#/news-#ElementId#/page-#PageID#/"
             SEFFolder="/ua/documentation/"
             EnableAjax="False"
             DisplaySearchResults="True"
             PagingMaxPages="10"
             PagingPosition="both"
             PagingAllow="True"
             PagingMode="direct"
             PagingMinRecordsInverse="1"
             PagingShowOne="False"
             PagingAllowAll="True"
             PagingTitle="Сторінки"
             PagingTemplate="newco"
             CacheDuration="31536000"
             CacheMode="Auto"
             />

            </div><%--row--%>
        </div><%--Page--%>
    </div><%--container--%>
    <script type="text/javascript">
	$(document).ready(function() {
		$(".fancybox").fancybox();
	});
</script>
</asp:Content>