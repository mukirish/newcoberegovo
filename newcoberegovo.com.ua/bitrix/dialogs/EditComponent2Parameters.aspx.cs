using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using Bitrix;
using Bitrix.Components;
using Bitrix.Components.Editor;
using Bitrix.DataTypes;
using Bitrix.IO;
using Bitrix.Security;
using Bitrix.UI;
using Bitrix.Services.Undo;
using System.Text;
using System.Reflection;
using System.Linq;
using Bitrix.UI;
using Bitrix.Mvc;


public partial class BXDialogEditComponent2Parameters : BXDialogPage
{
    private string assemblyQualifiedTypeName = string.Empty;
    private Type type;
    private BXComponent2ModificatorBase componentModificator;
    private BXComponent2 component;
    private BXComponent2Proxy componentProxy;
	//private Dictionary<string, BXComponent2ParameterDesignerBase> designers;
	//private List<BXCategory> parameterCategories;
    private string targetFileAppRelPath = string.Empty;
    private string id = string.Empty;
    private string siteId = string.Empty;

    private List<string> viewIds = new List<string>();

    private ErrorType error = ErrorType.None;

    protected override void OnPreInit(EventArgs e)
    {
        base.OnPreInit(e);

        this.assemblyQualifiedTypeName = Request["typeName"] ?? string.Empty;
        if (string.IsNullOrEmpty(this.assemblyQualifiedTypeName))
        {
            this.error = ErrorType.TypeNameNotFound;
            return;
        }

        this.type = Type.GetType(this.assemblyQualifiedTypeName);
        if (this.type == null)
        {
            this.error = ErrorType.TypeNotFound;
            return; 
        }

        this.targetFileAppRelPath = Request["path"];
        if (string.IsNullOrEmpty(this.targetFileAppRelPath))
        {
            this.error = ErrorType.PathNotFound;
            return;
        }

        this.siteId = Request["siteId"];
        if (string.IsNullOrEmpty(this.siteId) && BXSite.DefaultSite != null)
        {
            this.siteId = BXSite.DefaultSite.Id;
        }

        this.id = Request["id"];
        if (string.IsNullOrEmpty(this.id))
        {
            this.error = ErrorType.IdNotFound;
            return;
        }

		string assemblyQualifiedModTypeName = Request["modTypeName"];
		if (string.IsNullOrEmpty(assemblyQualifiedModTypeName))
		{
			this.error = ErrorType.TypeNameNotFound;
			return;
		}

		Type modType = Type.GetType(assemblyQualifiedModTypeName);
		if (modType == null)
		{
			this.error = ErrorType.TypeNotFound;
			return;
		}

        //потом инстанцировать из переданного описания типа
		this.componentModificator = (BXComponent2ModificatorBase)Activator.CreateInstance(modType);
		this.componentProxy = (BXComponent2Proxy)componentModificator.LoadComponent(this.targetFileAppRelPath, this.siteId, this.type, this.id, null);
        if (this.componentProxy == null)
        {
            this.error = ErrorType.FailedLoad;
            return;
        }

        this.component = this.componentProxy.Component;

		if (IsPostBack)
		{
			IList<string> addedItems = new List<string>();
			var propertyNames = this.component.GetPropertyNames();
			var items = HttpContext.Current.Request.Params.AllKeys.Where(r => r.Contains(this.id) && !r.Contains("$ExpEd$Pref") && !r.Contains("$ExpEd$Exp"));
			foreach (var item in items)
			{
				var attributeName = string.Empty;
				var attributeValue = string.Empty;
				
				if (item.Contains("$ParamView"))
				{
					attributeName = item.Replace(this.id + "_", string.Empty).Replace("$ParamView", string.Empty);
					attributeValue = HttpContext.Current.Request.Params[item];
				}
				else if (item.Contains("$SelectedMode"))
				{
					attributeName = item.Replace(this.id + "_", string.Empty).Replace("$SelectedMode", string.Empty);
				}

				if (!addedItems.Contains(attributeName))
				{
					if (attributeValue == "on")
					{
						attributeValue = "True";
					}
					else if (attributeValue == "off")
					{
						attributeValue = "False";
					}
					if (propertyNames.Contains(attributeName))
					{
						this.component.SetPropertyString(attributeName, attributeValue);
					}
					else
					{
						string category = string.Empty;
						for (int i = 1; i < attributeName.Length; i++)
						{
							if (char.IsUpper(attributeName[i]))
							{
								category = attributeName.Substring(0, i - 1);
								break;
							}
						}

						var property = this.component.GetProperty(category) as IBXComponent2PropertyContainer;
						if (property != null)
						{
							KeyValuePair<string, BXParam> param;
							if (category.Equals("Caching"))
							{
								category = "CacheSettings";
							}
							param = this.componentProxy.GetParametersDefinitionByCategory(new BXCategory(category, category, 0)).SingleOrDefault(r => r.Key == attributeName);
							if(param.Value != null)
							{
								property.SetPropertyString(attributeName.Replace(category.Equals("CacheSettings") ? "Caching" : category, string.Empty).Replace(".", string.Empty), attributeValue);
							}
						}
					}
					addedItems.Add(attributeName);
				}
			}
		}

		//TODO: Add parameters for MVC
		if (BXApplicationHelper.ApplicationType == BXApplicationTechnologyType.Mvc)
		{
			Behaviour.EnableFormIdReplace = false;
		}
    }

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);

		if (this.error != ErrorType.None || !CheckUserAuthorization())
		{
			return;
		}

    	foreach (var item in this.componentProxy.ParametersDefinition)
    	{
			BXComponentParameterView control = new BXComponentParameterViewComboExpressionEditor(BXComponentParameterViewFactory.Create(this.componentProxy, item.Key, item.Value));
			this.componentParameters.Controls.Add(control);
			control.ClientScript = ClientScript;
			viewIds.Add(control.UniqueID);
    	}

        Title = GetMessage("DIALOG_TITLE_EDIT_COMPONENT_PARAMETERS");

        Behaviour.Settings.MinWidth = 500;
        Behaviour.Settings.MinHeight = 300;
        Behaviour.Settings.Width = 700;
        Behaviour.Settings.Height = 400;
        Behaviour.Settings.Resizeable = true;
        Behaviour.ValidationGroup = MainValidationGroupName;

        DescriptionTitle = HttpUtility.HtmlEncode(this.componentProxy.Title);
        DescriptionContent = HttpUtility.HtmlEncode(this.componentProxy.Description);
        DescriptionNotes = HttpUtility.HtmlEncode(this.componentProxy.Name);
        DescriptionIconImageUrl = VirtualPathUtility.ToAbsolute(BXComponent2.GetComponentVirtualDirectory(this.componentProxy.Name) + "images/icon.gif");
    }

    /// <summary>
    /// Имя главной группы валидации
    /// </summary>
    protected string MainValidationGroupName
    {
        get { return "EditComponentParametersDialog"; }
    }

    /// <summary>
    /// Модификатор компонента
    /// </summary>
    protected BXComponent2ModificatorBase ComponentModificator
    {
        get { return this.componentModificator; }
    }

    /// <summary>
    /// Компонент
    /// </summary>
    protected BXComponent2 Component
    {
        get { return this.component; }
    }

    public IList<BXCategory> ComponentCategories
    {
        get { return this.componentProxy != null ? this.componentProxy.ParameterCategories : null; }
    }

    public BXParametersDefinition GetComponentParamDefinitionByCategory(BXCategory category)
    {
        return this.componentProxy != null ? this.componentProxy.GetParametersDefinitionByCategory(category) : null;
    }

    /// <summary>
    /// Сгенерировать разметку для параметра компонента
    /// </summary>
    /// <param name="parameter"></param>
    /// <param name="key"></param>
    /// <returns></returns>
    protected string RenderComponentRow(BXParam parameter, string key)
    {
        if (parameter == null)
            throw new ArgumentNullException("parameter");
        if (string.IsNullOrEmpty(key))
            throw new ArgumentException("Is not assigned!", "key");

        HtmlTableRow row = new HtmlTableRow();
        row.ID = string.Concat("paramcontainer_", HttpUtility.HtmlAttributeEncode(key));
        row.Attributes.Add("class", "paramcontainer");
        if (!parameter.Visible)
            row.Attributes.Add("style", "display:none;");
        HtmlTableCell legendCell = new HtmlTableCell();
        row.Cells.Add(legendCell);
        legendCell.Attributes.Add("class", "bx-popup-label bx-width50");
        legendCell.InnerHtml = string.Concat(HttpUtility.HtmlEncode(parameter.Title), ":");

        HtmlTableCell dataCell = new HtmlTableCell();
        row.Cells.Add(dataCell);

        BXComponentParameterView parameterControl = (BXComponentParameterView)componentParameters.FindControl(BXComponentParameterView.GetDefaultID(this.componentProxy, key));
		if (parameterControl == null)
		{
			//return string.Empty;
			throw new InvalidOperationException(string.Format("Could not find control for component parameter key '{0}'!", key));
		}

    	HtmlGenericControl dataContainer = new HtmlGenericControl("DIV");
        dataContainer.Attributes.CssStyle["float"] = "left !important";
        dataContainer.Controls.Add(parameterControl);
        dataCell.Controls.Add(dataContainer);

        string refreshButtonContainerID = string.Concat(parameterControl.ClientID, ClientIDSeparator, "refreshButtonContainer");
        HtmlGenericControl refreshButtonContainer = new HtmlGenericControl("DIV");
        refreshButtonContainer.ID = refreshButtonContainerID;
        refreshButtonContainer.Attributes.Add("class", "parameter-buttons-container");
        dataCell.Controls.Add(refreshButtonContainer);

        string switchModeButtonContainerID = string.Concat(parameterControl.ClientID, ClientIDSeparator, "switchModeButtonContainer");
        HtmlGenericControl switchModeButtonContainer = new HtmlGenericControl("DIV");
        switchModeButtonContainer.Attributes.Add("class", "parameter-buttons-container");
        switchModeButtonContainer.ID = switchModeButtonContainerID;
        dataCell.Controls.Add(switchModeButtonContainer);

        dataCell.Attributes.Add("onmouseover", string.Format("if(typeof(this.setVisibleTask) != 'undefined' && this.setVisibleTask != null){{ window.clearTimeout(this.setVisibleTask); this.setVisibleTask = null; }} if(typeof(this.setNotVisibleTask) != 'undefined' && this.setNotVisibleTask != null){{ window.clearTimeout(this.setNotVisibleTask); this.setNotVisibleTask = null; }} this.setVisibleTask = window.setTimeout(function(){{ var el = window.document.getElementById('{0}'); if(el) el.style.visibility = 'visible';}}, 500);", switchModeButtonContainer.ClientID));
        dataCell.Attributes.Add("onmouseout", string.Format("if(typeof(this.setNotVisibleTask) != 'undefined' && this.setNotVisibleTask != null){{ window.clearTimeout(this.setNotVisibleTask); this.setNotVisibleTask = null; }} if(typeof(this.setVisibleTask) != 'undefined' && this.setVisibleTask != null){{ window.clearTimeout(this.setVisibleTask); this.setVisibleTask = null; }} this.setNotVisibleTask = window.setTimeout(function(){{var view = Bitrix.ComponentParametersEditor.getInstance().getView('{0}'); if(view.getModificationMode().getCurrentID() == {1}) return; var el = window.document.getElementById('{2}'); if(el) el.style.visibility = 'hidden';}}, 75);", parameterControl.ClientID, Convert.ToInt32(BXComponentParameterModificationMode.Expression), switchModeButtonContainer.ClientID));

        BXComponentParameterViewComboExpressionEditor parameterComboExpEd = parameterControl as BXComponentParameterViewComboExpressionEditor;
        if (parameterComboExpEd != null)
        {
            string switchModeImgID = string.Concat(parameterComboExpEd.ClientID, ClientIDSeparator, "imgSwitchModificationMode"),
                //string switchModeImgID = "imgSwitchModificationMode",
                urlToModificationModeTextImg = BXThemeHelper.AddAbsoluteThemePath("images/components/exp_off.gif"),
                urlToModificationModeExprImg = BXThemeHelper.AddAbsoluteThemePath("images/components/exp_on.gif");
            HtmlImage switchModeImg = new HtmlImage();
            switchModeImg.ID = switchModeImgID;
            switchModeImg.Attributes.Add("class", "parameter-button mode");

            string switchModeImgAlt2Expr = GetMessage("IMG_TITLE_SWITCH_TO_DYN_EXP_ED"),
                switchModeImgAlt2Text = GetMessage("IMG_TITLE_SWITCH_TO_STD_ED");


            if (parameterComboExpEd.GetModificationMode() == BXComponentParameterModificationMode.Standard)
            {
                switchModeImg.Alt = switchModeImgAlt2Expr;
                switchModeImg.Attributes.Add("title", switchModeImgAlt2Expr);
                switchModeImg.Src = urlToModificationModeTextImg;
                switchModeButtonContainer.Attributes.CssStyle[HtmlTextWriterStyle.Visibility] = "hidden";
            }
            else
            {
                switchModeImg.Alt = switchModeImgAlt2Text;
                switchModeImg.Attributes.Add("title", switchModeImgAlt2Text);
                switchModeImg.Src = urlToModificationModeExprImg;
                switchModeButtonContainer.Attributes.CssStyle[HtmlTextWriterStyle.Visibility] = "visible";
            }

            switchModeImg.Attributes.Add("onclick", string.Format("var view = Bitrix.ComponentParametersEditor.getInstance().getView('{0}'); view.switchModificationMode(); if(view.getModificationMode().getCurrentID() == {1}){{ this.src = '{3}'; this.alt = '{4}'; this.title = '{4}'; }}else {{ this.src = '{2}'; this.alt = '{5}'; this.title = '{5}'; }}",
                parameterComboExpEd.ClientID,
                Convert.ToInt32(BXComponentParameterModificationMode.Standard),
                urlToModificationModeExprImg,
                urlToModificationModeTextImg,
                switchModeImgAlt2Expr,
                switchModeImgAlt2Text));

            parameterComboExpEd.ShowModificationModeSwitchButton = false;
            parameterComboExpEd.DisplayExpressionTags = false;

            //dataCell.Controls.Add(switchModeImg);
            switchModeButtonContainer.Controls.Add(switchModeImg);
        }

        if (!parameter.RefreshOnDirty)
            dataCell.Controls.Remove(refreshButtonContainer);
        else
        {
            BXComponentParameterView parameterView = (BXComponentParameterView)parameterControl;
            HtmlImage refreshImg = new HtmlImage();
            string refreshImgID = string.Concat(parameterView.ClientID, ClientIDSeparator, "imgRefreshComponentParameters");
            refreshImg.ID = refreshImgID;
            refreshImg.Attributes.Add("class", "parameter-button refresh");

            refreshImg.Src = BXThemeHelper.AddAbsoluteThemePath("images/refresh_blue.gif");

            string refreshImgAlt = GetMessage("IMG_TITLE_REFRESH");

            refreshImg.Alt = refreshImgAlt;
            refreshImg.Attributes.Add("title", refreshImgAlt);

            refreshImg.Attributes.Add("onclick", string.Format("this.src='{0}'; window.setTimeout(function(){{ {1}; }}, 300);",
                BXThemeHelper.AddAbsoluteThemePath("images/refresh_blue_anim.gif"),
                parameterView.GetPostBackEventReference(BXComponentParameterViewPostBackEventType.RefreshComponentParameters)));
            //dataCell.Controls.Add(refreshImg);
            refreshButtonContainer.Controls.Add(refreshImg);

            parameterView.SetPostBackEventTrigger(
                BXComponentParameterViewPostBackEventType.RefreshComponentParameters,
                string.Format("window.document.getElementById('{0}').onclick();", refreshImg.ClientID));
        }

        ParamClientSideAction action = parameter.ClientSideAction;
        if (action != null)
        {
            action.AdjustControls(new Control[] { row }, this);
            action.RegisterClientScripts(this);
            ParamClientSideActionGroupView groupViewAction = action as ParamClientSideActionGroupView;
            if (groupViewAction != null)
            {
                ScriptManager.RegisterStartupScript(this,
                    GetType(),
                    "ParamClientSideActionGroupViewVisibilityBinding",
                    string.Format("if(typeof(Bitrix) != 'undefined' && typeof(Bitrix.ParamClientSideActionGroupView) != 'undefined'){{ Bitrix.ParamClientSideActionGroupView.ensureEntryCreated('{0}'); }}", groupViewAction.ViewID),
                    true);

                if (groupViewAction is ParamClientSideActionGroupViewMember)
                    row.Attributes.CssStyle[HtmlTextWriterStyle.Display] = "none";
            }

        }
        using (StringWriter sw = new StringWriter())
        {
            using (HtmlTextWriter htmlw = new HtmlTextWriter(sw))
                row.RenderControl(htmlw);
            return sw.ToString();
        }
    }

    /// <summary>
    /// Проверить авторизацию пользователя для работы с диалогом
    /// </summary>
    /// <returns></returns>
    protected override bool CheckUserAuthorization()
    {
        return BXUser.IsCanOperate(BXRoleOperation.Operations.FileManage) && BXSecureIO.CheckView(this.targetFileAppRelPath);
    }

    protected void Behaviour_Save(object sender, EventArgs e)
    {
        BXUser.DemandOperations(BXRoleOperation.Operations.FileManage);
        BXSecureIO.DemandWrite(this.targetFileAppRelPath);
        try
        {
            BXUndoPageModificationOperation undoOperation = new BXUndoPageModificationOperation();
            undoOperation.FileVirtualPath = this.targetFileAppRelPath;
            undoOperation.FileEncodingName = Encoding.UTF8.WebName;

			//TODO Adding parameter for mvc apprelpath
            string url = this.targetFileAppRelPath; //"";
            //if (!BXRoutesHelper.IsArea(this.targetFileAppRelPath))
            //{
            //    string fileAppRelPath = BXRoutes.Instance.GetComponentPathByUrl(BXSite.Current.Id, this.targetFileAppRelPath);
            //    if (!string.IsNullOrEmpty(fileAppRelPath))
            //    {
            //        url = fileAppRelPath;
            //    }
            //}
            //else
            //{
            //    url = this.targetFileAppRelPath;
            //}
            
			undoOperation.FileContent = BXSecureIO.FileReadAllText(url, Encoding.UTF8);

            BXUndoInfo undo = new BXUndoInfo();
            undo.Operation = undoOperation;
            undo.Save();

            this.componentModificator.SaveComponent(url, this.type, this.id, this.componentProxy);

            BXDialogGoodbyeWindow goodbye = new BXDialogGoodbyeWindow(string.Format(
                GetMessageRaw("OPERATION_HAS_BEEN_COMPLETED_SUCCESSFULLY_UNDO"),
                string.Concat(undo.GetClientScript(), " return false;"),
                "#"), -1, BXDialogGoodbyeWindow.LayoutType.Success);
            BXDialogGoodbyeWindow.SetCurrent(goodbye);

            Refresh(string.Empty, BXDialogGoodbyeWindow.LayoutType.Success);
        }
        catch (System.Threading.ThreadAbortException)
        {
            //...игнорируем, вызвано Close();
        }
        catch (Exception exc)
        {
            Close(exc.Message, BXDialogGoodbyeWindow.LayoutType.Error, -1);
        }
    }

    public enum ErrorType
    {
        None = 0,
        TypeNameNotFound,
        TypeNotFound,
        PathNotFound,
        IdNotFound,
        FailedLoad
    }
}

