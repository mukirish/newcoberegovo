namespace Bitrix.Blog.UI
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using Bitrix.DataLayer;
    using Bitrix.DataTypes;
    using Bitrix.Security;
    using Bitrix.Services;
    using Bitrix.Services.Text;
    using Bitrix.UI;

    public partial class SideBar : BXControl, IBXBlogSideBar
    {
        public static bool IsSearch = Bitrix.Modules.BXModuleManager.IsModuleInstalled("Search");

        protected BXParamsBag<object> replace;

        public string NewPostUrlTemplate { get; set; }

        public string DraftPostListUrlTemplate { get; set; }

        public string BlogEditUrlTemplate { get; set; }

        public string IndexUrlTemplate { get; set; }

        public string UserProfileUrlTemplate { get; set; }

        public string RssBlogPostsUrlTemplate { get; set; }

        public string MetaWeblogUrlTemplate { get; set; }

        public string BlogSlug { get; set; }

        public BXBlog Blog { get; set; }

        public BXBlogAuthorization Auth { get; private set; }

        protected override void OnLoad(EventArgs e)
        {
            if (!Visible)
                return;

            base.OnLoad(e);
            if (this.Blog == null && !string.IsNullOrEmpty(BlogSlug))
            {
                string key = string.Concat("_BX_BLOG_SIDE_BAR_BLOG_", BlogSlug);
                if (BXTagCachingManager.IsTagCachingEnabled())
                    this.Blog = BXCacheManager.MemoryCache.Application.Get(key) as BXBlog;

                if (this.Blog == null)
                {
                    this.Blog = BXBlog.GetBySlug(
                        BlogSlug,
                        null,
                        new BXSelectAdd(BXBlog.Fields.Owner.User.Image),
                        BXTextEncoder.DefaultEncoder
                    );

                    if (this.Blog != null && BXTagCachingManager.IsTagCachingEnabled())
                        BXCacheManager.MemoryCache.Application.Insert(key, this.Blog, new BXTagCachingDependency(BXBlog.CreateTagById(this.Blog.Id)));
                }

            }
            if (this.Blog == null || !this.Blog.Active && !BXPrincipal.Current.IsCanOperate(BXBlog.Operations.BlogApprove))
            {
                this.Blog = null;
                Visible = false;
                return;
            }
            this.Auth = new BXBlogAuthorization(this.Blog);

            // TODO: поиск
            if (IsSearch)
            {
                /*
                                UserControl control = (UserControl)LoadControl("index-tagcloud.ascx");
                                control.Attributes["BlogId"] = Blog.Id.ToString();
                                control.Attributes["BlogSlug"] = Blog.Slug;                
                                TagsCloudContainer.Controls.Add(control);
                */
            }
        }
        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);

            Visible =
                IsSearch
                || !string.IsNullOrEmpty(RssBlogPostsUrlTemplate)
                || Blog.Owner != null && Blog.Owner.User != null && Blog.Owner.User.Image != null
                || Auth.CanEditThisBlogSettings || Auth.CanCreatePost || Auth.CanReadThisBlogDrafts;

            replace = new BXParamsBag<object>();
            replace.Add("UserId", Blog.OwnerId);
            replace.Add("BlogSlug", Blog.Slug);
            replace.Add("BlogId", Blog.Id);

            if (!string.IsNullOrEmpty(RssBlogPostsUrlTemplate))
            {
                BXPage.RegisterLink(
                    "alternate",
                    "application/rss+xml",
                    ResolveTemplateUrl(RssBlogPostsUrlTemplate, replace),
                    new KeyValuePair<string, string>("title", Blog.TextEncoder.Decode(Blog.Name))
                );
            }
        }
        protected string ResolveTemplateUrl(string template, BXParamsBag<object> parameters)
        {
            string url = (parameters != null) ? BXSefUrlUtility.MakeLink(template, parameters, null) : template;
            if (url.StartsWith("~/"))
                url = ResolveUrl(url);
            return url;
        }

    }
}