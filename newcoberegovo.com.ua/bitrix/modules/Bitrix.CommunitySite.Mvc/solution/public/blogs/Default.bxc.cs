using System;
using System.Linq;

using Bitrix;
using Bitrix.Blog.Components;
using Bitrix.CommunitySite.Mvc;
using Bitrix.Mvc;

public partial class _Sites_default_blogs_Default_bxc : BXComponent2Container
{
	protected void OnBlogInitialized(object sender, EventArgs e)
	{
		var blog = (BXComponent2Adapter<BlogIndexComponent>)sender;
		blog.Component.ColorCssFilePath = "~/bitrix/templates/" + BXSite.CurrentTemplate + "/blog.css";
	}
}