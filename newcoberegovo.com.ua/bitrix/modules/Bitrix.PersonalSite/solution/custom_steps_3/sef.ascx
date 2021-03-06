﻿<%@ Control Language="C#" AutoEventWireup="true" Inherits="Bitrix.UI.Wizards.BXWizardStepStandardHtmlControl" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="Bitrix" %>
<%@ Import Namespace="Bitrix.Install" %>
<%@ Import Namespace="Bitrix.IO" %>
<%@ Import Namespace="Bitrix.Services.Text" %>
<%@ Import Namespace="Bitrix.UI.Wizards" %>
<script runat="server">
	//const string SefConfig = "sef.personal.config";
	//const string PathPrefix = "~/site"; // No slash at the end
	
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
		Bitrix.Services.BXSefUrlManager.RefreshComponentSefState(siteId);
		UI.SetProgressBarValue("Installer.ProgressBar", "Bitrix.PersonalSite", 7);
		return new BXWizardResultFinish();
	}
</script>
Настройка ЧПУ
<% UI.ProgressBar("Installer.ProgressBar"); %>