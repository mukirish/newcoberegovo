<%@ Reference Control="~/bitrix/components/bitrix/news.list/component.ascx" %>
<%@ Control Language="C#" AutoEventWireup="true" Inherits="NewsListTemplate" %>
<%@ Import namespace="Bitrix" %>
<%@ Import namespace="Bitrix.IBlock" %>
<%@ Import namespace="System.Collections.Generic" %>

<%
if (Component.Items == null)
   return;
%>

<div class="slider-content" style="height: 450px; text-align: center">
<%	   
foreach (NewsListItem item in Component.Items)
{%>                
    <div class="slide">
        <div class="w980"><%
            if (!String.IsNullOrEmpty(item.Name) && Component.ShowTitle){ %>
                <div class="sl_provoda"><p><%= item.Name %></p></div><%
            }
            // Вывод текста анонса
            if (!String.IsNullOrEmpty(item.PreviewText) && Component.ShowPreviewText) {%>
                <div class="sl_info">
                    <a href="#" class="knopka"><span>Подробнее...</span></a>
                    <p><%=item.PreviewText%></p>
                </div><%
	        }%>
        </div><%
        // Вывод картинки анонса
        if (item.PreviewImage != null && Component.ShowPreviewPicture) {%>
            <p class="img_2" style="height: 450px; text-align: center">
             <img src="<%= item.PreviewImage.FilePath %>" alt="<%= item.PreviewImage.Description %>" align="center"/>   
            </p><%
        }%>
    </div><%
}%>
</div><%--slider-content--%>