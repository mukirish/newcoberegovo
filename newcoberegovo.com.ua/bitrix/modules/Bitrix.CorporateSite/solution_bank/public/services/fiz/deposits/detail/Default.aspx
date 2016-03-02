﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Bitrix.UI.BXPublicPage, Main" %>
<asp:Content ID="Content1" ContentPlaceHolderID="bxcontent" runat="server" > 
 
<bx:IncludeComponent 
	id="catalogue1" 
	runat="server" 
	componentname="bitrix:catalogue" 
	template="template1" 
	IBlockTypeId="" 
	IBlockId="<%$ Options:Bitrix.BankSite:DepositsIblockId,int %>" 
	AddAdminPanelButtons="False" 
	SetPageTitle="True" 
	RootSectionTitle="" 
	GenerateMenu="False" 
	GenerateMenuType="main" 
	EnableVotingForElement="False" 
	RolesAuthorizedToVote="User" 
	AllowComments="False" 
	CommentsPerPage="5" 
	CommentsForumId="0" 
	CommentAuthorProfileUrlTemplate="" 
	DisplayEmailForGuestComment="True" 
	RequireEmailForGuestComment="True" 
	DisplayCaptchaForGuestComment="True" 
	CommentMaxWordLength="15" 
	EnableSEF="True" 
	SEFFolder="<%$ Options:Bitrix.BankSite:DepositsSefFolder %>"  
	SectionIdVariable="section_id" 
	ElementIdVariable="element_id" 
	PageIdVariable="page" 
	ShowAllVariable="showall" 
	CommentVariable="comment" 
	CommentOperationVariable="act" 
	CommentPageVariable="page" 
	ElementDetailTemplate="/deposit-#ElementId#/" 
	ElementListTemplate="" 
	CommonListPageTemplate="/page-#pageId#" 
	CommonListShowAllTemplate="/all" 
	SectionListPageTemplate="/page-#pageId#" 
	SectionListShowAllTemplate="/all" 
	ElementDetailCommentReadTemplate="/deposit-#ElementId#/comment-#CommentId#/" 
	ElementDetailCommentOperationTemplate="/deposit-#ElementId#/comment-#CommentId#/act-#Operation#/" 
	ElementDetailCommentPageTemplate="/deposit-#ElementId#/page-#PageID#/" 
	EnableAjax="False" 
	DisplaySearchResults="True" 
	ListSortBy="ID" 
	ListSortOrder="Desc" 
	ShowSubElements="True" 
	ShowAllElementsOnIndex="True" 
	ActiveFilter="Active" 
	ActiveDateFilter="All" 
	ListProperties="RATE;FILL;FOREIGNCUR;MINSUM;PERCENTCALC;FOR_WHO" 
	DetailProperties="RATE;FILL;FOREIGNCUR;MINSUM;PERCENTCALC;MINDAYS;MAXDAYS;FOR_WHO" 
	PropertyKeywords="-" 
	PropertyDescription="-" 
	DepthLevel="2" 
	ShowCounters="False" 
	IncludeParentSections="True" 
	ShowTopElements="False" 
	TopElementCount="6" 
	TopSortBy="ID" 
	TopSortOrder="Desc" 
	TopProperties="-" 
	PagingAllow="True" 
	PagingMode="direct" 
	PagingTemplate=".default" 
	PagingShowOne="False" 
	PagingAllowAll="False" 
	PagingRecordsPerPage="10" 
	PagingTitle="Страницы" 
	PagingPosition="both" 
	PagingMaxPages="10" 
	PagingMinRecordsInverse="1" 
	CacheMode="None" 
	CacheDuration="30" 
/> </asp:Content>
