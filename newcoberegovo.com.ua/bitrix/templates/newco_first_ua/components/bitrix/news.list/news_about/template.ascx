<%@ Reference Control="~/bitrix/components/bitrix/news.list/component.ascx" %>
<%@ Control Language="C#" AutoEventWireup="true" Inherits="NewsListTemplate" %>
<%@ Import namespace="Bitrix" %>
<%@ Import namespace="Bitrix.IBlock" %>
<%@ Import namespace="System.Collections.Generic" %>

<!--Main Block-->
<div class="col-xs-7 col-sm-8 col-md-9">
    <bx:IncludeComponent
        ID="newsdetail1"
        runat="server"
        ActiveDateFormat="dd.MM.yyyy"
        CacheDuration="31536000"
        CacheMode="Auto"
        ComponentName="bitrix:news.detail"
        DisplayPanel="False"
        ElementId="184"
        GroupPermissions="1"
        IBlockId="8"
        IBlockTypeId="6"
        IBlockUrl="News.aspx?id=#IBLOCK_ID#"
        IBlockUrlTitle="Back to News"
        PropertyCode="'LEFT_PICTURE';'RIGHT_PICTURE'"
        SetTitle="False"
        ShowActiveElements="True"
        ShowDate="True"
        ShowDetailPicture="True"
        ShowPreviewPicture="False"
        ShowPreviewText="False"
        ShowTitle="True"
        template="news_about_us"
        UsePermissions="False" />
</div>
<%--Right buttons--%>
<div class="col-xs-5 col-sm-4 col-md-3">
    <% foreach (var item in Component.Items) {%>
        <a class="btn btn-block btn-success" href="<%= item.DetailUrl %>" role="button"><%= item.Name%></a>
        <br />
    <%}%>
</div><%--Right buttons--%>

<bx:IncludeComponent runat="server" ID="HeaderPager" ComponentName="bitrix:system.pager" CurrentPosition="top" Template="<%$ Parameters:PagingTemplate %>"/>
