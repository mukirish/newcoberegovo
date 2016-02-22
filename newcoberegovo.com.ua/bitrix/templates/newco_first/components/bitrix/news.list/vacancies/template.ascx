<%@ Reference Control="~/bitrix/components/bitrix/news.list/component.ascx" %>
<%@ Control Language="C#" AutoEventWireup="true" Inherits="NewsListTemplate" %>
<%@ Import namespace="Bitrix" %>
<%@ Import namespace="Bitrix.IBlock" %>
<%@ Import namespace="System.Collections.Generic" %>

<%
if (Component.Items == null) return;
bool first_el = true;
%>

<ul class="v_ul">
<%	   
foreach (NewsListItem item in Component.Items)
{%>
	<% string itemContainerId = GetItemContainerClientID(item.ElementId); %>
    <li id="<%= itemContainerId %>" class="inline<%= first_el?" first":"" %>" href="#inline_content_<%=item.ElementId%>"><%
        first_el = false;
		RenderElementToolbar(item.Element, itemContainerId); 
        
        
        // Вывод заглавия (титула) - должность
        if (!String.IsNullOrEmpty(item.Name) && Component.ShowTitle){%>
            <h5><%= item.Name %></h5><%
        }
        
        // Вывод текста анонса
        if (!String.IsNullOrEmpty(item.PreviewText) && Component.ShowPreviewText) {%>
            <span><%=item.PreviewText%></span><%
	    }%>
        <div class="last_a">Детальніше</div>
        <div style='display: none'>
            <div id='inline_content_<%=item.ElementId%>' class="inline_content">
                <div class="w700">
                    <div class="top_n">
                        <h5><%= item.Name %><span></span></h5>
                    </div>
                    <div class="top_r">
                        <img src="/bitrix/templates/newco_first/img/res.png" alt=""/>
                        <button type="submit">Відправити резюме</button> 
                        <a href="mailto:newco@newcoberegovo.com.ua" >Відправити резюме</a>
                    </div>
                    <div class="clear"></div>

                    <div class="block_top"><%
                    	if (item.Properties != null) {%>
                            <ul><%
                            
                            foreach (KeyValuePair<string, Bitrix.BXCustomProperty> kvp in item.Element.Properties){
                                switch (kvp.Key) {
                                    case "EXPERIENCE":%>
                                        <li>Досвід:<img src="/bitrix/templates/newco_first/img/vacan1.png" alt=""/><span><%= kvp.Value.Value%></span></li><%
                                        break;
                                    case "EDUCATION":%>
                                        <li>Освіта:<img src="/bitrix/templates/newco_first/img/vacan2.png" alt=""/><span><%= kvp.Value.Value%></span></li><%
                                        break;
                                    case "TIMETABLE":%>
                                        <li>Графік:<img src="/bitrix/templates/newco_first/img/vacan3.png" alt=""/><span><%= kvp.Value.Value%></span></li><%
                                        break;
                                }
                            }%><div class="clear"></div>
                            </ul><%
	                    }%>
                    </div>
                    <div class="clear"></div>
                    <%=item.DetailTextString%>
                </div><%--.w700--%>
            </div>
        </div>
    </li><%
}%>
</ul>
