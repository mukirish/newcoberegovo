<%@ Reference Control="~/bitrix/components/bitrix/news.list/component.ascx" %>
<%@ Control Language="C#" AutoEventWireup="true" Inherits="NewsListTemplate" %>
<%@ Import namespace="Bitrix" %>
<%@ Import namespace="Bitrix.IBlock" %>
<%@ Import namespace="System.Collections.Generic" %>

<!--Main Block-->
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
    <% foreach (var item in Component.Items) {%>

    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

        <%// Вывод заглавия (титула)
        if (!String.IsNullOrEmpty(item.Name) && Component.ShowTitle)
        {%>
            <h2 style="width:100%;text-align:center;"><%= item.Name%></h2>
        <%}%>
        <%// Вывод картинки анонса
        if (item.PreviewImage != null && Component.ShowPreviewPicture)
        {
            if (Component.HideLinkWhenNoDetail && !item.DetailText)
            {%>
                <img class="col-xs-3" src="<%= item.PreviewImage.FilePath %>" alt="<%= item.PreviewImage.Description %>" />
            <%}
            else
            {
                string title = HttpUtility.HtmlAttributeEncode(!string.IsNullOrEmpty(item.PreviewImage.Description) ? item.PreviewImage.Description : (item.Name ?? string.Empty));%>
                    <a href="<%= item.DetailUrl %>" title="<%= title %>"><img class="col-xs-3" src="<%= item.PreviewImage.FilePath %>" alt="<%= title %>" /></a>
            <%}
        } else {%>
            <div class="col-xs-3"></div>
        <%}%>

        <div class="col-xs-6">
<%--            	if (item.Properties != null)
	{
		%><br /><%
		foreach (KeyValuePair<string, string> kvp in item.Properties)
		{
			if (!String.IsNullOrEmpty(kvp.Value))
			{
				propertyShown = true;
				%><span class="news-element-property"><%= kvp.Key+ ":" %>&nbsp;<span><%= kvp.Value%></span></span> <%
			}
		}
	}--%>
            <%if (!String.IsNullOrEmpty(item.PreviewText) && Component.ShowPreviewText)
	        {
		        %><%=item.PreviewText%><%
	        }
	        else if (Component.ShowDetailText && item.DetailText)
	        {
		        %><%= item.DetailTextString%><%
	        }
	        %>
        </div>
        <%// Вывод картинки анонса
        if (item.PreviewImage != null && Component.ShowPreviewPicture)
        {
            if (Component.HideLinkWhenNoDetail && !item.DetailText)
            {%>
                <img class="col-xs-3" src="<%= item.PreviewImage.FilePath %>" alt="<%= item.PreviewImage.Description %>" />
            <%}
            else
            {
                string title = HttpUtility.HtmlAttributeEncode(!string.IsNullOrEmpty(item.PreviewImage.Description) ? item.PreviewImage.Description : (item.Name ?? string.Empty));%>
                    <a href="<%= item.DetailUrl %>" title="<%= title %>"><img class="col-xs-3" src="<%= item.PreviewImage.FilePath %>" alt="<%= title %>" /></a><%
            }
        }%>
    </div>
    <%}%>
</div>

<bx:IncludeComponent runat="server" ID="HeaderPager" ComponentName="bitrix:system.pager" CurrentPosition="top" Template="<%$ Parameters:PagingTemplate %>"/>
