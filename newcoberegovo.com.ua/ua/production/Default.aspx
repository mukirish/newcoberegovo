<%@ Page Language="C#" Inherits="Bitrix.UI.BXPublicPage, Main" Title="Продукція" %>

<script runat="server" id="@__bx_pagekeywords">
    public override void SetPageKeywords(System.Collections.Generic.IDictionary<string, string> keywords)
    {
        keywords[@"keywords"] = @"";
        keywords[@"description"] = @"";
    }
</script>



<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="bxcontent" > 
    <div class="container">
        <h3>Продукція <img src="/bitrix/templates/newco_first/img/banner.png" /></h3>
 
    <div class="page">
        <div class="row">
 
            <bx:IncludeComponent
             id="news1"
             runat="server"
             componentname="bitrix:news"
             template="news_production"
             IBlockTypeId="1"
             IBlockId="16"
             PagingRecordsPerPage="20"
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
             PropertyCode=""
             HideLinkWhenNoDetail="False"
             ActiveDateFormat="dd.MM.yyyy"
             ListShowDate="True"
             DetailPropertyCode=""
             DetailShowTitle="True"
             DetailSetTitle="True"
             DetailShowDetailPicture="True"
             DetailShowPreviewPicture="False"
             DetailShowPreviewText="False"
             DetailShowDate="True"
             DetailActiveDateFormat="dd.MM.yyyy"
             IBlockUrlTitle="Повернутися до списку продуктів"
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
             Sef_Detail_Comment_Operation="/#SectionId#/product-#ElementId#/comment-#CommentId#/act-#Operation#/"
             Sef_Detail_Comment_Read="/#SectionId#/product-#ElementId#/comment-#CommentId#/"
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
             Sef_News="/#SectionId#/product-#ElementId#/"
             ParamCommentPage="page"
             ParamCommentOperation="act"
             ParamComment="comment"
             EnableSEF="True"
             Sef_Detail_Comment_Page="/#SectionId#/product-#ElementId#/page-#PageID#/"
             SEFFolder="/ua/production/"
             EnableAjax="False"
             DisplaySearchResults="True"
             PagingMaxPages="10"
             PagingPosition="both"
             PagingAllow="True"
             PagingMode="direct"
             PagingMinRecordsInverse="1"
             PagingShowOne="False"
             PagingAllowAll="False"
             PagingTitle="Сторінки"
             PagingTemplate=".default"
             CacheDuration="31536000"
             CacheMode="Auto"
             />            

            </div><%--row--%>
        </div><%--Page--%>
    </div><%--container--%> 
</asp:Content>