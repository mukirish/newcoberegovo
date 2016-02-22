﻿<%@ Control Language="C#" AutoEventWireup="true" Inherits="Bitrix.UI.Wizards.BXWizardStepStandardHtmlControl" %>
<%@ Reference VirtualPath="../tools/IBlock.ascx" %>
<%@ Import Namespace="Bitrix" %>
<%@ Import Namespace="Bitrix.DataTypes" %>
<%@ Import Namespace="Bitrix.IO" %>
<%@ Import Namespace="Bitrix.Services.Text" %>
<%@ Import Namespace="Bitrix.UI.Wizards" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="Bitrix.Install.Internal" %>
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
		if (!WizardContext.State.Get<BXParamsBag<object>>("Bitrix.CorporateSite.Settings").GetBool("InstallDemoData"))
			return Result.Next();
	
		var siteId = WizardContext.State.GetString("Installer.SiteId");
		var userId = WizardContext.State.GetInt("Installer.UserId");
		var solutionPath = WizardContext.State.GetString("Installer.SolutionPath");
				
		var importer = new IBlockXmlImporter(siteId, "Bitrix.CorporateSite", "iblock");
		importer.LoadInfoBlocks(BXPath.MapPath(BXPath.Combine(solutionPath, "data/iblock_data.xml")));
		UI.SetProgressBarValue("Installer.ProgressBar", "Bitrix.CorporateSite", 3);
		return Result.Next();
	}
</script>
Загрузка демонстрационных данных
<% UI.ProgressBar("Installer.ProgressBar"); %>