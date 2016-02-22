<%@ Page Language="C#" AutoEventWireup="true" Inherits="Bitrix.UI.BXPublicPage, Main"     Title="Поиск" %>
<script runat="server" id="@__bx_pagekeywords">
	public override void SetPageKeywords(System.Collections.Generic.IDictionary<string, string> keywords)
	{
		keywords[@"keywords"]=@"";
		keywords[@"description"]=@"";
	}
</script>



<asp:Content ID="Content1" ContentPlaceHolderID="BXContent" runat="server" >
<bx:IncludeComponent
 id="searchpage2"
 runat="server"
 componentname="bitrix:search.page"
 template=".default"
 SearchFilter=""
 ParamSearch="q"
 ParamPage="page"
 ParamWhere="where"
 ParamTags="tags"
 HighlightDiameter="200"
 ShowFilter="False"
 ShowFilterItems=""
 ShowTags="NotRejected"
 MaxChars="500"
 PagingAllow="True"
 PagingMode="direct"
 PagingTemplate=".default"
 PagingShowOne="False"
 PagingRecordsPerPage="10"
 PagingTitle="Страницы"
 PagingPosition="both"
 PagingMaxPages="10"
 PagingMinRecordsInverse="1"
 Template_NarrowSearch="True"
 Template_PagingRecordsPerPage="10"
 Template_SizeDistribution="Exponential"
 Template_SizeMin="10"
 Template_SizeMax="50"
 Template_ColorDistribution="None"
 Template_ColorMin=""
 Template_ColorMax=""
 />  </asp:Content>

