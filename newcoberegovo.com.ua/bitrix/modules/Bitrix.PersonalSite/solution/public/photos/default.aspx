﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Bitrix.UI.BXPublicPage, Main"  Title="Галерея" %>
<asp:Content ID="Content" ContentPlaceHolderID="BXContent" runat="server" >
<bx:IncludeComponent 
	id="Photos" 
	runat="server" 
	componentname="bitrix:photogallery" 
	template="new" 
	IBlockTypeId="" 
	IBlockId="<%$ Options:Bitrix.PersonalSite:PhotosIBlockId,int %>" 
	EnableSEF="True" 
	SEFFolder="<%$ Options:Bitrix.PersonalSite:PhotosSefFolder %>" 
	SEF_Album="/album/#ALBUMID#/" 
	SEF_AlbumEdit="/album/#ALBUMID#/edit" 
	SEF_AlbumAdd="/album/#PARENTID#/add" 
	SEF_Upload="/album/#ALBUMID#/upload" 
	SEF_AlbumPage="/album/#ALBUMID#/page-#PAGEID#" 
	SEF_AlbumShowAll="/album/#ALBUMID#/all" 
	SEF_PhotoEdit="/#PHOTOID#/edit" 
	SEF_Photo="/#PHOTOID#/" 
	ParamAlbum="album" 
	ParamAlbumPage="page" 
	ParamAlbumShowAll="showall" 
	ParamAlbumEdit="AlbumEdit" 
	ParamAlbumAdd="AlbumAdd" 
	ParamPhoto="photo" 
	ParamPhotoEdit="PhotoEdit" 
	ParamSearch="SEARCH" 
	ParamAlbumUpload="Upload" 
	DisplaySearchResults="True" 
	PagingAllow="True" 
	PagingMode="direct" 
	PagingTemplate=".default" 
	PagingShowOne="False" 
	PagingAllowAll="False" 
	PagingRecordsPerPage="10" 
	PagingTitle="Страницы" 
	PagingPosition="bottom" 
	PagingMaxPages="10" 
	PagingMinRecordsInverse="1" 
	CoverWidth="150" 
	CoverHeight="150" 
	PreviewWidth="220" 
	PreviewHeight="220" 
	PhotoWidth="550" 
	PhotoHeight="550" 
	FlickrMode="True" 
	CacheMode="None" 
	CacheDuration="30" 
/>




















 </asp:Content>
