<%@ Reference Control="~/bitrix/components/bitrix/news.list/component.ascx" %>
<%@ Control Language="C#" AutoEventWireup="true" Inherits="NewsListTemplate" %>
<%@ Import namespace="Bitrix" %>
<%@ Import namespace="Bitrix.IBlock" %>
<%@ Import namespace="System.Collections.Generic" %>

<%
if (Component.Items == null)
   return;
%>

<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">

<ol class="carousel-indicators">
<%	      
for (int i = 0; i<Component.Items.Count; i++)// NewsListItem item in Component.Items)
{%>                
    <li data-target="#carousel-example-generic" data-slide-to="<%=i%>" class="<%=i==0 ? "active" : "" %>"></li>
<%
}%>
</ol>
<div class="carousel-inner" role="listbox">
    <%
    for (int i = 0; i < Component.Items.Count; i++)
    {
        // Вывод картинки анонса
        if (Component.Items[i].PreviewImage != null && Component.ShowPreviewPicture) {%>
            <div class="item<%=i==0 ? " active" : " " %> carousel-item">
                <img class="carousel-img" src="<%= Component.Items[i].PreviewImage.FilePath %>" alt="<%= Component.Items[i].PreviewImage.Description %>"/>
                <%--На майбутнє, передбачене Іванком.--%>
                <div class="carousel-caption"></div>
            </div><%
        }%>
    <%
    }%>
</div>
    <!-- Controls -->
    <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
    </a>
</div><%--slider-content--%>

