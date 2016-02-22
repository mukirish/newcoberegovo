<%@ Page Language="C#" Inherits="Bitrix.UI.BXPublicPage, Main"                                 Title="Вакансії" %>
<script runat="server" id="@__bx_pagekeywords">
	public override void SetPageKeywords(System.Collections.Generic.IDictionary<string, string> keywords)
	{
		keywords[@"keywords"]=@"";
		keywords[@"description"]=@"";
	}
</script>



<asp:Content runat="server" ContentPlaceHolderID="bxcontent" > 
<script type="text/javascript" src="/bitrix/templates/newco_first_hu/js/jquery.colorbox.js"></script>
 
<div class="vacancy"> 
  <div class="newCo_h1"> 
    <h1>Munkalehetős&eacute;g</h1>
   <img src="/bitrix/templates/newco_first_hu/img/banner.png"  /> </div>
 
  <div class="clear"></div>
 
  <div class="vacancy_top"> <img src="/bitrix/templates/newco_first_hu/img/job.jpg"  /> 
    <p>A &quot;NEWCO Beregovo&quot; Kft felvételt h&iacute;rdet a k&ouml;vetkező munkakörökbe:</p>
   </div>
 
  <div class="clear"></div>
 
<bx:IncludeComponent
 id="newslist1"
 runat="server"
 componentname="bitrix:news.list"
 template="vacancies"
 IBlockId="15"
 PagingRecordsPerPage="20"
 IBlockTypeId="3"
 ShowDetailText="False"
 HideLinkWhenNoDetail="False"
 ActiveDateFormat="dd.MM.yyyy"
 ShowDate="True"
 SetTitle="False"
 ShowTitle="True"
 PreviewTruncateLen=""
 ShowPreviewPicture="True"
 ShowPreviewText="True"
 PropertyCode="'EXPERIENCE';'EDUCATION';'TIMETABLE'"
 SortOrder2="Desc"
 SortOrder1="Desc"
 SortBy2="Sort"
 SortBy1="ActiveFromDate"
 ParentSectionId="0"
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
 PagingTitle="Сторінки"
 PagingPosition="both"
 CacheDuration="31536000"
 CacheMode="Auto"
 /> </div>
 
<div class="vacancy_inf"> 
  <ul> 
    <li></li>
   
    <li></li>
   
    <li><img src="/upload/iblock/Плакат А3_2015.jpg" border="0" width="300" height="424"  /><a href="/upload/iblock/Плакат А3_2015.jpg" >Letöltés</a></li>
   </ul>
 </div>
 	 
<div class="clear"></div>
 
<div class="email"><img src="/bitrix/templates/newco_first_hu/img/mail.png"  />Ha érdekli a munka cég&uuml;nknél, küldje el önéletrajz&aacute;t a következő cimre: <a href="mailto:newco@newcoberegovo.com.ua" >newco@newcoberegovo.com.ua</a></div>
 </asp:Content>
