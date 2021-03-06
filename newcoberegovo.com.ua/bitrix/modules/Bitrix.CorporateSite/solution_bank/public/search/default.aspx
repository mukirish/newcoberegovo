﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Bitrix.UI.BXPublicPage, Main"  Title="Поиск" %>

<asp:Content ID="Content1" ContentPlaceHolderID="BXContent" runat="server" >

<bx:IncludeComponent 
	id="searchpage1" 
	runat="server" 
	componentname="bitrix:search.page" 
	template="bank_search" 
	SearchFilter="" 
	ParamSearch="q" 
	ParamPage="page" 
	ParamWhere="where" 
	ParamTags="tags" 
	MaxChars="500" 
	HighlightDiameter="200" 
	ShowFilter="False" 
	ShowFilterItems="" 
	ShowTags="NotRejected" 
	PagingAllow="True" 
	PagingMode="direct" 
	PagingTemplate="catalog" 
	PagingShowOne="False" 
	PagingRecordsPerPage="5" 
	PagingTitle="Страницы:" 
	PagingPosition="bottom" 
	PagingMaxPages="10" 
	PagingMinRecordsInverse="1" 
/>

 </asp:Content>

