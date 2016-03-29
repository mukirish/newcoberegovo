<%@ Reference Control="~/bitrix/components/bitrix/news.list/component.ascx" %>
<%@ Control Language="C#" AutoEventWireup="true" Inherits="NewsListTemplate" %>
<%@ Import namespace="Bitrix" %>
<%@ Import namespace="Bitrix.IBlock" %>
<%@ Import namespace="System.Collections.Generic" %>

<ul class="col-xs-8 col-sm-8 col-md-8 col-lg-8 news-list">
<%	   
foreach (NewsListItem item in Component.Items)
{%>
	<% string itemContainerId = GetItemContainerClientID(item.ElementId); %>
    <li id="<%= itemContainerId %>"><%
        RenderElementToolbar(item.Element, itemContainerId);

        if (!String.IsNullOrEmpty(item.Name) && Component.ShowTitle){%>
            <h3><%= item.Name %></h3>
        <%}

        if (item.PreviewImage != null && Component.ShowPreviewPicture) {
			if (Component.HideLinkWhenNoDetail && !item.DetailText)	{
				%><img src="<%= item.PreviewImage.FilePath %>" alt="<%= item.PreviewImage.Description %>" /><%}
			else {
                string title = HttpUtility.HtmlAttributeEncode(!string.IsNullOrEmpty(item.PreviewImage.Description) ? item.PreviewImage.Description : (item.Name ?? string.Empty));
				%><a href="<%= item.DetailUrl %>" title="<%= title %>"><img src="<%= item.PreviewImage.FilePath %>" alt="<%= title %>" /></a><%}
		}
        
        if (!String.IsNullOrEmpty(item.PreviewText) && Component.ShowPreviewText) {%>
            <div class="preview-text"><%=item.PreviewText%></div><%
	    }%>
        <div style="clear:both"></div>
    </li><%
}%>
</ul>
