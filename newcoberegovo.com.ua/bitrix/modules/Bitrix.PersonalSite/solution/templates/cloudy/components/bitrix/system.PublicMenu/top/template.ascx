﻿<%@ Reference VirtualPath="~/bitrix/components/bitrix/system.PublicMenu/component.ascx" %>
<%@ Control Language="C#" ClassName="template" Inherits="Bitrix.Main.Components.SystemPublicMenuTemplate" %>
<%@ Import Namespace="Bitrix" %>
<%  if (Component.Menu != null) { %>
	<% 
		var uriComparer = new BXUriComparer();
		BXPublicMenuItem selected = null;
		foreach (var item in Component.Menu)
		{
			if (!item.IsAccessible || !item.IsSelected)
				continue;
			if (selected == null || uriComparer.Compare(item.Link, selected.Link) >= 0)
				selected = item;
		}
	%>
	<ul id="top-menu">
	<% foreach (var item in Component.Menu) { %>
		<% if (!item.IsAccessible) continue; %>
		<li <% if (item == selected) { %>class="selected"<% } %>><a href="<%= Encode(item.Href) %>"><b class="r1"></b><b class="r0"></b><span><%= Encode(item.Title) %></span></a></li>
	<% } %>
	</ul>
<% } %>