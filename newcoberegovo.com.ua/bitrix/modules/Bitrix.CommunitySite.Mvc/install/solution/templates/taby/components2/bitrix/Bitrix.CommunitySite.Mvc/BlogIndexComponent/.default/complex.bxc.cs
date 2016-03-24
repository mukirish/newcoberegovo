using System;
using System.Linq;

using Bitrix;
using Bitrix.Blog.Components;
using Bitrix.CommunitySite.Mvc;
using Bitrix.Mvc;

public partial class BlogIndexComponent_ComplexView : BXComponent2Container
{
	protected void OnBlogActionExecuted(object sender, BXComponent2ActionExecutionEventArgs args)
	{
        var blog = (BXComponent2Adapter<BlogComponent2>)sender;
        Context.Items["CommunitySite.Sidebar.BlogSlug"] = blog.Component.BlogSlug;
	}
}