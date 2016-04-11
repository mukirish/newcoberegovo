<%@ Page Language="C#" Inherits="Bitrix.UI.BXPublicPage, Main" Title="Добро пожаловать на сайт" %>
<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="bxcontent" > 

<div class="wrap">
    <div class="container">
        <!--Carousel-->
            <bx:IncludeComponent
            id="IncludeComponent2"
            runat="server"
            componentname="bitrix:news.list"
            template="slider_main"
            IBlockId="7"
            PagingRecordsPerPage="20"
            IBlockTypeId="12"
            ShowDetailText="False"
            HideLinkWhenNoDetail="False"
            ActiveDateFormat="dd.MM.yyyy"
            ShowDate="True"
            SetTitle="False"
            ShowTitle="False"
            PreviewTruncateLen=""
            ShowPreviewPicture="True"
            ShowPreviewText="True"
            PropertyCode=""
            SortOrder2="Desc"
            SortOrder1="Desc"
            SortBy2="Sort"
            SortBy1="ActiveFromDate"
            ParentSectionId="16"
            IncludeSubsections="True"
            ShowActiveElements="True"
            GroupPermissions="1"
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
            PagingTitle="Oldalak"
            PagingPosition="both"
            CacheDuration="31536000"
            CacheMode="Auto"
            />
    </div>
</div>

<div class="container">

    <!--Content-->
    <div class="row" style="margin-left:0">
        <!--Sidebar-->
        <bx:IncludeComponent
 id="IncludeComponent1"
 runat="server"
 componentname="bitrix:news.list"
 template="news_left"
 IBlockId="14"
 PagingRecordsPerPage="3"
 IBlockTypeId="2"
 ShowDetailText="False"
 HideLinkWhenNoDetail="False"
 ActiveDateFormat="dd.MM.yyyy"
 ShowDate="True"
 SetTitle="False"
 ShowTitle="True"
 PreviewTruncateLen=""
 ShowPreviewPicture="True"
 ShowPreviewText="True"
 PropertyCode=""
 SortOrder2="Desc"
 SortOrder1="Desc"
 SortBy2="Sort"
 SortBy1="ActiveFromDate"
 IncludeSubsections="True"
 ShowActiveElements="True"
 GroupPermissions=""
 UsePermissions="False"
 DisplayPanel="False"
 DetailUrl="/hu/news/#SectionId#/news-#ElementId#/"
 PagingMinRecordsInverse="1"
 PagingMaxPages="10"
 PagingAllow="True"
 PagingMode="direct"
 PagingTemplate=".default"
 PagingShowOne="False"
 PagingAllowAll="False"
 PagingTitle="Oldalak"
 PagingPosition="both"
 CacheDuration="31536000"
 CacheMode="Auto"
 />


<bx:IncludeComponent
 id="newslist1"
 runat="server"
 componentname="bitrix:news.list"
 template="news_main"
 IBlockId="8"
 PagingRecordsPerPage="3"
 IBlockTypeId="5"
 ShowDetailText="False"
 HideLinkWhenNoDetail="False"
 ActiveDateFormat="dd.MM.yyyy"
 ShowDate="True"
 SetTitle="False"
 ShowTitle="True"
 PreviewTruncateLen=""
 ShowPreviewPicture="True"
 ShowPreviewText="True"
 PropertyCode=""
 SortOrder2="Desc"
 SortOrder1="Desc"
 SortBy2="Sort"
 SortBy1="ActiveFromDate"
 ParentSectionId="10"
 IncludeSubsections="True"
 ShowActiveElements="True"
 GroupPermissions=""
 UsePermissions="False"
 DisplayPanel="False"
 DetailUrl="/hu/about_us/"
 PagingMinRecordsInverse="1"
 PagingMaxPages="10"
 PagingAllow="True"
 PagingMode="direct"
 PagingTemplate=".default"
 PagingShowOne="False"
 PagingAllowAll="False"
 PagingTitle="Oldalak"
 PagingPosition="both"
 CacheDuration="31536000"
 CacheMode="Auto"
 />
    </div>   
</div>

 </asp:Content>


