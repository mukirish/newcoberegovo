 <%@ Reference Control="~/bitrix/components/bitrix/news.list/component.ascx" %>
<%@ Control Language="C#" AutoEventWireup="true" Inherits="NewsListTemplate" %>
<%@ Import namespace="Bitrix" %>
<%@ Import namespace="Bitrix.IBlock" %>
<%@ Import namespace="System.Collections.Generic" %>

<%
if (Component.Items == null)
   return;

// Дублируем 3 колонки, выбирая каждый третий елемент
for (int c = 0; c < 1; c++)
{
%>
    <div class="news_n<%= c==2?" last":""%>"><ul><% 
    for (int i = c; i < Component.Items.Count; i += 3)
    {
        NewsListItem item = Component.Items.ElementAt(i);%>
            <li><%
        // Вывод картинки анонса
        if (item.PreviewImage != null && Component.ShowPreviewPicture)
        {
            if (Component.HideLinkWhenNoDetail && !item.DetailText)
            {
				        %><img src="<%= item.PreviewImage.FilePath %>" alt="<%= item.PreviewImage.Description %>" /><%}
            else
            {
                string title = HttpUtility.HtmlAttributeEncode(!string.IsNullOrEmpty(item.PreviewImage.Description) ? item.PreviewImage.Description : (item.Name ?? string.Empty));
				        %><a href="<%= item.DetailUrl %>" title="<%= title %>"><img src="<%= item.PreviewImage.FilePath %>" alt="<%= title %>" /></a><%}
        }

        // Вывод даты
        if (!String.IsNullOrEmpty(item.DisplayDate) && Component.ShowDate)
        {%>
                        <span><%= item.DisplayDate%></span><%
        }

        // Вывод заглавия (титула)
        if (!String.IsNullOrEmpty(item.Name) && Component.ShowTitle)
        {%>
                    <a href="<%= item.DetailUrl %>"><%= item.Name%></a><%
        }

        // Вывод текста анонса
        if (!String.IsNullOrEmpty(item.PreviewText) && Component.ShowPreviewText)
        {%>
                    <p><%=item.PreviewText%></p><%
        }%>
            </li><%
    }%>
        </ul>
    </div><%
}%>
<div class="clear"></div>
