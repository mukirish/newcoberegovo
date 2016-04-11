<%@ Reference Control="~/bitrix/components/bitrix/news.list/component.ascx" %>
<%@ Control Language="C#" AutoEventWireup="true" Inherits="NewsListTemplate" %>
<%@ Import namespace="Bitrix" %>
<%@ Import namespace="Bitrix.IBlock" %>
<%@ Import namespace="System.Collections.Generic" %>

<!--Main Block-->
<div class="col-xs-12">
    <% foreach (var item in Component.Items) {%>
    <div class="col-xs-12 col-md-12 col-lg-12 doc">
            <%
            string title = HttpUtility.HtmlDecode(!string.IsNullOrEmpty(item.PreviewImage.Description) ? item.PreviewImage.Description : (item.Name ?? string.Empty));
            // Вывод картинки анонса
            if (item.PreviewImage != null && Component.ShowPreviewPicture)
            {%>
                    <a class="fancybox" rel="gallery<%=item.ElementId %>" href="<%= item.PreviewImage.FilePath %>" title="<%= title %>"><%= title %></a><%
            }%>
        	<%   if (item.Properties != null)
                {
                    foreach (KeyValuePair<string, string> kvp in item.Properties)
                    {
                        if (!string.IsNullOrEmpty(kvp.Value))
                        {
                            %> ( <%
                            int page = 2;
                            var groups = Regex.Matches(kvp.Value, "href\\s*=\\s*(?:[\"'](?<1>[^\"']*)[\"']|(?<1>\\S+))",
                                            RegexOptions.IgnoreCase | RegexOptions.Compiled);
                            foreach(Match record in groups) 
                            {
                                %><%= page > 2 ? ", ":"" %><a class="fancybox" rel="gallery<%=item.ElementId %>" href="<%= record.Groups[1] %>" title="<%= page %>"><%= page %></a> <%
                                page++;
                            }
                            %> ) <%
				        }
			        }
		        }%>
    </div>
    <%}%>
</div>

<bx:IncludeComponent runat="server" ID="HeaderPager" ComponentName="bitrix:system.pager" CurrentPosition="top" Template="<%$ Parameters:PagingTemplate %>"/>
