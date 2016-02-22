<%@ Page Language="C#" Inherits="Bitrix.UI.BXPublicPage, Main"  Title="About us" %>
<script runat="server" id="@__bx_pagekeywords">
	public override void SetPageKeywords(System.Collections.Generic.IDictionary<string, string> keywords)
	{
		keywords[@"keywords"]=@"";
		keywords[@"description"]=@"";
	}
</script>



<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="bxcontent" > 
<div class="newCo_h1"> 
  <h1>R&oacute;lunk</h1>
 <img src="/bitrix/templates/newco_first/img/news_img.png"  /> 
  <div class="clear"></div>
 </div>
 
<bx:IncludeComponent
 id="newsdetail1"
 runat="server"
 componentname="bitrix:news.detail"
 template=".default"
 IBlockTypeId="5"
 ElementId="17"
 IBlockId="8"
 SetTitle="False"
 ShowTitle="True"
 ShowDetailPicture="True"
 ShowPreviewText="False"
 ShowPreviewPicture="False"
 ShowActiveElements="True"
 ShowDate="True"
 ActiveDateFormat="dd.MM.yyyy"
 DisplayPanel="False"
 PropertyCode=""
 UsePermissions="False"
 GroupPermissions=""
 IBlockUrl=""
 IBlockUrlTitle=""
 CacheMode="Auto"
 CacheDuration="31536000"
 /> </asp:Content>
