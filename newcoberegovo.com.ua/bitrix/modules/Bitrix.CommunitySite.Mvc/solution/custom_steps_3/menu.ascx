<%@ Control Language="C#" AutoEventWireup="true" Inherits="Bitrix.UI.Wizards.BXWizardStepStandardHtmlControl" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="Bitrix" %>
<%@ Import Namespace="Bitrix.Install" %>
<%@ Import Namespace="Bitrix.IO" %>
<%@ Import Namespace="Bitrix.Services.Text" %>
<%@ Import Namespace="Bitrix.UI.Wizards" %>

<script runat="server">
	const string LinkPrefix = "site";
	static readonly KeyValuePair<string, string>[] MenuTypes = 
	{
		new KeyValuePair<string, string>("main", "Главное меню"),
		new KeyValuePair<string, string>("submenu", "Меню подраздела"),
		new KeyValuePair<string, string>("bottom", "Нижнее меню"),
	};

	protected override BXWizardResult OnActionShow(Bitrix.DataTypes.BXCommonBag parameters)
	{
		var view = Result.Render("Установка решения");
		view.AutoRedirect = true;
		view.RedirectAction = "next";
		return view;
	}

	protected override BXWizardResult OnActionNext(Bitrix.DataTypes.BXCommonBag parameters)
	{
		var siteId = WizardContext.State.GetString("Installer.SiteId");		
		var menuItems = BXPublicMenu.GetMenuTypes(siteId, true);
		foreach(var p in MenuTypes)
		{
			if (!menuItems.ContainsKey(p.Key))
				menuItems[p.Key] = p.Value;
		}
		BXPublicMenu.SetMenuTypes(siteId, menuItems);

		var site = BXSite.GetById(siteId);
		var sitePrefix = site.UrlVirtualPath;
		
		var solutionPath = WizardContext.State.GetString("Installer.SolutionPath");
		var rootDir = BXPath.Combine(solutionPath, "public");
		BXInstallHelper.ProcessFiles(
			rootDir,
			delegate(FileInfo file, string rel)
			{

				BXPublicMenuItemCollection items;
				using (var stream = file.OpenRead())
				using (var reader = System.Xml.XmlReader.Create(stream))
					items = BXPublicMenu.LoadXml(reader);

				foreach (var item in items)
				{
					for (int i = item.Links.Count - 1; i >= 0; i--)
					{
						var link = item.Links[i];
						if (link.StartsWith("~/", StringComparison.OrdinalIgnoreCase))
							continue;

						item.Links[i] = sitePrefix + link.TrimStart('/');
					}
				}

				var settings = new System.Xml.XmlWriterSettings();
				settings.Encoding = Encoding.UTF8;
				settings.Indent = true;
				settings.IndentChars = "\t";
				using (var writer = System.Xml.XmlWriter.Create(BXPath.MapPath(site.DirectoryVirtualPath + rel), settings))
				{
					writer.WriteStartDocument();
					BXPublicMenu.SaveXml(writer, items);
				}
			},
			new[]
			{
				new BXInstallHelperFileRule(), // ignore all
				new BXInstallHelperFileRule { Regex = @"\.menu$", Include = true }
			}
		);
		
		
		BXPublicMenu.Menu.RefreshSettings();
		
		UI.SetProgressBarValue("Installer.ProgressBar", "Bitrix.CommunitySite.Mvc", 4);
		return Result.Next();
	}
	
	
</script>
Настройка меню
<% UI.ProgressBar("Installer.ProgressBar"); %>