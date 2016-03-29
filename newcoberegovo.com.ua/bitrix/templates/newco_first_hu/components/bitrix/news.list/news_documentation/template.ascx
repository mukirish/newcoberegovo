<%@ Reference Control="~/bitrix/components/bitrix/news.list/component.ascx" %>
<%@ Control Language="C#" AutoEventWireup="true" Inherits="NewsListTemplate" %>
<%@ Import namespace="Bitrix" %>
<%@ Import namespace="Bitrix.IBlock" %>
<%@ Import namespace="System.Collections.Generic" %>

<!--Main Block-->
<div class="col-xs-12">
    <% foreach (var item in Component.Items) {%>
    <div class="col-xs-12 col-md-12 col-lg-12 doc">
            <%// Вывод картинки анонса
            if (item.PreviewImage != null && Component.ShowPreviewPicture)
            {
                string title = HttpUtility.HtmlAttributeEncode(!string.IsNullOrEmpty(item.PreviewImage.Description) ? item.PreviewImage.Description : (item.Name ?? string.Empty));%>
                    <a class="fancybox" href="<%= item.PreviewImage.FilePath %>" title="<%= title %>"><%= title %></a><%
            }%>
    </div>
    <%}%>
</div>

<bx:IncludeComponent runat="server" ID="HeaderPager" ComponentName="bitrix:system.pager" CurrentPosition="top" Template="<%$ Parameters:PagingTemplate %>"/>
