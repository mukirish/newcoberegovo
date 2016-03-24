<%@ Control Language="C#" AutoEventWireup="true" Inherits="Bitrix.UI.Wizards.BXWizardStepStandardHtmlControl" %>
<%@ Import Namespace="Bitrix.DataTypes" %>
<%@ Import Namespace="Bitrix.IO" %>
<%@ Import Namespace="Bitrix.UI.Wizards" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="Bitrix.CommunitySite.Mvc" %>
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
		var userId = WizardContext.State.GetInt("Installer.UserId");
		var solutionPath = WizardContext.State.GetString("Installer.SolutionPath");
		var p = WizardContext.State.Get<BXParamsBag<object>>("Bitrix.PersonalSite.Settings");
	
		UserXmlImporter userImport = new UserXmlImporter();
		userImport.LoadUsers(BXPath.MapPath(BXPath.Combine(solutionPath, "data/user.xml")));

		ForumXmlImporter forumImport = new ForumXmlImporter(siteId);
		forumImport.LoadForums(BXPath.MapPath(BXPath.Combine(solutionPath, "data/forum.xml")));

		BlogXmlImporter blogImport = new BlogXmlImporter(siteId, 1, "Bitrix.CommunitySite.Mvc");
		blogImport.LoadBlogs(BXPath.MapPath(BXPath.Combine(solutionPath, "data/blog.xml")));	
		
		UI.SetProgressBarValue("Installer.ProgressBar", "Bitrix.CommunitySite.Mvc", 2);
		return Result.Next();
	}
</script>
Создание вспомогательных структур
<% UI.ProgressBar("Installer.ProgressBar"); %>