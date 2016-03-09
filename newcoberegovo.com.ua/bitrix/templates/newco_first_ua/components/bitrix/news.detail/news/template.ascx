<%@ Reference Control="~/bitrix/components/bitrix/news.detail/component.ascx" %>
<%@ Control Language="C#" AutoEventWireup="true" Inherits="NewsDetailTemplate" %>
<%@ Import namespace="System.Collections.Generic"%>
<%@ Import namespace="System.ComponentModel"%>
<%@ Import namespace="Bitrix.IBlock"%>

<%if (!String.IsNullOrEmpty(Component.errorMessage)){ %>
	<span class="errortext"><%=Component.errorMessage%></span>
<%}

else if(Component.Element != null)
{%>
<style>
    .detail_picture {
        max-width:400px;
        margin:0 30px 30px 0;
        float:left;
        border: 1px solid white;
        border-radius:5px;
        box-shadow: 0px 0px 5px 1px rgba(200,200,200,0.8);
    }
</style>

	<div class="col-xs-8 col-sm-8 col-md-8 col-lg-8">
	<%
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

		if (Component.DetailImage != null && Component.ShowDetailPicture)
		{
		%>
			<img class="detail_picture" border="0" src="<%= Component.DetailImage.FilePath %>"
				alt="<%= Component.DetailImage.Description %>" />
		<%
		}
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
	<p><a style="position:absolute;bottom:30px;left:30px;" enableajax="true" href="<%= Component.IBlockUrl %>"><%= Component.IBlockUrlTitle %></a></p>
<%} %>
