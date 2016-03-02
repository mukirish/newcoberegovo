﻿<%@ Page Language="C#" Inherits="Bitrix.UI.BXPublicPage, Main" Title="Ласкаво просимо на сайт" %>
<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="bxcontent" > 
<div class="column"> 
  <h1>Про компанію</h1>
 
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
 ParentSectionId="17"
 IncludeSubsections="True"
 ShowActiveElements="True"
 GroupPermissions=""
 UsePermissions="False"
 DisplayPanel="False"
 DetailUrl="/ua/about_us/"
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
 /> </div>
 
<div class="column"> 
  <h1>новини</h1>
 
<bx:IncludeComponent
 id="newslist2"
 runat="server"
 componentname="bitrix:news.list"
 template="news_main"
 IBlockId="17"
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
 ParentSectionId="0"
 IncludeSubsections="True"
 ShowActiveElements="True"
 GroupPermissions="'Guest'"
 UsePermissions="False"
 DisplayPanel="False"
 DetailUrl="/ua/news/#SectionId#/news-#ElementId#"
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
 /> <a class="butt" href="/ua/news" title="Перехід на сторінку новин" ><span>Всі новини</span></a> </div>
 
<div class="column last_c"> 
  <h1>продукція</h1>
 
<bx:IncludeComponent
 id="IncludeComponent1"
 runat="server"
 componentname="bitrix:news.list"
 template="news_main"
 IBlockId="16"
 PagingRecordsPerPage="3"
 IBlockTypeId="1"
 ShowDetailText="False"
 HideLinkWhenNoDetail="False"
 ActiveDateFormat="dd.MM.yyyy"
 ShowDate="False"
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
 ParentSectionId="0"
 IncludeSubsections="True"
 ShowActiveElements="True"
 GroupPermissions=""
 UsePermissions="False"
 DisplayPanel="False"
 DetailUrl="/ua/production/#SectionId#/product-#ElementId#/"
 PagingMinRecordsInverse="1"
 PagingMaxPages="10"
 PagingAllow="True"
 PagingMode="direct"
 PagingTemplate=".default"
 PagingShowOne="False"
 PagingAllowAll="False"
 PagingTitle="Страницы"
 PagingPosition="both"
 CacheDuration="31536000"
 CacheMode="Auto"
 /> <a class="butt" href="/ua/production" title="Перехід на сторінку продукції" ><span>Продукція</span></a> </div>
 
<div class="clear"></div>
 </asp:Content>