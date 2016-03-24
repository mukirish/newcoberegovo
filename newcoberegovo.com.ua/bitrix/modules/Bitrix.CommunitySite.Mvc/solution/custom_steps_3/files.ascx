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
<script runat="server">
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
		var solutionPath = WizardContext.State.GetString("Installer.SolutionPath");
		var p = WizardContext.State.Get<BXParamsBag<object>>("Bitrix.CommunitySite.Mvc.Settings");
		
		var rules = new List<BXInstallHelperFileRule>(new []
		{
			new BXInstallHelperFileRule { Regex = @"^area/"},			
			new BXInstallHelperFileRule { Regex = @"\.menu$" }
		});
		if (!p.GetBool("Overwrite"))
			rules.Insert(0, new BXInstallHelperFileRule { Overwrite = false, Include = true });
		
		BXInstallHelper.CopyDirectory(
			BXPath.Combine(solutionPath, "public"),
			site.DirectoryVirtualPath,
			rules
		);
		
		string areas = BXPath.MapPath(site.DirectoryVirtualPath + "area");
		Directory.CreateDirectory(areas);
		
		
		File.WriteAllText(Path.Combine(areas, "_area_logo_text.bxc"), BXC.GetEmptyBXC(), Encoding.UTF8);
		File.WriteAllText(Path.Combine(areas, "_area_logo_text.cshtml"), p.GetString("Header"), Encoding.UTF8);
		
		File.WriteAllText(Path.Combine(areas, "_area_copyright.bxc"), BXC.GetEmptyBXC(), Encoding.UTF8);
		File.WriteAllText(Path.Combine(areas, "_area_copyright.cshtml"), p.GetString("Copyright"), Encoding.UTF8);

		var template = WizardContext.State.GetString("Installer.Template");
		if (template == "taby")
		{
			string templateName = site.GetTemplate(site.UrlVirtualPath, HttpContext.Current);
			
			var pathToLogoHtml = Path.Combine(areas, "_area_logo_image.cshtml");
			var uploadedLogo = WizardContext.State.GetInt("UploadedLogo", 0);
			BXFile file = null;
			if (uploadedLogo > 0 && (file = BXFile.GetById(uploadedLogo)) != null)
			{
				var fileInfo = new FileInfo(BXPath.MapPath(file.FileVirtualPath));
				var destination = "~/bitrix/templates/" + templateName + "/images/logo" + fileInfo.Extension;

				UI.CopyFile(uploadedLogo, BXPath.MapPath(destination), true);
								
				File.WriteAllText(pathToLogoHtml, "<img src=\"" + VirtualPathUtility.ToAbsolute(destination) + "\" alt=\"\"/>", Encoding.UTF8);
			}
			else if (!File.Exists(pathToLogoHtml))
			{				
				File.Copy(BXPath.MapPath(BXPath.Combine(solutionPath, "public/area/_area_logo_image.cshtml")), pathToLogoHtml, true);				
			}
		}
		
		UI.SetProgressBarValue("Installer.ProgressBar", "Bitrix.CommunitySite.Mvc", 1);
		return Result.Next();
	}
</script>
Копирование файлов
<% UI.ProgressBar("Installer.ProgressBar"); %>