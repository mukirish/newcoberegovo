<%@ Control Language="C#" AutoEventWireup="false" CodeFile="SideBar.ascx.cs" Inherits="Bitrix.Blog.UI.SideBar" %>
<%@ Import Namespace="Bitrix.Security" %>
<%@ Import Namespace="Bitrix.IO" %>
<div class="blog-content">
    <%
        string name = null;
        string profile = null;
        BXUser user = null;   
        BXFile avatar = null;
        if (Blog.Owner != null && (user = Blog.Owner.User) != null && (avatar = user.Image) != null)
        { 		
            name = user.GetDisplayName();
            profile = Encode(ResolveTemplateUrl(UserProfileUrlTemplate, replace));
        }
        
    %>
    <% if (avatar != null) { %>
    <ul>
        <li class="blog-tags">
            <div class="blog-sidebar-avatar">
                <% if (!string.IsNullOrEmpty(profile)) { %><a href="<%= profile %>"><% } %>
                <img src="<%= HttpUtility.HtmlAttributeEncode(avatar.FilePath) %>" title="<%= name %>" border="0" width="<%= avatar.Width.ToString() %>" height="<%= avatar.Height.ToString() %>" alt="" />
                <% if (!string.IsNullOrEmpty(profile)) { %></a><% } %>
            </div>
        </li>
    </ul>
    <% } %>
    <% if (Auth.CanEditThisBlogSettings || Auth.CanCreatePost || Auth.CanReadThisBlogDrafts) { %>
    <ul>
        <li class="blog-settings">
            <h3 class="blog-sidebar-title"><%= GetMessage("Header.Blog") %></h3>
            <ul>
                <% if (!string.IsNullOrEmpty(NewPostUrlTemplate) && Auth.CanCreatePost) { %>
                <li><a href="<%= Encode(ResolveTemplateUrl(NewPostUrlTemplate, replace)) %>" title="<%= GetMessage("ToolTip.NewPost") %>"><%= GetMessage("NewPost") %></a></li>
                <% } %>
                <% if (!string.IsNullOrEmpty(DraftPostListUrlTemplate) && Auth.CanReadThisBlogDrafts) { %>
                <li><a href="<%= Encode(ResolveTemplateUrl(DraftPostListUrlTemplate, replace)) %>" title="<%= GetMessage("ToolTip.Drafts") %>"><%= GetMessage("Drafts") %></a></li>
                <% } %>
                <% if (!string.IsNullOrEmpty(BlogEditUrlTemplate) && Auth.CanEditThisBlogSettings) { %>
                <li><a href="<%= Encode(ResolveTemplateUrl(BlogEditUrlTemplate, replace)) %>" title="<%= GetMessage("ToolTip.Settings") %>"><%= GetMessage("Settings") %></a></li>
                <% } %>
                <% if (!string.IsNullOrEmpty(MetaWeblogUrlTemplate) && Auth.CanWriteFilteredHtml && Auth.CanCreatePost) { %>
                <li><a href="<%= Encode(ResolveTemplateUrl(MetaWeblogUrlTemplate, replace)) %>" title="<%= GetMessage("ToolTip.MetaWeblog") %>">MetaWeblog</a></li>
                <% } %>
            </ul>
        </li>
    </ul>
    <% } %>
    <% if (IsSearch) { %>
    <ul>
        <li class="blog-tags-cloud">
            <h3 class="blog-sidebar-title">
                <%= GetMessage("Header.TagCloud") %></h3>
            <div align="center">
                <div runat="server" id="TagsCloudContainer" class="search-tags-cloud" style="width: 100%;"></div>
            </div>
        </li>
    </ul>
    <% } %>
    <% if (!string.IsNullOrEmpty(RssBlogPostsUrlTemplate)) { %>
    <% string url = Encode(ResolveTemplateUrl(RssBlogPostsUrlTemplate, replace)); %>
    <ul>
        <li class="blog-rss">
            <h3 class="blog-sidebar-title">
                <span style="float: right;"><a href="<%= url %>" title="<%= GetMessage("ToolTip.Rss") %>" class="blog-rss-icon"></a></span>
                <a href="<%= url %>" title="<%= GetMessage("ToolTip.Rss") %>"><%= GetMessage("Header.Rss") %></a>
            </h3>
        </li>
    </ul>
    <% } %>
</div>
