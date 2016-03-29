<%@ Reference Control="~/bitrix/components/bitrix/news.list/component.ascx" %>
<%@ Control Language="C#" AutoEventWireup="true" Inherits="NewsListTemplate" %>
<%@ Import namespace="Bitrix" %>
<%@ Import namespace="Bitrix.IBlock" %>
<%@ Import namespace="System.Collections.Generic" %>

<!--Main Block-->
<style>
    .col-xs-12 img {
        -ms-border-radius: 5px;
        border-radius: 5px;
        max-width: 250px;
    }
</style>

<% foreach (var item in Component.Items) {%>
    <div class="col-xs-12">
        <h3><%= item.Name %></h3>

        <p>
        <% if (item.Properties != null)
           {
                if (item.Properties != null && item.Properties.Count > 0) {%>
                    <img style="float: left; margin: 0 20px 15px 0;" src="<%=((Dictionary<string, string>)item.Properties).First().Value.Split('\"')[1] %>" />
                <%}
                if (item.Properties != null && item.Properties.Count > 1) {%>
                    <img style="float: right; margin: 0 0 15px 20px" src="<%=((Dictionary<string, string>)item.Properties).Last().Value.Split('\"')[1] %>" />
                <%}
           }%>
            <%= !String.IsNullOrEmpty(item.DetailTextString) ? item.DetailTextString : item.PreviewText %>
        </p>
        
    </div><%--media--%>
<div style="clear: both"></div>
<%}%>
