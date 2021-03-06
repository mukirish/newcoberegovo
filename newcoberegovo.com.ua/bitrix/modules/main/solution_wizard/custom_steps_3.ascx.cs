﻿using Bitrix.IO;
using Bitrix.UI.Wizards;
using Bitrix.DataTypes;

namespace Bitrix.Wizards.Solutions
{
	public partial class CustomSteps3WizardStep : BXWizardStepStandardHtmlControl, IBXWizardSubSequenceProvider
	{
		protected override BXWizardResult OnWizardAction(string action, BXCommonBag parameters)
		{
			switch (action)
			{
				case "sequence_finish":
					{
						WizardContext.State["Installer.CustomSteps3.GoBack"] = "";
						if(WizardContext.State.GetBool("Installer.Terminate", false))
							return new BXWizardResultFinish();

						return Result.Next();
					}
				case "sequence_cancel":
					WizardContext.State.Remove("Installer.CustomSteps3.GoBack");
					return Result.Previous();
				default:
					return base.OnWizardAction(action, parameters);
			}
		}

		protected override BXWizardResult OnActionShow(BXCommonBag parameters)
		{
			string path = BXPath.Combine((string)WizardContext.State["Installer.SolutionPath"], "custom_steps_3");
			string fullPath = BXPath.MapPath(path);

			if (WizardContext.State.ContainsKey("Installer.CustomSteps3.GoBack"))
			{
				WizardContext.State.Remove("Installer.CustomSteps3.GoBack");
				if (System.IO.Directory.Exists(fullPath))
					return BXWizard.StartSequence("", true, false);
				else 
					return Result.Previous();
			}
			else
			{
				WizardContext.State["Installer.CustomSteps3.GoBack"] = "";
				if (System.IO.Directory.Exists(fullPath))
					return BXWizard.StartSequence("", false, true);
				else 
					return Result.Next();
			}
		}

		#region IBXWizardSubSequenceProvider Members

		public string GetSubSequencePath(string id, BXWizardContext context)
		{
			return BXPath.Combine((string)context.State["Installer.SolutionPath"], "custom_steps_3");
		}

		#endregion
	}
}