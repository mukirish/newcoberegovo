using System;
using System.Collections.Generic;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Xml;
using Bitrix.IO;
using Bitrix.Modules;
using Bitrix.UI.Wizards;
using Bitrix.DataTypes;
using Bitrix.DataLayer;

namespace Bitrix.Wizards.Install
{
	using System.Web.Hosting;

	public partial class InstallMvcWizardStep : BXWizardStepStandardHtmlControl
	{
		protected override void OnWizardInit()
		{
			UI.SetProgressBarMaxValue("Installer.ProgressBar", "Mvc", 7);
		}

		List<string> errors;
		private List<string> Errors
		{
			get { return errors ?? (errors = new List<string>()); }
		}

		protected string htmlMessage;
		private BXWizardResult ShowStatus(string htmlMessage, string nextStep, string nextAction)
		{
			this.htmlMessage = htmlMessage;
			BXWizardResultView view = Result.Render(GetMessage("Title"), errors);
			if ((errors == null || errors.Count == 0) && (!string.IsNullOrEmpty(nextStep) || !string.IsNullOrEmpty(nextAction)))
			{
				view.AutoRedirect = true;
				view.RedirectStep = nextStep;
				view.RedirectAction = nextAction;
			}
			WizardContext.Navigation.Selected = "install";
			return view;
		}

		protected override BXWizardResult OnWizardAction(string action, BXCommonBag parameters)
		{
			switch (action)
			{
				case "":
					return ShowStatus(GetMessage("SubTitle.Database"), null, "database");
				case "database":
					return Database();
				case "systemfiles":
					return SystemFiles();
				case "defaulttemplate":
					return DefaultTemplate();
				case "installapplication":
					return InstallApplication();
				case "applicationconfiguration":
					return ApplicationConfiguration();
				case "afterrestart":
					return AfterRestart();
				case "data":
					return Data();
				case "finalize":
					return Finalize();
				default:
					return base.OnWizardAction(action, parameters);
			}
		}

		private string ConnectionString
		{
			get { return (string)WizardContext.State["Install.ConnectionString"]; }
		}

		private BXWizardResult Database()
		{
			Bitrix.Services.BXLoc.CurrentLocale = WizardContext.Locale;
			BXApplicationHelper.ApplicationType = BXApplicationTechnologyType.Mvc;
			Bitrix.Modules.BXModule module = Bitrix.Modules.BXModuleManager.LoadModule("mvc");
			Bitrix.Modules.BXModuleInstaller mi = module.GetInstaller();
			
			mi.InstallDB();
			UI.SetProgressBarValue("Installer.ProgressBar", "Mvc", 1);
			return ShowStatus(GetMessage("SubTitle.Files"), null, "systemfiles");
		}
		private BXWizardResult SystemFiles()
		{
			Bitrix.Services.BXLoc.CurrentLocale = WizardContext.Locale;
			BXApplicationHelper.ApplicationType = BXApplicationTechnologyType.Mvc;
			Bitrix.Modules.BXModule module = Bitrix.Modules.BXModuleManager.LoadModule("mvc");
			Bitrix.Modules.BXModuleInstaller mi = module.GetInstaller();
						
			mi.InstallFiles();
			InstallAssemblies();
			
			UI.SetProgressBarValue("Installer.ProgressBar", "Mvc", 2);
			return ShowStatus(GetMessage("SubTitle.Files"), null, "defaulttemplate");
		}

		private void InstallAssemblies()
		{
			string binPath = BXPath.MapPath("~/bin");
			DirectoryInfo moduleBin = new DirectoryInfo(BXPath.MapPath("~/bitrix/modules/Mvc/install/bin/"));

			if (moduleBin.Exists)
			{
				string asmName = "Main.Mvc";
				string configPath = BXPath.MapPath("~/bitrix/modules/Mvc/module.config");
				BXModuleConfig config = new BXModuleConfig(configPath);
				if (config != null)
					asmName = config.ModuleAssembly ?? asmName;				

				if (config != null)
				{
					foreach (BXModuleLibraryInfo l in config.PrivateLibraries)
					{
						foreach (FileInfo dll in moduleBin.GetFiles(String.Format("{0}.*", l.Name)))
						{
							File.SetAttributes(dll.FullName, FileAttributes.Normal);
							dll.CopyTo(Path.Combine(binPath, dll.Name), true);
						}
					}
				}				

				foreach (FileInfo dll in moduleBin.GetFiles(String.Format("{0}.*", asmName)))
				{
					File.SetAttributes(dll.FullName, FileAttributes.Normal);
					dll.CopyTo(Path.Combine(binPath, dll.Name), true);
				}
			}
		}


