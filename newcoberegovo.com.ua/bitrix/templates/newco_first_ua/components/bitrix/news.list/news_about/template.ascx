<%@ Reference Control="~/bitrix/components/bitrix/news.list/component.ascx" %>
<%@ Control Language="C#" AutoEventWireup="true" Inherits="NewsListTemplate" %>
<%@ Import namespace="Bitrix" %>
<%@ Import namespace="Bitrix.IBlock" %>
<%@ Import namespace="System.Collections.Generic" %>

<!--Main Block-->
<div class="col-xs-8 col-sm-8 col-md-8 col-lg-8">
    <% foreach (var item in Component.Items) {%>

    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <%// Вывод заглавия (титула)
        if (!String.IsNullOrEmpty(item.Name) && Component.ShowTitle)
        {%>
            <h2><%= item.Name%></h2>
        <%}%>
        <div>

        </div>
        <div>
<%--            	if (item.Properties != null)
	{
		%><br /><%
		foreach (KeyValuePair<string, string> kvp in item.Properties)
		{
			if (!String.IsNullOrEmpty(kvp.Value))
			{
				propertyShown = true;
				%><span class="news-element-property"><%= kvp.Key+ ":" %>&nbsp;<span><%= kvp.Value%></span></span> <%
			}
		}
	}--%>
                <%// Вывод картинки анонса
                if (item.PreviewImage != null && Component.ShowPreviewPicture)
                {
                    if (Component.HideLinkWhenNoDetail && !item.DetailText)
                    {%>
                        <img class="col-xs-4 col-sm-4 col-md-4 col-lg-4" src="<%= item.PreviewImage.FilePath %>" alt="<%= item.PreviewImage.Description %>" />
                    <%}
                    else
                    {
                        string title = HttpUtility.HtmlAttributeEncode(!string.IsNullOrEmpty(item.PreviewImage.Description) ? item.PreviewImage.Description : (item.Name ?? string.Empty));%>
                            <a href="<%= item.DetailUrl %>" title="<%= title %>"><img style="float:left; margin:5px 20px 15px 0" src="<%= item.PreviewImage.FilePath %>" alt="<%= title %>" /></a><%
                    }
                }%>

                <%// Вывод картинки анонса
                if (item.PreviewImage != null && Component.ShowPreviewPicture)
                {
                    if (Component.HideLinkWhenNoDetail && !item.DetailText)
                    {%>
                        <img class="col-xs-4 col-sm-4 col-md-4 col-lg-4" src="<%= item.PreviewImage.FilePath %>" alt="<%= item.PreviewImage.Description %>" />
                    <%}
                    else
                    {
                        string title = HttpUtility.HtmlAttributeEncode(!string.IsNullOrEmpty(item.PreviewImage.Description) ? item.PreviewImage.Description : (item.Name ?? string.Empty));%>
                            <a href="<%= item.DetailUrl %>" title="<%= title %>"><img  style="float:right; margin:5px 0 15px 20px" src="<%= item.PreviewImage.FilePath %>" alt="<%= title %>" /></a><%
                    }
                }%>

                <%if (!String.IsNullOrEmpty(item.PreviewText) && Component.ShowPreviewText)
	            {
		            %><%=item.PreviewText%><%
	            }
	            else if (Component.ShowDetailText && item.DetailText)
	            {
		            %><%= item.DetailTextString%><%
	            }
	            %>
        </div>
    </div>
    <%}%>
</div>
<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
    <% foreach (var item in Component.Items) {%>
        <a class="btn btn-block btn-success" href="<%= item.DetailUrl %>" role="button"><%= item.Name%></a>
        <br />
    <%}%>
</div>

<bx:IncludeComponent runat="server" ID="HeaderPager" ComponentName="bitrix:system.pager" CurrentPosition="top" Template="<%$ Parameters:PagingTemplate %>"/>
