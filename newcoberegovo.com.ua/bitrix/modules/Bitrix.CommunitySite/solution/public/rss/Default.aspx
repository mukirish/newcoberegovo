<%@ Page Language="C#" AutoEventWireup="true" Inherits="Bitrix.UI.BXPublicPage" Title="RSS записей блогов" %>

<asp:Content ID="Content1" ContentPlaceHolderID="bxcontent" runat="server" >
<bx:IncludeComponent 
	id="BlogRss" 
	runat="server" 
	componentname="bitrix:blog.rss" 
	template=".default" 
	FeedTitle="<%$ Options:main:site_name %>" 
	FeedDescription="Последние записи блогов" 
	StuffType="Post" 
	FiltrationType="None" 
	CategoryId="0" 
	BlogSlug="0" 
	PostId="" 
	EnablePostCut="True" 
	ItemQuantity="25" 
	FeedUrlTemplate="<%$ Options:Bitrix.CommunitySite:MainRssPageUrl %>" 
	FeedItemUrlTemplate="<%$ Options:Bitrix.CommunitySite:PostViewUrlTemplate %>" 
	FilterByPostCustomProperty="False" 
	PostCustomPropertyFilterSettings="p:o:0:{};" 
	CacheMode="Auto" 
	CacheDuration="1200" 
	FilterByPostTag="False" 
	PostTagFilterSettings="" />


 </asp:Content>
