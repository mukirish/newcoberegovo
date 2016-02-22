<%@ Reference Control="~/bitrix/components/bitrix/news.list/component.ascx" %>
<%@ Control Language="C#" AutoEventWireup="true" Inherits="NewsListTemplate" %>
<%@ Import namespace="Bitrix" %>
<%@ Import namespace="Bitrix.IBlock" %>
<%@ Import namespace="System.Collections.Generic" %>

<%
if (Component.Items == null)
   return;
%>

<ul class="Here we are">
<%	   
foreach (NewsListItem item in Component.Items)
{%>
	<% string itemContainerId = GetItemContainerClientID(item.ElementId); %>
    <li id="<%= itemContainerId %>"><%
        
		RenderElementToolbar(item.Element, itemContainerId); 
        
        // Вывод картинки анонса
        if (item.PreviewImage != null && Component.ShowPreviewPicture) {
			if (Component.HideLinkWhenNoDetail && !item.DetailText)	{
				%><img src="<%= item.PreviewImage.FilePath %>" alt="<%= item.PreviewImage.Description %>" /><%}
			else {
                string title = HttpUtility.HtmlAttributeEncode(!string.IsNullOrEmpty(item.PreviewImage.Description) ? item.PreviewImage.Description : (item.Name ?? string.Empty));
				%><a href="<%= item.DetailUrl %>" title="<%= title %>"><img src="<%= item.PreviewImage.FilePath %>" alt="<%= title %>" /></a><%}
		}
        
        // Вывод даты
        if (!String.IsNullOrEmpty(item.DisplayDate) && Component.ShowDate) {%>
            <h4><%= item.DisplayDate %></h4><%
		}
        
        // Вывод заглавия (титула)
        if (!String.IsNullOrEmpty(item.Name) && Component.ShowTitle){
			if (!Component.HideLinkWhenNoDetail || item.DetailText){%>
                <a href="<%= item.DetailUrl %>"><h5><%= item.Name %></h5></a><%
			}
			else {%>
                <h5><%= item.Name %></h5><%
			}
        }
        
        // Вывод текста анонса
        if (!String.IsNullOrEmpty(item.PreviewText) && Component.ShowPreviewText) {%>
            <div class="preview-text"><%=item.PreviewText%></div><%
	    }%>
    </li><%
}%>
</ul>
