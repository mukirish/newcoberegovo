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
        .col-xs-12 img {
            border-radius: 5px;
            max-width: 250px;
        }
    </style>
	<div class="col-xs-12">
		<h3><%= Component.Element.Name %></h3>
        <p>
            <%
		    if (Component.Properties != null && !string.IsNullOrEmpty(Component.Properties["LEFT_PICTURE"]["Value"]))
		    {%>
	            <img style="float: left; margin: 0 20px 15px 0;" src="<%=Component.Properties["LEFT_PICTURE"]["Value"].Split('\"')[1] %>"/><%
		    }
		    if (Component.Properties != null && !string.IsNullOrEmpty(Component.Properties["RIGHT_PICTURE"]["Value"]))
		    {%>
	            <img style="float: right; margin:0 0 15px 20px" src="<%= Component.Properties["RIGHT_PICTURE"]["Value"].Split('\"')[1] %>"/><%
		    }%>

		    <%= !String.IsNullOrEmpty(Component.Element.DetailText) ? Component.Element.DetailText : Component.Element.PreviewText %>
        </p>
		<div style="clear: both"></div>
	</div>
<%} %>