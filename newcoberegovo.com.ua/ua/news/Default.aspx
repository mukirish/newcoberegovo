<%@ Page Language="C#" Inherits="Bitrix.UI.BXPublicPage, Main" Debug="true" Title="Новини" %>

<script runat="server" id="@__bx_pagekeywords">
    public override void SetPageKeywords(System.Collections.Generic.IDictionary<string, string> keywords)
    {
        keywords[@"keywords"] = @"";
        keywords[@"description"] = @"";
    }
</script>



<asp:content runat="server" contentplaceholderid="bxcontent">
    <div class="container">
    <h3>Hовини <img src="/bitrix/templates/newco_first/img/news_img.png"/></h3>
    

    <div class="page">
        <div class="row">
 
            <bx:IncludeComponent
             id="news1"
             runat="server"
             componentname="bitrix:news"
             template="news"
             IBlockTypeId="2"
             IBlockId="17"
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
             DetailShowPreviewPicture="True"
             DetailShowPreviewText="False"
             DetailShowDate="True"
             DetailActiveDateFormat="dd.MM.yyyy"
             IBlockUrlTitle="Повернутися до списку"
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
             SEFFolder="/ua/news/"
             EnableAjax="False"
             DisplaySearchResults="True"
             PagingMaxPages="10"
             PagingPosition="both"
             PagingAllow="True"
             PagingMode="direct"
             PagingMinRecordsInverse="1"
             PagingShowOne="False"
             PagingAllowAll="True"
             PagingTitle="Pages"
             PagingTemplate=".default"
             CacheDuration="31536000"
             CacheMode="Auto"
             />

            <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
                        <p>
                            <style>
                                #IUAfinance47 {
                                    min-width: 175px;
                                    width: 240px;
                                    cursor: pointer;
                                }

                                    #IUAfinance47 * {
                                        margin: 0;
                                        padding: 0;
                                    }

                                    #IUAfinance47 .content {
                                        overflow: hidden;
                                        padding: 4px;
                                        font-family: Arial;
                                        font-size: 10px;
                                        color: #000000;
                                        background: #f6f6f6;
                                        border: 1px solid #00529c;
                                    }

                                    #IUAfinance47 h1 {
                                        overflow: hidden;
                                        margin-top: -4px;
                                        font-size: 12px;
                                        font-weight: bold;
                                        height: 20px;
                                        line-height: 20px;
                                        color: #00529c;
                                    }

                                        #IUAfinance47 h1 span {
                                            float: left;
                                            white-space: nowrap;
                                        }

                                        #IUAfinance47 h1 i {
                                            float: right;
                                            display: inline-block;
                                            width: 36px;
                                            height: 15px;
                                            background: url(http://i.i.ua/v2/logo/logo_small_14_black.png) no-repeat 0 1px transparent;
                                            opacity: .3;
                                        }

                                    #IUAfinance47 a, #IUAfinance47 a:hover {
                                        border: none;
                                        text-decoration: underline;
                                        color: #00529c;
                                    }

                                    #IUAfinance47 dl {
                                        overflow: hidden;
                                        background: #ffffff;
                                        padding: 4px;
                                        margin-bottom: 4px;
                                    }

                                        #IUAfinance47 dl dt {
                                            font-weight: bold;
                                            font-size: 12px;
                                        }

                                        #IUAfinance47 dl dd {
                                            clear: left;
                                            border-top: 1px dotted #DDD;
                                        }

                                        #IUAfinance47 dl span {
                                            display: block;
                                            float: left;
                                            width: 39%;
                                            white-space: nowrap;
                                            text-align: right;
                                        }

                                            #IUAfinance47 dl span.th {
                                                width: 22%;
                                                text-align: left;
                                            }

                                        #IUAfinance47 dl dt span {
                                            font-size: 10px;
                                            font-weight: normal;
                                        }

                                        #IUAfinance47 dl dd span {
                                            line-height: 24px;
                                            font-size: 20px;
                                            font-family: Trebuchet MS;
                                        }

                                            #IUAfinance47 dl dd span img {
                                                vertical-align: middle;
                                                margin-right: 1px;
                                            }
                            </style>
                            </p><div id="IUAfinance47">
                                <div class="content">
                                    <h1><span><a href="http://finance.i.ua/bank/15/" id="IUAfinance47TitleLink">Курси валют</a> на 01.03.16</span><i></i></h1>
                                    <dl id="IUAfinance47Embed"><dt>Середній курс</dt><dt><span class="th">валюта</span><span>купівля</span><span>продаж</span></dt><dd><span class="th">USD</span><span><img src="http://i3.i.ua/v2/control/arrow_down_red_9.png">26.733</span><span><img src="http://i3.i.ua/v2/control/arrow_down_red_9.png">27.2982</span></dd><dd><span class="th">EUR</span><span><img src="http://i3.i.ua/v2/control/arrow_down_red_9.png">29.0206</span><span><img src="http://i3.i.ua/v2/control/arrow_down_red_9.png">29.8906</span></dd></dl>
                                    <a href="http://finance.i.ua/">Курси долара, євро і рубля по банках</a>
                                </div>
                            </div>
                            <script type="text/javascript">
                                if (typeof (iFinance) == "undefined") {
                                    if (typeof (iFinanceData) == "undefined") {
                                        document.write('<scr' + 'ipt src="http://i.i.ua/js/i/finance_informer.js?1" type="text/javascript" charset = "windows-1251"></scr' + 'ipt>');
                                        iFinanceData = [];
                                    }
                                    iFinanceData.push({ b: 15, c: [840, 978], enc: 0, lang: 1, p: '47' });
                                } else {
                                    window['oiFinance47'] = new iFinance();
                                    window['oiFinance47'].gogo({ b: 15, c: [840, 978], enc: 0, lang: 1, p: '47' });
                                }
                            </script><script src="http://i.i.ua/js/i/finance_informer.js?1" type="text/javascript" charset="windows-1251"></script>
                        <p></p>
                        <p>
                            </p><div id="meteoprog_informer_standart" data-params="none:Beregovo:240x90:white:48x50"><div class="mi mi_240x90 mi_white mi_avatar_none"> <div class="miHeader"> <div class="miCityName"> <a href="http://www.meteoprog.ua/ua/weather/Beregovo/?utm_source=standart&amp;utm_campaign=informers&amp;utm_content=240x90&amp;utm_term=Beregovo" target="_blank"> <span class="todayWeatherIn">Погода в <br> Береговому </span> <span class="todayWeather city-name-lang">Берегове </span> </a> </div> <div class="miLogo"> <a href="http://www.meteoprog.ua/ua/?utm_source=standart&amp;utm_campaign=informers&amp;utm_content=240x90&amp;utm_term=Beregovo" target="_blank"> <img alt="Meteoprog" src="http://www.meteoprog.ua/images/widget/mi240x90logo.png"> </a> </div> </div> <div class="miBody"> <div class="miDay">Зараз</div> <div class="miWeatherIcon"><span class="night-cloud5-rain2-48x50"></span></div><div class="miT"><span class="miT_1">+7°</span></div> </div> <div class="miLinks"><a target="_blank" href="http://www.meteoprog.ua/ua/weather/Lviv/">Погода у Львові</a> <a target="_blank" href="http://www.meteoprog.ua/ua/weather/Odesa/">Погода в Одесі</a></div> <div class="miAvatar"> <a href="http://www.meteoprog.ua/ua/weather/Beregovo/?utm_source=standart&amp;utm_campaign=informers&amp;utm_content=240x90&amp;utm_term=Beregovo" target="_blank"><span class="avatar ava_none_10_rain"></span></a> </div> </div></div>
                            <script src="http://www.meteoprog.ua/ua/weather/informer/standart.js"></script>
                        <p></p>
                        <a class="btn btn-block btn-warning" href="https://www.ukr.net/news/uzhgorod.html" role="button">UKR.NET</a><br>
                        <a class="btn btn-block btn-warning" href="http://www.mukachevo.net/" role="button">MUKACHEVO.NET</a><br>
                        <a class="btn btn-block btn-warning" href="http://beregszasz.com.ua/" role="button">BEREGSZASZ.COM.UA</a>
                    </div>

            </div><%--row--%>
        </div><%--Page--%>
    </div><%--container--%>
</asp:content>
