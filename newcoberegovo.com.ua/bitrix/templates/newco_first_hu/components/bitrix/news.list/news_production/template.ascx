<%@ Reference Control="~/bitrix/components/bitrix/news.list/component.ascx" %>
<%@ Control Language="C#" AutoEventWireup="true" Inherits="NewsListTemplate" %>
<%@ Import namespace="Bitrix" %>
<%@ Import namespace="Bitrix.IBlock" %>
<%@ Import namespace="System.Collections.Generic" %>

<!--Main Block-->
<% foreach (var item in Component.Items) {%>


    <div class="col-xs-4">
            <%// Вывод заглавия (титула)
            if (!String.IsNullOrEmpty(item.Name) && Component.ShowTitle)
            {%>
                <h4><%= item.Name%></h4>
            <%}%>

            <%// Вывод картинки анонса
            if (item.PreviewImage != null && Component.ShowPreviewPicture)
            {
                if (Component.HideLinkWhenNoDetail && !item.DetailText)
                {%>
                    <img class="col-xs-10 col-xs-offset-1" src="<%= item.PreviewImage.FilePath %>" alt="<%= item.PreviewImage.Description %>" />
                <%}
                else
                {
                    string title = HttpUtility.HtmlAttributeEncode(!string.IsNullOrEmpty(item.PreviewImage.Description) ? item.PreviewImage.Description : (item.Name ?? string.Empty));%>
                        <a class="fancybox" href="<%= item.PreviewImage.FilePath %>" title="<%= title %>"><img class="col-xs-10 col-xs-offset-1" src="<%= item.PreviewImage.FilePath %>" alt="<%= title %>" /></a><%
                }
            }%>
    </div><%--col-xs-4--%>
<%}%>


<bx:IncludeComponent runat="server" ID="HeaderPager" ComponentName="bitrix:system.pager" CurrentPosition="top" Template="<%$ Parameters:PagingTemplate %>"/>
