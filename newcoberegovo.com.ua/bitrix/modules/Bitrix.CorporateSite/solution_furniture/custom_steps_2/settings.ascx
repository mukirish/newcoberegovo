﻿<%@ Control Language="C#" AutoEventWireup="true" Inherits="Bitrix.UI.Wizards.BXWizardStepStandardHtmlControl" %>
<%@ Import Namespace="Bitrix" %>
<%@ Import Namespace="Bitrix.Blog" %>
<%@ Import Namespace="Bitrix.Configuration" %>
<%@ Import Namespace="Bitrix.DataLayer" %>
<%@ Import Namespace="Bitrix.DataTypes" %>
<%@ Import Namespace="Bitrix.IO" %>
<%@ Import Namespace="Bitrix.Services.Text" %>
<%@ Import Namespace="Bitrix.UI.Wizards" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.IO" %>
<script runat="server">
	const string Key = "Bitrix.CorporateSite.Settings";
	string sloganUrl,bannerUrl,logoUrl;
	
	protected override void OnWizardInit()
	{
		if (WizardContext.State.Get<BXParamsBag<object>>(Key) != null)
			return;
		
		var parameters = new BXParamsBag<object>();
		WizardContext.State[Key] = parameters;
		
		var siteId = WizardContext.State.GetString("Installer.SiteId");
		var site = BXSite.GetById(siteId, BXTextEncoder.EmptyTextEncoder);
	
		var slogan = BXPath.MapPath(site.DirectoryVirtualPath + "src/slogan.html");
		parameters["Slogan"] = File.Exists(slogan) ? File.ReadAllText(slogan, Encoding.UTF8) : "Слоган компании\r\n<br>&nbsp&nbsp находится в этом месте";

		var footer = BXPath.MapPath(site.DirectoryVirtualPath + "src/copyright.html");
		parameters["Copyright"] = File.Exists(footer) ? File.ReadAllText(footer, Encoding.UTF8) : @"<p>© 2001-2010 «Название компании»</p>
<p>Проспект Мира, 35, строение 2, офис 34</p>
<p><b>Телефон: (495) 212-85-06</b></p>
";

		bool check = !string.Equals(BXOptionManager.GetOptionString("main", "InstalledSolution", null, WizardContext.State.GetString("Installer.SiteId")), "Bitrix.CorporateSite");
		parameters["InstallDemoData"] = check;
		parameters["Overwrite"] = check;
	}		
	protected override BXWizardResult OnActionShow(Bitrix.DataTypes.BXCommonBag parameters)
	{
		UI.Load(Key);

		return PrepareView(null);
	}

	protected override BXWizardResult OnActionPrevious(Bitrix.DataTypes.BXCommonBag parameters)
	{
		return new BXWizardResultCancel();
	}
	
	protected override BXWizardResult OnActionNext(Bitrix.DataTypes.BXCommonBag parameters)
	{
		UI.LoadValues(parameters);
		UI.Data["Copyright"] = UI.Data.GetString("Copyright") ?? "";
		UI.Overwrite(Key);
		UI.SetProgressBarMaxValue("Installer.ProgressBar", "Bitrix.CorporateSite", 7);
		return new BXWizardResultFinish();
	}

	private BXWizardResult PrepareView(List<string> errors)
	{
		var siteId = WizardContext.State.GetString("Installer.SiteId");
		var site = BXSite.GetById(siteId, BXTextEncoder.EmptyTextEncoder);
		var template = WizardContext.State.GetString("Installer.Template");
		var solutionPath = WizardContext.State.GetString("Installer.SolutionPath");
		sloganUrl = VirtualPathUtility.ToAbsolute(BXPath.Combine(solutionPath, "templates/" + template + "/images/banner_processed.png"));
		var uploadedLogo = WizardContext.State.GetInt("UploadedLogo", 0);
		var currentLogo = BXPath.MapPath(site.DirectoryVirtualPath + "src/logo.html");
		var defaultLogo = VirtualPathUtility.ToAbsolute(BXPath.Combine(solutionPath, "templates/" + template + "/themes/" + WizardContext.State.GetString("Installer.Theme") + "/images/logo.gif")); ;

		BXFile logoFile = null; 
		if (uploadedLogo > 0 && (logoFile = BXFile.GetById(uploadedLogo, BXTextEncoder.EmptyTextEncoder)) != null)
		{
			logoUrl = HttpUtility.HtmlAttributeEncode(logoFile.FilePath);
		}
		else if (File.Exists(currentLogo))
		{
			var logoFileContent = File.ReadAllText(currentLogo, Encoding.UTF8);
			var regex = new Regex(@"src=[""']([^""']*)[""']", RegexOptions.IgnoreCase);
			Match m = regex.Match(logoFileContent);
			string logoSrcPath = m.Success ? HttpUtility.HtmlDecode(m.Groups[1].Captures[0].Value) : String.Empty;
			if (!logoSrcPath.EndsWith("default_logo.gif"))
			{
				Uri url;
				if (!String.IsNullOrEmpty(logoSrcPath) && Uri.TryCreate(HttpContext.Current.Request.Url, logoSrcPath, out url))
				{
					try
					{
						var serverPath = System.Web.Hosting.HostingEnvironment.MapPath(HttpUtility.UrlDecode(url.AbsolutePath));
						if (File.Exists(serverPath))
							logoUrl = logoSrcPath;
					}
					catch { }
				}
			}
			else
				logoUrl = defaultLogo;
		}
		else
			logoUrl = defaultLogo;
		
		var uploadedBanner = WizardContext.State.GetInt("UploadedBanner", 0);
		var currentBanner = BXPath.MapPath(site.DirectoryVirtualPath + "src/banner.html");
		var defaultBanner = VirtualPathUtility.ToAbsolute(BXPath.Combine(solutionPath, "public/src/banner.jpg"));
		BXFile bannerFile = null;

		if (uploadedBanner > 0 && (bannerFile = BXFile.GetById(uploadedBanner, BXTextEncoder.EmptyTextEncoder)) != null)
		{
			bannerUrl = HttpUtility.HtmlAttributeEncode(bannerFile.FilePath);
		}
		else if (File.Exists(currentBanner))
		{
			var bannerFileContent = File.ReadAllText(currentBanner, Encoding.UTF8);
			var regex = new Regex(@"src=[""']([^""']*)[""']", RegexOptions.IgnoreCase);
			Match m = regex.Match(bannerFileContent);
			string bannerSrcPath = m.Success ? HttpUtility.HtmlDecode(m.Groups[1].Captures[0].Value) : String.Empty;
			Uri url;
			if (!String.IsNullOrEmpty(bannerSrcPath) && Uri.TryCreate(HttpContext.Current.Request.Url, bannerSrcPath, out url))
			{
				try
				{
					var serverPath = System.Web.Hosting.HostingEnvironment.MapPath(HttpUtility.UrlDecode(url.AbsolutePath));
					if (File.Exists(serverPath))
						bannerUrl = bannerSrcPath;
				}
				catch { }
			}
		}
		else
			bannerUrl = defaultBanner;


		var view = Result.Render("Настройка решения", errors);
		view.Buttons.Add("prev", null);
		view.Buttons.Add("next", null);
		return view;
	}

	
	protected override BXWizardResult OnWizardAction(string action, BXCommonBag parameters)
	{
		List<string> errors = new List<string>();
		if (action == "upload_logo")
		{
			UI.LoadValues(parameters);

			var fileId = 0;
			
			try
			{
				var settings = new BXParamsBag<object>();
				settings["maxFileSize"] = 1024 * 300;
				settings["maxWidth"] = 210;
				settings["maxHeight"] = 60;
				fileId = UI.SaveImage("Logo", settings, errors);

			}
			catch (Exception ex)
			{
				errors = new List<string>() { {ex.Message} };
			}
			
			if (fileId > 0)
				WizardContext.State["UploadedLogo"] = fileId;

			UI.Overwrite(Key);

			return PrepareView(errors);
		}
		else if (action == "upload_banner")
		{
			UI.LoadValues(parameters);

			var fileId = 0;
			
			try
			{
				var settings = new BXParamsBag<object>();
				settings["maxFileSize"] = 1024 * 300;
				fileId = UI.SaveImage("Banner", settings, errors);
			}
			catch (Exception ex)
			{
				errors = new List<string>() { { ex.Message } };
			}

			if (fileId > 0)
				WizardContext.State["UploadedBanner"] = fileId;

			UI.Overwrite(Key);
			return PrepareView(errors);
		}
		
		return base.OnWizardAction(action, parameters);
	}
	
