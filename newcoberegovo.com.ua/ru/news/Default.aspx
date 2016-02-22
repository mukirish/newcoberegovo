<%@ Page Language="C#" Inherits="Bitrix.UI.BXPublicPage, Main"                                                                                   Title="Новости" %>
<script runat="server" id="@__bx_pagekeywords">
	public override void SetPageKeywords(System.Collections.Generic.IDictionary<string, string> keywords)
	{
		keywords[@"keywords"]=@"";
		keywords[@"description"]=@"";
	}
</script>



<asp:Content runat="server" ContentPlaceHolderID="bxcontent" > 
<div class="newCo_h1"> 
  <h1>Новини   <img src="/bitrix/templates/newco_first/img/news_img.png"  />      </h1>
            
  <table border="0" cellpadding="1" cellspacing="1" style="border-collapse: collapse;" align="right"> 
    <tbody> 
      <tr><td> <iframe width="300" height="130" fram'+'eborder="0" src="http://informer.minfin.com.ua/gen/course/?color=yellow" vspace="0" scrolling="no" hspace="0" allowtransparency="true" style="width: 300px; height: 130px; float: right;"></iframe></td> <td></td><td> 
          <div id="SinoptikInformer" style="width: 350px; float: left;" class="SinoptikInformer type5c1"> 
            <div class="siHeader"> 
              <div class="siLh"> 
                <div class="siMh"><a onmousedown="siClickCount();" href="https://ua.sinoptik.ua/" target="_blank" >Погода</a><a onmousedown="siClickCount();" class="siLogo" href="https://ua.sinoptik.ua/" target="_blank" > </a> <span id="siHeader"></span></div>
               </div>
             </div>
           
            <div class="siBody"> 
              <table style="border-collapse: collapse;"> 
                <tbody> 
                  <tr><td class="siCityV" style="width: 100%; float: left;"> 
                      <div class="siCityName"><a onmousedown="siClickCount();" href="https://ua.sinoptik.ua/погода-берегове" target="_blank" >Погода у <span>Берегово</span></a></div>
                     </td></tr>
                 
                  <tr><td style="width: 100%; float: left;"> 
                      <div class="siCityV2"> 
                        <div id="siCont0" class="siBodyContent"> 
                          <div class="siLeft"> 
                            <div class="siTerm"></div>
                           
                            <div class="siT" id="siT0"></div>
                           
                            <div id="weatherIco0"></div>
                           </div>
                         
                          <div class="siInf"> 
                            <p>вологість: <span id="vl0"></span></p>
                           
                            <p>тиск: <span id="dav0"></span></p>
                           
                            <p>вітер: <span id="wind0"></span></p>
                           </div>
                         </div>
                       </div>
                     </td></tr>
                 </tbody>
               </table>
             
              <div class="siFooter"> 
                <div class="siLf"> 
                  <div class="siMf"></div>
                 </div>
               </div>
             </div>
           
<script type="text/javascript" charset="UTF-8" src="//sinoptik.ua/informers_js.php?title=4&amp;wind=2&amp;cities=303001369&amp;lang=ua"></script>
 </div>
         </td><td></td></tr>
     </tbody>
   </table>
          
  <div class="clear"></div>
 </div>
 
<bx:IncludeComponent
 id="news1"
 runat="server"
 componentname="bitrix:news"
 template="news"
 IBlockTypeId="2"
 IBlockId="1"
 PagingRecordsPerPage="12"
 SortOrder1="Desc"
 SortOrder2="Desc"
 SortBy1="ActiveFromDate"
 SortBy2="ID"
 IncludeSubsections="True"
 DisplayPanel="False"
 UsePermissions="False"
 GroupPermissions="'Guest'"
 GenerateMenu="False"
 GenerateMenuType="top"
 ShowActiveElements="True"
 ListSetTitle="False"
 ListShowTitle="True"
 PreviewTruncateLen="0"
 ListShowPreviewPicture="True"
 ListShowDetailText="False"
 ListShowPreviewText="True"
 PropertyCode=""
 HideLinkWhenNoDetail="False"
 ActiveDateFormat="dd.MM.yyyy"
 ListShowDate="True"
 DetailPropertyCode=""
 DetailShowTitle="True"
 DetailSetTitle="True"
 DetailShowDetailPicture="True"
 DetailShowPreviewPicture="False"
 DetailShowPreviewText="False"
 DetailShowDate="True"
 DetailActiveDateFormat="dd.MM.yyyy"
 IBlockUrlTitle="Вернуться в список новостей"
 UseRss="False"
 RssDaysCount=""
 RssElementsCount="20"
 AllowComments="False"
 CommentsPerPage="5"
 CommentsForumId="0"
 CommentAuthorProfileUrlTemplate=""
 DisplayEmailForGuestComment="True"
 RequireEmailForGuestComment="True"
 DisplayCaptchaForGuestComment="True"
 CommentMaxWordLength="15"
 Sef_Detail_Comment_Operation="/#SectionId#/news-#ElementId#/comment-#CommentId#/act-#Operation#/"
 Sef_Detail_Comment_Read="/#SectionId#/news-#ElementId#/comment-#CommentId#/"
 Sef_Section_ShowAll="/#SectionId#/all"
 Sef_Section_Page="/#SectionId#/page-#pageId#"
 Sef_ShowAll="/all"
 Sef_Page="/page-#pageId#"
 Sef_Rss_Section="/rss/#SectionId#/"
 ParamShowAll="showall"
 ParamPage="page"
 ParamNews="news"
 ParamSection="section"
 Sef_Section="/#SectionId#/"
 Sef_Rss="/rss/"
 Sef_News="/#SectionId#/news-#ElementId#/"
 ParamCommentPage="page"
 ParamCommentOperation="act"
 ParamComment="comment"
 EnableSEF="True"
 Sef_Detail_Comment_Page="/#SectionId#/news-#ElementId#/page-#PageID#/"
 SEFFolder="/ru/news/"
 EnableAjax="False"
 DisplaySearchResults="True"
 PagingMaxPages="10"
 PagingPosition="both"
 PagingAllow="True"
 PagingMode="direct"
 PagingMinRecordsInverse="1"
 PagingShowOne="False"
 PagingAllowAll="True"
 PagingTitle="Страницы"
 PagingTemplate=".default"
 CacheDuration="31536000"
 CacheMode="Auto"
 /> </asp:Content>