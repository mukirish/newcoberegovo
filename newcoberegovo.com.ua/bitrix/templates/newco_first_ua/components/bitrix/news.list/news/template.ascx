<%@ Reference Control="~/bitrix/components/bitrix/news.list/component.ascx" %>
<%@ Control Language="C#" AutoEventWireup="true" Inherits="NewsListTemplate" %>
<%@ Import namespace="Bitrix" %>
<%@ Import namespace="Bitrix.IBlock" %>
<%@ Import namespace="System.Collections.Generic" %>

<!--Main Block-->
<style>
    .media-object.news-img {
        max-width:250px;
    }
</style>
<div class="col-xs-8 col-sm-8 col-md-8 col-lg-8">
    <% foreach (var item in Component.Items) {%>
        <div class="media">
            <div class="media-left media-middle">
                <%// Вывод картинки анонса
                if (item.PreviewImage != null && Component.ShowPreviewPicture)
                {
                    if (Component.HideLinkWhenNoDetail && !item.DetailText)
                    {%>
                        <img class="media-object news-img" src="<%= item.PreviewImage.FilePath %>" alt="<%= item.PreviewImage.Description %>" />
                    <%}
                    else
                    {
                        string title = HttpUtility.HtmlAttributeEncode(!string.IsNullOrEmpty(item.PreviewImage.Description) ? item.PreviewImage.Description : (item.Name ?? string.Empty));%>
                            <a href="<%= item.DetailUrl %>" title="<%= title %>"><img class="media-object news-img" src="<%= item.PreviewImage.FilePath %>" alt="<%= title %>" /></a><%
                    }
                }%>
            </div>
            <div class="media-body">
                <%// Вывод заглавия (титула)
                if (!String.IsNullOrEmpty(item.Name) && Component.ShowTitle)
                {%>
                    <h4><%= item.Name%></h4>
                <%}%>


                <%if (!String.IsNullOrEmpty(item.PreviewText) && Component.ShowPreviewText)
	            {
		            %><%=item.PreviewText%><%
	            }
	            else if (Component.ShowDetailText && item.DetailText)
	            {
		            %><%= item.DetailTextString%><%
	            }
	            %>
            </div><%--media-body--%>
        </div><%--media--%>
    <%}%>
</div>

<bx:IncludeComponent runat="server" ID="HeaderPager" ComponentName="bitrix:system.pager" CurrentPosition="top" Template="<%$ Parameters:PagingTemplate %>"/>