</script>
<% 
	var input_logo = new[] { new KeyValuePair<string, string>("onchange", "return WizardSubmit('upload_logo');") };
	var input_banner = new[] { new KeyValuePair<string, string>("onchange", "return WizardSubmit('upload_banner');") };
	var textarea = new[] { new KeyValuePair<string, string>("rows", "5") }; 
%>
<div class="wizard-input-form">
	<div class="wizard-input-form-block">
		<h4>Логотип (максимальный размер 210 X 60)</h4>
		<div class="wizard-input-form-block-content">
			<% if ( !String.IsNullOrEmpty(logoUrl)) { %>
			<img src="<%=logoUrl %>?t=<%=DateTime.Now.Ticks %>" alt="" />
			<% } %>
			<div class="wizard-input-form-field wizard-input-form-field-file"><% UI.InputFile("Logo", input_logo); %></div>
		</div>
	</div>
	
	<div class="wizard-input-form-block">
		<h4>Баннер (рекомендуемый размер 400 Х 140)</h4>
		<div class="wizard-input-form-block-content">
			<% if ( !String.IsNullOrEmpty(bannerUrl)) { %>
			<div style="width:400px; height:140px; overflow:hidden;">
				<img src="<%=bannerUrl %>?t=<%=DateTime.Now.Ticks %>" />
			</div>
			<% } %>
			<div class="wizard-input-form-field wizard-input-form-field-file"><% UI.InputFile("Banner", input_banner); %></div>
		</div>
	</div>

	<div class="wizard-input-form-block">
		<h4>Слоган компании</h4>
		<div class="wizard-input-form-block-content">
			<div class="wizard-input-form-field wizard-input-form-field-textarea"><% UI.Textarea("Slogan", textarea); %></div>
			<div style="width:400px;height:100px;overflow:hidden;">
				<img src="<%= sloganUrl %>" alt="" class="no-border" />
			</div>
		</div>
	</div>
	
	<div class="wizard-input-form-block">
		<h4>Подпись сайта</h4>
		<div class="wizard-input-form-block-content">
			<div class="wizard-input-form-field wizard-input-form-field-textarea"><% UI.Textarea("Copyright", textarea); %></div>
		</div>
	</div>

	<div class="wizard-input-form-block">
		<div class="wizard-input-form-block-content">
			<div class="wizard-input-form-field wizard-input-form-field-checkbox"><% UI.CheckBox("InstallDemoData", "Установить демонстрационные данные", null); %></div>
			<div class="wizard-input-form-field wizard-input-form-field-checkbox"><% UI.CheckBox("Overwrite", "Перезаписать существующие файлы", null); %></div>
		</div>
	</div>
</div>