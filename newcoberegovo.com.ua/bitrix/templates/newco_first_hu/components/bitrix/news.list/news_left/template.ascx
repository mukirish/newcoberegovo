<%@ Reference Control="~/bitrix/components/bitrix/news.list/component.ascx" %>
<%@ Control Language="C#" AutoEventWireup="true" Inherits="NewsListTemplate" %>
<%@ Import namespace="Bitrix" %>
<%@ Import namespace="Bitrix.IBlock" %>
<%@ Import namespace="System.Collections.Generic" %>

<!--Sidebar-->
<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 sidebar">
<%	   
foreach (NewsListItem item in Component.Items)
{%>
<% string itemContainerId = GetItemContainerClientID(item.ElementId); %>
<div id="<%= itemContainerId %>"><%
RenderElementToolbar(item.Element, itemContainerId);

if (!String.IsNullOrEmpty(item.Name) && Component.ShowTitle){%>
<h4><%= item.Name %></h4>
<%}

if (item.PreviewImage != null && Component.ShowPreviewPicture) {
if (Component.HideLinkWhenNoDetail && !item.DetailText)	{
%><img src="<%= item.PreviewImage.FilePath %>" alt="<%= item.PreviewImage.Description %>" /><%}
else {
string title = HttpUtility.HtmlAttributeEncode(!string.IsNullOrEmpty(item.PreviewImage.Description) ? item.PreviewImage.Description : (item.Name ?? string.Empty));
%><a href="<%= item.DetailUrl %>" title="<%= title %>"><img src="<%= item.PreviewImage.FilePath %>" alt="<%= title %>" /></a><%}
}%>
</div><%
}%>
    <a class="btn btn-block btn-default" style="margin-bottom:5px;" href="/hu/news/Default.aspx" role="button">Hírek</a>
</div>