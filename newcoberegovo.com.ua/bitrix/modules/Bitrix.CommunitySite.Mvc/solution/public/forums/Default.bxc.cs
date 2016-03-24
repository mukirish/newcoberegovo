using System;
using System.Linq;

using Bitrix;
using Bitrix.CommunitySite.Mvc;
using Bitrix.Forum.Components;
using Bitrix.Mvc;
using Bitrix.Configuration;

public partial class _Sites_default_forums_Default_bxc : BXComponent2Container
{
	protected void OnForumInitialized(object sender, EventArgs e)
	{
		var forum = (BXComponent2Adapter<ForumComponent2>)sender;


		var templateName = BXOptionManager.GetOption("Bitrix.CommunitySite.Mvc", "InstalledTemplate", string.Empty, BXSite.Current.Id);
		var themeName = BXOptionManager.GetOption("Bitrix.CommunitySite.Mvc", "InstalledTemplateTheme", string.Empty, BXSite.Current.Id);

		var forumTheme = "default";
		switch (templateName)
		{
			case "taby":
				switch (themeName)
				{
					case "orange":
						forumTheme = "white";
						break;
					case "gray":
					case "green":
					case "red":
						forumTheme = "default";
						break;
					default:
						forumTheme = themeName;
						break;
				}
				break;
			case "wide":
				switch (themeName)
				{
					case "blue":
						forumTheme = "white";
						break;
					case "gray":
						forumTheme = "default";
						break;
					default:
						forumTheme = themeName;
						break;
				}
				break;
		}
	    
        forum.Component.ColorCssFilePath = "~/bitrix/components2/Bitrix.Forum.Components/ForumComponent2/templates/.default/themes/" + forumTheme + "/style.css";
	}
}