﻿<%@ Reference Control="~/bitrix/components/bitrix/news.list/component.ascx" %>
<%@ Control Language="C#" AutoEventWireup="true" Inherits="NewsListTemplate" %>
<%@ Import namespace="Bitrix" %>
<%@ Import namespace="Bitrix.IBlock" %>
<%@ Import namespace="System.Collections.Generic" %>

<%
if (Component.Items == null)
   return;
%>

<div class="news-list">
<% 
if (Component.PagingShow && Component.PagingPosition != "bottom")
{
   %><div class="news-list-pager">
		<bx:IncludeComponent runat="server" ID="HeaderPager" ComponentName="bitrix:system.pager" CurrentPosition="top" Template="<%$ Parameters:PagingTemplate %>"/>
	</div><br /><%
} 
	   
foreach (NewsListItem item in Component.Items)
{
	var itemContainerId = GetItemContainerClientID(item.ElementId);
	
	%><div id="<%= itemContainerId %>" class="news-item">
	<% if (item.PreviewImage != null && Component.ShowPreviewPicture)
		{
			if (Component.HideLinkWhenNoDetail && !item.DetailText)
			{
				%><img class="preview_picture" border="0" src="<%= item.PreviewImage.FilePath %>" width="<%= item.PreviewImage.Width %>" height="<%= item.PreviewImage.Height %>" alt="<%= item.PreviewImage.Description %>" style="float:left" /><%
			}
			else
			{
                string title = HttpUtility.HtmlAttributeEncode(!string.IsNullOrEmpty(item.PreviewImage.Description) ? item.PreviewImage.Description : (item.Name ?? string.Empty));
				%><a href="<%= item.DetailUrl %>" title="<%= title %>" enableajax="true"><img class="preview_picture" border="0" src="<%= item.PreviewImage.FilePath %>" width="<%= item.PreviewImage.Width %>" height="<%= item.PreviewImage.Height %>" alt="<%= title %>" style="float:left" /></a><% 	
			}
		} 
	%>
	<% if (!String.IsNullOrEmpty(item.DisplayDate) && Component.ShowDate)
		{ 
			%><span class="news-date-time"><%= item.DisplayDate %></span> <%
		}
	%>

	<% if (!String.IsNullOrEmpty(item.DisplayDate) && Component.ShowDate)
		{ 
			%><span class="news-date-time"><%= item.Element.ActiveFromDate.ToString(@"dd\/mm\/yyyy") %></span> <%
		}
	%>

	<% if (!String.IsNullOrEmpty(item.Name) && Component.ShowTitle)
		{
			if (!Component.HideLinkWhenNoDetail || item.DetailText)
			{			
				%><a href="<%= item.DetailUrl %>" enableajax="true"><b><%= item.Name %></b></a><br /><%
			}
			else
			{
				%><b><%= item.Name %></b><br /><%
			}
		}
	%>
	
	<%if (!String.IsNullOrEmpty(item.PreviewText) && Component.ShowPreviewText)
	{
		%><%=item.PreviewText%><%
	}
	else if (Component.ShowDetailText && item.DetailText)
	{
		%><%= item.DetailTextString%><%
	}
	%>
	

	<%
	bool propertyShown = false;
	if (item.Properties != null)
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
	}

	if (item.PreviewImage != null && Component.ShowPreviewPicture)
	{ 
		%><br clear="all" /><%
	}
	%>
	
	<% RenderElementToolbar(item.Element, itemContainerId); %>		
	</div>
	
	<%
	if (Component.ShowPreviewText || Component.ShowDetailText || propertyShown)
	{
		%><br /><%
	}
}
if (Component.PagingShow && Component.PagingPosition != "top")
{
	%><div class="news-list-pager">
		<bx:IncludeComponent runat="server" ID="FooterPager" ComponentName="bitrix:system.pager" CurrentPosition="bottom"  Template="<%$ Parameters:PagingTemplate %>"/>
	</div><%	
} 
%>
</div>