﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Bitrix.UI.BXPublicPage, Main" Title="Руководство" %>

<asp:Content ID="Content1" ContentPlaceHolderID="bxcontent" runat="server" > 

<bx:IncludeComponent 
	id="catalogueelement_list1" 
	runat="server" 
	componentname="bitrix:catalogue.element.list" 
	template="management" 
	IBlockTypeId="" 
	IBlockId="<%$ Options:Bitrix.BankSite:ManagementIBlockId,int %>" 
	SectionId="<%$ Options:Bitrix.BankSite:ManagementIBlockCouncilId,int %>" 
	SectionCode="" 
	FilterByElementCustomProperty="False" 
	ElementCustomPropertyFilterSettings="p:o:0:{};" 
	SortBy="ID" 
	SortOrder="Desc" 
	ShowSubElements="True" 
	ShowAllElementsOnIndex="True" 
	ActiveFilter="Active" 
	ActiveDateFilter="All" 
	Properties="-" 
	AddAdminPanelButtons="False" 
	SetPageTitle="False" 
	SectionElementListUrl="list.aspx?section_id=#SECTION_ID#" 
	ElementDetailUrl="detail.aspx?section_id=#SECTION_ID#&amp;element_id=#ELEMENT_ID#" 
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
	PagingPageID="<%$ Request:page %>" 
	PagingShowAll="<%$ Request:showall %>" 
	PagingIndexTemplate="" 
	PagingPageTemplate="?page=#pageid#" 
	PagingShowAllTemplate="?showall=y" 
	CacheMode="None" 
	CacheDuration="30" 
/> 
 <bx:IncludeComponent 
	 id="IncludeComponent1" 
	 runat="server" 
	 componentname="bitrix:catalogue.element.list" 
	 template="management" 
	 IBlockTypeId="" 
	 IBlockId="<%$ Options:Bitrix.BankSite:ManagementIBlockId,int %>" 
	 SectionId="<%$ Options:Bitrix.BankSite:ManagementIBlockDirectorsId,int %>" 
	 SectionCode="" 
	 FilterByElementCustomProperty="False" 
	 ElementCustomPropertyFilterSettings="p:o:0:{};" 
	 SortBy="ID" 
	 SortOrder="Desc" 
	 ShowSubElements="True" 
	 ShowAllElementsOnIndex="True" 
	 ActiveFilter="Active" 
	 ActiveDateFilter="All" 
	 Properties="-" 
	 AddAdminPanelButtons="False" 
	 SetPageTitle="False" 
	 SectionElementListUrl="list.aspx?section_id=#SECTION_ID#" 
	 ElementDetailUrl="detail.aspx?section_id=#SECTION_ID#&amp;element_id=#ELEMENT_ID#" 
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
	 PagingPageID="<%$ Request:page %>" 
	 PagingShowAll="<%$ Request:showall %>" 
	 PagingIndexTemplate="" 
	 PagingPageTemplate="?page=#pageid#" 
	 PagingShowAllTemplate="?showall=y" 
	 CacheMode="None" 
	 CacheDuration="30" 
 />
 </asp:Content>


