<%@ Control Language="C#" AutoEventWireup="true" Inherits="Bitrix.UI.Wizards.BXWizardStepStandardHtmlControl" %>
<%@ Import Namespace="Bitrix" %>
<%@ Import Namespace="Bitrix.DataTypes" %>
<%@ Import Namespace="Bitrix.Install" %>
<%@ Import Namespace="Bitrix.IO" %>
<%@ Import Namespace="Bitrix.Services.Text" %>
<%@ Import Namespace="Bitrix.UI.Wizards" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="Bitrix.Mvc.UI.Admin.VirtualSite.Templates" %>
<%@ Import Namespace="Bitrix.UI" %>
<%@ Import Namespace="Bitrix.Mvc" %>
<script runat="server">
	const string SitePatches =
@"+Default.bxc
-posts
BlogUrlTemplate
PostViewUrlTemplate
SearchTagsUrlTemplate
PostRssUrlTemplate
PostEditUrlTemplate

+_area_sidebar.bxc
-last_topics
ForumReadUrlTemplate
TopicReadUrlTemplate
UserProfileUrlTemplate
		
-tag_cloud
TagLinkTemplate
				
-new_blogs
BlogOwnerProfilePageUrlTemplate
BlogPageUrlTemplate

-search_form
SearchUrlTemplate


+blogs\_area_sidebar.bxc
-popular_posts
BlogUrlTemplate
UserProfileUrlTemplate
PostViewUrlTemplate
SearchTagsUrlTemplate

-search_form
SearchUrlTemplate

-new_blogs			
BlogOwnerProfilePageUrlTemplate
BlogPageUrlTemplate

-tag_cloud
TagLinkTemplate


+people\_area_sidebar.bxc
-last_topics
ForumReadUrlTemplate
TopicReadUrlTemplate
UserProfileUrlTemplate
	  
-tag_cloud      
TagLinkTemplate

-new_users
UserProfileUrlTemplate
	  
-search_form
SearchUrlTemplate

-new_blogs
BlogOwnerProfilePageUrlTemplate
BlogPageUrlTemplate     
";

	const string TemplatePatches =
@"+components2\bitrix\Bitrix.CommunitySite.Mvc\BlogIndexComponent\.default\template.bxc
-blog_list
BlogOwnerProfilePageUrlTemplate
BlogPageUrlTemplate

+components2\bitrix\Bitrix.CommunitySite.Mvc\PeopleIndexComponent\.default\list.bxc
-user_list
UserProfileUrlTemplate

+components2\bitrix\Bitrix.CommunitySite.Mvc\PeopleIndexComponent\.default\mail.bxc
-mail
UserProfileTemplate

+components2\bitrix\Bitrix.Main.Components\SystemLoginComponent2\main\template.bxc
-private_messages
MessageReadUrlTemplate
MessagesReadUrl";

	private void PatchFiles(string baseDir, string commands, string path)
	{			
		string currentPath = null;
		string currentComponent = null;
		Bitrix.Mvc.BXComponentXmlItems bxc = null;
		Bitrix.Mvc.BXComponent2XmlItem component = null;
		var files = new List<KeyValuePair<string, BXComponentXmlItems>>();
		
		using (var r = new StringReader(commands))
		{
			for (var line = r.ReadLine(); line != null; line = r.ReadLine())
			{
				line = line.Trim();
				if (string.IsNullOrEmpty(line))
				{
					continue;
				}

				if (line.StartsWith("+"))
				{					
					bxc = null;
					currentComponent = null;
					component = null;
					currentPath = Path.Combine(baseDir, line.Substring(1));	
				}
				else if (line.StartsWith("-"))
				{					
					component = null;
					currentComponent = line.Substring(1);
				}
				else
				{
					if (bxc == null)
					{
						if (currentPath == null)
						{
							throw new InvalidOperationException("Can't locate component without bxc file");
						}										
						if (!File.Exists(currentPath))
						{
							throw new InvalidOperationException(string.Format("'{0}' is not found", currentPath));
						}
						bxc = Bitrix.Mvc.BXComponent2Loader.LoadComponentsData(currentPath);						
						files.Add(new KeyValuePair<string, BXComponentXmlItems>(currentPath, bxc));
					}
					if (component == null)
					{
						if (currentComponent == null)
						{
							throw new InvalidOperationException("Can't locate property without component id");
						}
						foreach (var c in bxc.Components)
						{
							if (c.Id == currentComponent)
							{
								component = c;
								break;
							}
						}
						if (component == null)
						{
							throw new InvalidOperationException(string.Format("'{0}' is not found in '{1}'", currentComponent, currentPath));
						}
					}

					BXComponent2XmlItem parameter = null;
					foreach (var param in component.Parameters)
					{
						if (param.Id == line)
						{
							parameter = param;
							break;
						}
					}
					
					if (parameter == null)
					{
						throw new InvalidOperationException(string.Format("'{0}' is not found in '{1}@{2}'", line, currentComponent, currentPath));
					}
					
					
					string value = parameter.Value;
					if (value.StartsWith(path) || value.StartsWith("~/"))
					{
						continue;
					}
					
					if (value.StartsWith("/"))
					{
						value = value.Length > 1 ? value.Substring(1) : "";
					}
					parameter.Value = path + value;
				}
			}											
		}	
		
		foreach (var p in files)
		{
			p.Value.Save(p.Key);
		}		
	}
				
	protected override BXWizardResult OnActionShow(Bitrix.DataTypes.BXCommonBag parameters)
	{
		var	view = Result.Render("Установка решения");
		view.AutoRedirect = true;
		view.RedirectAction = "next";
		return view;
	}

	protected override BXWizardResult OnActionNext(Bitrix.DataTypes.BXCommonBag parameters)
	{
		var siteId = WizardContext.State.GetString("Installer.SiteId");
		var site = BXSite.GetById(siteId, BXTextEncoder.EmptyTextEncoder);
	
		this.PatchFiles(BXPath.MapPath(site.DirectoryVirtualPath), SitePatches, site.DirectoryAbsolutePath);
		this.PatchFiles(BXPath.MapPath("~/bitrix/templates/" + site.GetTemplate(site.UrlVirtualPath, HttpContext.Current)), TemplatePatches, site.DirectoryAbsolutePath);
		return Result.Next();
	}
</script>
Копирование файлов
<% UI.ProgressBar("Installer.ProgressBar"); %>