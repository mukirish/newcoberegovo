using System;

using Bitrix;
using Bitrix.Blog.Components;
using Bitrix.Mvc;

public partial class _Sites_default__area_sidebar_bxc : BXComponent2Container
{
	protected void OnBlogInitialized(object sender, EventArgs e)
	{
		var blog = (BXComponent2Adapter<BlogListComponent2>)sender;
		blog.Component.ColorCssFilePath = "~/bitrix/templates/" + BXSite.CurrentTemplate + "/blog.css";
	}
}