<%@ Page Language="C#" Inherits="Bitrix.UI.BXPublicPage, Main"     Title="Вакансії" %>
<script runat="server" id="@__bx_pagekeywords">
	public override void SetPageKeywords(System.Collections.Generic.IDictionary<string, string> keywords)
	{
		keywords[@"keywords"]=@"";
		keywords[@"description"]=@"";
	}
</script>



<asp:Content runat="server" ContentPlaceHolderID="bxcontent" > 
<script type="text/javascript" src="/bitrix/templates/newco_first/js/jquery.colorbox.js"></script>
 <img class="cont_bg" src="/bitrix/templates/newco_first/img/arrow.png"  /> 
<div class="vacancy"> 
  <div class="newCo_h1"> 
    <h1>Вакансії</h1>
   <img src="/bitrix/templates/newco_first/img/banner.png"  /> </div>
 
  <div class="clear"></div>
 
  <div class="vacancy_top"> <img src="/bitrix/templates/newco_first/img/job.jpg"  /> 
    <p>Компанія NEWCO, заохочує і вибирає гарний настрій, творчий початок і яскраву індивідуальність. Ми любимо наших співробітників. Ми довіряємо нашим співробітникам. У свою чергу, наші співробітники:</p>
   </div>
 
  <div class="clear"></div>
 
<bx:IncludeComponent
 id="newslist1"
 runat="server"
 componentname="bitrix:news.list"
 template="vacancies"
 IBlockId="18"
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
 PropertyCode="'EDUCATION';'TIMETABLE';'EXPERIENCE'"
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
    <li>мислять поза звичних рамок;</li>
   
    <li>не бояться бути собою;</li>
   
    <li>чесні і дотримуються правил етики;</li>
   
    <li>вміють працювати в команді;</li>
   
    <li>серйозно ставляться до роботи, але вміють сміятися над собою;</li>
   
    <li>готові працювати від світанку до упору;</li>
   
    <li>хочуть брати участь в складних і цікавих проектах;</li>
   
    <li>усміхнені, контактні і пунктуальні;</li>
   
    <li>фізично витривалі і працездатні.</li>
   </ul>
 </div>
 	 
<div class="clear"></div>
 
<div class="email"><img src="/bitrix/templates/newco_first/img/mail.png"  />Якщо Вас цікавить робота в нашій Компанії, обов'язково надішліть своє резюме за адресою <a href="mailto:nyuko@nyukoberegovo.com.ua" >nyuko@nyukoberegovo.com.ua</a></div>
 </asp:Content>
