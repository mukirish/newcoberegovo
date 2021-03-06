﻿<%@ Reference Control="~/bitrix/components/bitrix/news.detail/component.ascx" %>
<%@ Control Language="C#" AutoEventWireup="true" Inherits="NewsDetailTemplate" %>
<%@ Import namespace="System.Collections.Generic"%>
<%@ Import namespace="System.ComponentModel"%>
<%@ Import namespace="Bitrix.IBlock"%>

<%if (!String.IsNullOrEmpty(Component.errorMessage)){ %>
	<span class="errortext"><%=Component.errorMessage%></span>
<%}

else if(Component.Element != null)
{%>
	<div class="news-detail">
	<%
		if (Component.DetailImage != null && Component.ShowDetailPicture)
		{
		%>
			<img class="detail_picture" border="0" src="<%= Component.DetailImage.FilePath %>" width="<%= Component.DetailImage.Width %>"
				height="<%= Component.DetailImage.Height %>" alt="<%= Component.DetailImage.Description %>" />
		<%
		}
		else if (Component.PreviewImage != null && Component.ShowPreviewPicture)
		{
		%>
			<img class="detail_picture" border="0" src="<%= Component.PreviewImage.FilePath %>" width="<%= Component.PreviewImage.Width %>"
				height="<%= Component.PreviewImage.Height %>" alt="<%= Component.PreviewImage.Description %>" />
		<%
		}

		if (Component.ShowDate)
		{%>
			<span class="news-date-time"><%= Component.DisplayDate%></span>
		<%
		}
	
		if (Component.ShowTitle)
		{%>
			<h3><%= Component.Element.Name %></h3>
		<%
		}

		if (Component.ShowPreviewText && !String.IsNullOrEmpty(Component.Element.PreviewText))
		{
		%>
			<p><%= Component.Element.PreviewText %></p>
		<%}
			
		%>
		
		<p><%= !String.IsNullOrEmpty(Component.Element.DetailText) ? Component.Element.DetailText : Component.Element.PreviewText %></p>
		<div style="clear: both"></div>
		<br />
		<%
		if (Component.Properties != null)
		{
			foreach (KeyValuePair<string, Dictionary<string, string>> kvp in Component.Properties)
			{
				if (kvp.Value.ContainsKey("Value") && !String.IsNullOrEmpty(kvp.Value["Value"]))
				{
					%><span class="news-element-property"><%= kvp.Value["Name"] + ":" %>&nbsp;<span><%= kvp.Value["Value"] %></span></span> <%
				}
			}
		}%>
	</div>
<%} %>

<% if (!String.IsNullOrEmpty(Component.IBlockUrl) && !String.IsNullOrEmpty(Component.IBlockUrlTitle)){%>
	<p><a enableajax="true" href="<%= Component.IBlockUrl %>"><%= Component.IBlockUrlTitle %></a></p>
<%} %>