		private BXWizardResult DefaultTemplate()
		{
			File.Copy(
				HostingEnvironment.MapPath(AppRelativeTemplateSourceDirectory + "razor.config"),
				HostingEnvironment.MapPath("~/bitrix/templates/web.config"),
				true
			);

			var dir = HostingEnvironment.MapPath("~/Sites/default/");
			Directory.CreateDirectory(dir);

			File.Copy(
				HostingEnvironment.MapPath(AppRelativeTemplateSourceDirectory + "razor.config"),
				HostingEnvironment.MapPath("~/Sites/web.config"),
				true
			);

			File.WriteAllText(
				dir + "Default.bxc",
@"<?xml version=""1.0"" encoding=""utf-8""?>
<container />",
				Encoding.UTF8
			);

			File.WriteAllText(
				dir + "Default.cshtml",
				Bitrix.Services.BXLoc.GetMessage("~/bitrix/install/installer.ascx", "DefaultPageContent"),
				Encoding.UTF8
			);

			UI.SetProgressBarValue("Installer.ProgressBar", "Mvc", 3);
			return ShowStatus(GetMessage("SubTitle.AppConfiguration"), null, "applicationconfiguration");
		}

		private BXWizardResult ApplicationConfiguration()
		{
			Bitrix.Services.BXLoc.CurrentLocale = WizardContext.Locale;
			BXApplicationHelper.ApplicationType = BXApplicationTechnologyType.Mvc;
			Bitrix.Modules.BXModule module = Bitrix.Modules.BXModuleManager.LoadModule("mvc");
			Bitrix.Modules.BXModuleInstaller mi = module.GetInstaller();

			XmlDocument doc = new XmlDocument();
			doc.Load(HostingEnvironment.MapPath("~/web.config"));
			mi.InstallAppConfiguration(doc);
			doc.Save(HostingEnvironment.MapPath("~/web.config"));

			UI.SetProgressBarValue("Installer.ProgressBar", "Mvc", 4);
			return ShowStatus(GetMessage("SubTitle.AppConfiguration"), null, "installapplication");
		}
		private BXWizardResult InstallApplication()
		{
			File.WriteAllText(				
				HostingEnvironment.MapPath("~/global.asax"), 
				@"<%@ Application Inherits=""Bitrix.Mvc.BXMvcApplication"" Language=""C#"" %>",
				Encoding.UTF8
			); 
			UI.SetProgressBarValue("Installer.ProgressBar", "Mvc", 5);
			return ShowStatus(GetMessage("SubTitle.Restart"), null, "afterrestart");			
		}
				
		private BXWizardResult AfterRestart()
		{
			if (BXApplicationHelper.ApplicationType != BXApplicationTechnologyType.Mvc)
			{
				File.SetLastWriteTime(BXPath.MapPath("~/web.config"), DateTime.Now);
				return ShowStatus(GetMessage("SubTitle.Restart"), null, "afterrestart");
			}
			UI.SetProgressBarValue("Installer.ProgressBar", "Mvc", 6);
			return ShowStatus(GetMessage("SubTitle.Configuration"), null, "data");
		}

		private BXWizardResult Data()
		{
			Bitrix.Services.BXLoc.CurrentLocale = WizardContext.Locale;			
			Bitrix.Modules.BXModule module = Bitrix.Modules.BXModuleManager.LoadModule("mvc");
			Bitrix.Modules.BXModuleInstaller mi = module.GetInstaller();

			mi.InstallData();
			mi.InstallEvents();
			UI.SetProgressBarValue("Installer.ProgressBar", "Mvc", 7);
			return ShowStatus(GetMessage("SubTitle.Configuration"), null, "finalize");
		}
		private BXWizardResult Finalize()
		{
			BXModuleManager.RegisterModuleInstallation("mvc");									
						
			return Result.Next();
		}		
	}
}