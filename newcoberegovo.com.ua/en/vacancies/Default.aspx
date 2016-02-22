<%@ Page Language="C#" Inherits="Bitrix.UI.BXPublicPage, Main"  Title="Vacancies" %>
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
    <h1>Vacancies</h1>
    <img src="/bitrix/templates/newco_first/img/banner.png"/>
  </div>
 
  <div class="clear"></div>
 
  <div class="vacancy_top"> <img src="/bitrix/templates/newco_first/img/job.jpg"  /> 
    <p>The NEWCO company encourages and selects good humor, creativity and a great personality. We love our employees. We trust our employees. In turn, our employees:</p>
   </div>
 
   <div class="clear"></div>
 
   <bx:IncludeComponent
     id="newslist1"
     runat="server"
     componentname="bitrix:news.list"
     template="vacancies"
     IBlockId="11"
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
     PagingTitle="Pages"
     PagingPosition="both"
     CacheDuration="31536000"
     CacheMode="Auto"
     />
 </div>
 
<div class="vacancy_inf"> 
    <ul> 
        <li>think outside the usual framework;</li>
        <li>not afraid to be themselves;</li>
        <li>honest and follow the rules of ethics;</li>
        <li>able to work in a team;</li>
        <li>serious about the job, but able to laugh at themselves;</li>
        <li>willing to work from dawn to stop;</li>
        <li>want to participate in a challenging and interesting projects;</li>
        <li>smiling, contact and punctual;</li>
        <li>physically hardy and able-bodied.</li>
    </ul>
 </div>
 	 
<div class="clear"></div>
<div class="email"><img src="/bitrix/templates/newco_first/img/mail.png"  />If you are interested in working in our company, be sure to send your resume to <a href="mailto:nyuko@nyukoberegovo.com.ua">nyuko@nyukoberegovo.com.ua</a></div>
</asp:Content>