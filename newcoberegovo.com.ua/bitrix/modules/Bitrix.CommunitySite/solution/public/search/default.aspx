<%@ Page Language="C#" AutoEventWireup="true" Inherits="Bitrix.UI.BXPublicPage, Main" Title="Поиск по сайту" %>

<asp:Content ID="Content1" ContentPlaceHolderID="bxcontent" runat="server" >

<bx:IncludeComponent 
	id="searchpage1" 
	runat="server" 
	componentname="bitrix:search.page" 
	template=".default" 
	SearchFilter="" 
	MaxChars="500" 
	HighlightDiameter="200" 
	ShowFilter="False" 
	ShowFilterItems="" 
	ShowTags="NotRejected" 
	ParamSearch="q" 
	ParamPage="page" 
	ParamWhere="where" 
	ParamTags="tags" 
	PagingAllow="True" 
	PagingMode="direct" 
	PagingTemplate=".default" 
	PagingShowOne="False" 
	PagingRecordsPerPage="15" 
	PagingTitle="Страницы" 
	PagingPosition="bottom" 
	PagingMaxPages="10" 
	PagingMinRecordsInverse="1" 
/> 

</asp:Content>
