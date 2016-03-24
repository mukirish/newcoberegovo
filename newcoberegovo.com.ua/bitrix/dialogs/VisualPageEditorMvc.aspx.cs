using System;
using System.IO;
using System.Text;
using System.Web;
using System.Web.Hosting;
using System.Web.UI;

using Bitrix;
using Bitrix.Configuration;
using Bitrix.DataTypes;
using Bitrix.IO;
using Bitrix.Mvc;
using Bitrix.Security;
using Bitrix.Services;
using Bitrix.Services.Undo;
using Bitrix.UI;

public enum VisualPageEditorMode
{
    Standard = 1,
    PlainText
}

public partial class bitrix_dialogs_VisualPageEditorMvc : Bitrix.UI.BXDialogPage
{	
    /// <summary>
    /// Путь к редактируемой странице
    /// </summary>
    private string mPath = null;

    /// <summary>
    /// Путь к директории (часть Path)
    /// </summary>
    private string mDirectoryPath = null;

    /// <summary>
    /// Имя файла (часть Path)
    /// </summary>
    private string mFileName = null;

    /// <summary>
    /// Принудительное перенаправление клиента на редактируемую страницую.
    /// Клиент перенаправляется на редактируемую страницую даже после закрытия диалога, без сохранения.
    /// </summary>
    private bool mForcedRedirection = false;

    private VisualPageEditorMode mMode = VisualPageEditorMode.Standard;
	public VisualPageEditorMode EditorModeMode
	{
		get { return mMode; }
	}

	/// <summary>
	/// Кодировка файла содержания
	/// </summary>
	private Encoding mContentEncoding = null;

    /// <summary>
    /// Клиентская строка запроса (с которой будет осуществлено перенаправление)
    /// </summary>
    private string mQueryString = string.Empty;


    private bool? _aboutCreationNewFile = null;
    private bool AboutCreationNewFile
    {
        get 
        {
            if (_aboutCreationNewFile.HasValue)
                return _aboutCreationNewFile.Value;

            string noValueParamStr = Request.QueryString[null];
            string[] noValueParams = !string.IsNullOrEmpty(noValueParamStr) ? noValueParamStr.Split(',') : null;
            _aboutCreationNewFile = noValueParams != null && noValueParams.Length > 0 ? Array.FindIndex<string>(noValueParams, delegate(string obj) { return string.Equals(obj, "new", StringComparison.InvariantCultureIgnoreCase); }) >= 0 : false;
            return _aboutCreationNewFile.Value;
        }
    }

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);

        try
        {
            Behaviour.UseStandardStyles = true;
            Behaviour.ContentWrapperCssClass = "bx-content-editor";          
            //инициализация пути и проверки
            //if (!BXUser.IsCanOperate(BXRoleOperation.Operations.FileManage))
            //    Close(GetMessage("INSUFFICIENT_RIGHTS"), BXDialogGoodbyeWindow.LayoutType.Error, -1);

		
            mPath = Request.QueryString["path"];
            if (string.IsNullOrEmpty(this.mPath))
            {
            	Close(GetMessage("PATH_IS_NOT_SPECIFIED"), BXDialogGoodbyeWindow.LayoutType.Error, -1);
            }
            
			mMode = VisualPageEditorMode.PlainText;
			

        	mQueryString = Request.QueryString["query"];

            bool isNew = AboutCreationNewFile;

            if (!BXPath.BreakPath(mPath, ref mDirectoryPath, ref mFileName))
                Close(string.Format("{0}: {1}!", GetMessage("COULD_NOT_PARSE_DIR_AND_FILE_NAME_IN_PATH"), mPath));

            if (string.IsNullOrEmpty(mDirectoryPath))
                Close(string.Format("{0}: {1}!", GetMessage("DIRECTORY_IS_NOT_FOUND_IN_PATH"), mPath));

			if (!isNew && !BXSecureIO.FileExists(mPath))
                Close(string.Format("{0}: {1}.", GetMessage("FILE_IS_NOT_EXISTS"), mPath), BXDialogGoodbyeWindow.LayoutType.Error, -1);

			if (!IsPathFileExtensionAllowed())
				Close(string.Format(GetMessage("FILE_NAME_HAS_NOT_ALLOWED_EXTENSION"), VirtualPathUtility.GetFileName(mPath)), BXDialogGoodbyeWindow.LayoutType.Error, -1);

			string encodingWebName = Request.QueryString["encoding"];
			if (!string.IsNullOrEmpty(encodingWebName))
			{
				try
				{
					mContentEncoding = Encoding.GetEncoding(encodingWebName);
				}
				catch (ArgumentException /*exc*/)
				{ }
			}

        	string mode = null;

			mode = "PlainText";			

        	mMode = !string.IsNullOrEmpty(mode) && string.Compare(mode, "PlainText", StringComparison.OrdinalIgnoreCase) == 0 ?
                VisualPageEditorMode.PlainText : VisualPageEditorMode.Standard;

			if (string.Equals(PathFileExtension, ".txt", StringComparison.OrdinalIgnoreCase))
                mMode = VisualPageEditorMode.PlainText;
			else
			{
				string componentTaskbar = Request.QueryString["component_taskbar"];
				//Ищем флаг отключения панели компонентов
				bool enableComponentTaskbar = string.IsNullOrEmpty(componentTaskbar) 
					|| (!string.Equals(componentTaskbar, "FALSE", StringComparison.OrdinalIgnoreCase) 
					&& !string.Equals(componentTaskbar, "N", StringComparison.OrdinalIgnoreCase) 
					&& !string.Equals(componentTaskbar, "0", StringComparison.Ordinal));

				//для html панель не включается по определению
				if (string.Equals(PathFileExtension, ".htm", StringComparison.OrdinalIgnoreCase) || string.Equals(PathFileExtension, ".html", StringComparison.OrdinalIgnoreCase))
					enableComponentTaskbar = false;

				if(!enableComponentTaskbar)
					RemoveAspxComponentTaskBar();
			}

            //установки редактора 
            if (mMode == VisualPageEditorMode.Standard)
            {
                ViewContainer.ActiveViewIndex = 0;
                if (BXUser.IsCanOperate(BXRoleOperation.Operations.FileManage))
                {
                    if (!isNew)
                    {
						//VisualEditor.Path = mPath;
                    	if (string.Equals(PathFileExtension, ".htm") || string.Equals(PathFileExtension, ".html"))
                            RemoveAspxComponentTaskBar();
                    }
                    else
                    {
                        //только ascx, htm, html
                        if (string.Equals(PathFileExtension, ".ascx"))
                        {
							if(BXApplicationHelper.ApplicationType == BXApplicationTechnologyType.WebForms)
							{
								//VisualEditor.Content = Bitrix.Services.Text.BXDefaultFiles.BuildAscx(null);
							}
                        }
                        else if (string.Equals(PathFileExtension, ".htm") || string.Equals(PathFileExtension, ".html"))
                            RemoveAspxComponentTaskBar();
                        else
                            Close(string.Format("{0}: {1}!", GetMessage("EXTENSION_IS_NOT_SUPPORTED_FOR_NEW_FILES"), PathFileExtension), BXDialogGoodbyeWindow.LayoutType.Error, -1);

                    } 
                }
                /*if (mContentEncoding != null)
                    VisualEditor.ContentEncoding = mContentEncoding;*/
                //Behaviour.SetAllButtonsDisabled(true);
            }
            else
            {
                ViewContainer.ActiveViewIndex = 0;
                if (BXUser.IsCanOperate(BXRoleOperation.Operations.FileManage) && !isNew)
                {
                    string content = BXSecureIO.FileReadAllText(mPath, mContentEncoding != null ? mContentEncoding : BXConfigurationUtility.DefaultEncoding);
                    TextEditor.Text = content;
                }
            }

            //установка диалога
            Behaviour.ButonSetLayout = BXPageAsDialogButtonSetLayout.SaveCancel;
            Behaviour.Settings.MinWidth = 775;
            Behaviour.Settings.MinHeight = 585;
            Behaviour.Settings.Width = 775;
            Behaviour.Settings.Height = 585;
            Behaviour.Settings.Resizeable = false;  

            //установка заголовка
            Title = HttpUtility.HtmlEncode(string.Format("{0}: {1}", GetMessage("TITLE"), mPath));

            string forcedRedirection = Request.QueryString["forcedRedirection"];
            mForcedRedirection = forcedRedirection != null;
            //if (mForcedRedirection && mMode != VisualPageEditorMode.Standard)
             //   Close(GetMessage("FORCE_REDIRECTION_IS_SUPPORTED_ONLY_FOR_STANDARD_MODE"));

			Behaviour.EnableFormIdReplace = false;			
        }
        catch (System.Threading.ThreadAbortException /*exception*/)
        {
            //...игнорируем, вызвано Close();
        }
        catch (Exception exception)
        {
            Close(exception.Message, BXDialogGoodbyeWindow.LayoutType.Error, -1);
        }
    }

	private void RemoveAspxComponentTaskBar()
	{
		//for(int i = 0; i < VisualEditor.Taskbars.Count; i++)
		//    if(string.Equals(VisualEditor.Taskbars[i].Name, "ASPXComponentsTaskbar", StringComparison.OrdinalIgnoreCase))
		//    {
		//        VisualEditor.Taskbars.RemoveAt(i); 
		//        break;
		//    }
	}

    private string _pathFileExtension = null;
    private string PathFileExtension
    {
        get
        {
        	if (this._pathFileExtension != null)
        	{
        		return this._pathFileExtension;
        	}

        	if (string.IsNullOrEmpty(this.mPath) || !VirtualPathUtility.IsAppRelative(this.mPath))
        	{
        		this._pathFileExtension = string.Empty;
        	}
        	else
        	{
        		this._pathFileExtension = VirtualPathUtility.GetExtension(this.mPath);
        	}

        	return this._pathFileExtension;
        }
    }

	private bool IsPathFileExtensionAllowed() 
	{        
		return string.Equals(this.PathFileExtension, ".cshtml");			
	}
	//private bool IsPathFileExtensionPage()
	//{
	//    string ext = PathFileExtension;
	//    return string.Equals(ext, ".cshtml");
	//}
	//protected void VisualEditor_IncludeWebEditorScript(object sender, BXWebEditor.IncludeWebEditorScriptArgs e)
	//{
	//    e.Writer.WriteLine("<script>");
	//    e.Writer.WriteLine("FE_MESS = {}");
	//    e.Writer.WriteLine("FE_MESS.FILEMAN_HTMLED_WARNING = \"" + GetMessageJS("CloseWarning") + "\";");
	//    e.Writer.WriteLine("FE_MESS.FILEMAN_HTMLED_MANAGE_TB = \"" + GetMessageJS("ManageToolbar") + "\";");
	//    //e.Writer.WriteLine("var _bEdit = {0}", isNew ? "false" : "true");
	//    e.Writer.WriteLine("var _bEdit = true");
	//    e.Writer.WriteLine("window._curDir = \"{0}\";", mDirectoryPath);
	//    e.Writer.WriteLine("window.lightMode = true;");

	//    //контекст
	//    e.Writer.WriteLine("window.BX_DOTNET_WEB_EDITOR_CONTEXT = {");
	//    e.Writer.WriteLine("IsDialogMode: \"true\",");
	//    e.Writer.WriteLine("ButtonIdSave: \"{0}\",", BXPageAsDialogBehaviour.GetButtonId(BXPageAsDialogButtonEntry.Save));
	//    e.Writer.WriteLine("ButtonIdApply: \"null\",");
	//    e.Writer.WriteLine("ButtonIdCancel: \"{0}\"", BXPageAsDialogBehaviour.GetButtonId(BXPageAsDialogButtonEntry.Cancel));
	//    e.Writer.WriteLine("};");
	//    e.Writer.WriteEndTag("script");

	//    string fileUrl = "~/bitrix/controls/Main/editor/js/toolbar_aspx.js";
	//    e.Writer.WriteLine(string.Format("<script type=\"text/javascript\" src=\"{0}?v={1}\"></script>", VirtualPathUtility.ToAbsolute(fileUrl), Bitrix.IO.BXFile.GetFileTimestamp(BXPath.MapPath(fileUrl)).ToString()));

	//    fileUrl = "~/bitrix/controls/Main/editor/js/VisualPageEditor_editor.js";
	//    e.Writer.WriteLine(string.Format("<script type=\"text/javascript\" src=\"{0}?v={1}\"></script>", VirtualPathUtility.ToAbsolute(fileUrl), Bitrix.IO.BXFile.GetFileTimestamp(BXPath.MapPath(fileUrl)).ToString()));

	//}

    protected void Behaviour_Save(object sender, EventArgs e)
    {
        try
        {
            BXUser.DemandOperations(BXRoleOperation.Operations.FileManage);
        	if (string.IsNullOrEmpty(this.mPath))
        	{
        		throw new InvalidOperationException("Path is not defined!");
        	}

        	bool isNew = this.AboutCreationNewFile;

        	if (!isNew && !BXSecureIO.FileExists(this.mPath))
        	{
        		throw new InvalidOperationException(string.Format("Could not find file by path specified: '{0}'!", this.mPath));
        	}

        	if (!this.IsPathFileExtensionAllowed())
        	{
        		this.Close(string.Format(this.GetMessage("FILE_NAME_HAS_NOT_ALLOWED_EXTENSION"), VirtualPathUtility.GetFileName(this.mPath)), BXDialogGoodbyeWindow.LayoutType.Error, -1);
        	}

        	if (!isNew)
            {
                var contentEncoding = this.mContentEncoding ?? BXConfigurationUtility.DefaultEncoding;

				if(Request.QueryString["noundo"] == null)
				{
					BXUndoPageModificationOperation undoOperation = new BXUndoPageModificationOperation();
					undoOperation.FileVirtualPath = mPath;
					undoOperation.FileEncodingName = contentEncoding.WebName;
					undoOperation.FileContent = BXSecureIO.FileReadAllText(mPath, contentEncoding);

					BXUndoInfo undo = new BXUndoInfo();
					undo.Operation = undoOperation;
					undo.Save();

					BXDialogGoodbyeWindow goodbye = new BXDialogGoodbyeWindow(string.Format(
						GetMessageRaw("OPERATION_HAS_BEEN_COMPLETED_SUCCESSFULLY_UNDO"), 
						string.Concat(undo.GetClientScript(), " return false;"), 
						"#"), -1, BXDialogGoodbyeWindow.LayoutType.Success);
					BXDialogGoodbyeWindow.SetCurrent(goodbye);
				}

                int i = 0;
            	while (BXSecureIO.FileExists(this.mPath + "." + i))
            	{
            		i++;
            	}
            	string tempFile = this.mPath + "." + i;

            	// string content = mMode == VisualPageEditorMode.Standard ? VisualEditor.Content : TextEditor.Text;
				string content = TextEditor.Text;

                BXSecureIO.FileMove(this.mPath, tempFile);

                /*if (IsPathFileExtensionPage())
					Bitrix.Mvc.IO.BXSecureIO.SaveCshtml(mPath, content, this.siteId);
                else */
                    BXSecureIO.FileWriteAllText(this.mPath, content, contentEncoding);

                BXSecureIO.FileDelete(tempFile);
            }
            else
            {
            	if (BXSecureIO.FileExists(this.mPath))
            	{
            		this.Close(string.Format(this.GetMessageRaw("FILE_ALREADY_EXISTS"), this.mPath));
            	}

            	//string content = mMode == VisualPageEditorMode.Standard ? VisualEditor.Content : TextEditor.Text;
				string content = TextEditor.Text;
                Encoding contentEncoding = mContentEncoding != null ? mContentEncoding : BXConfigurationUtility.DefaultEncoding;

				DirectoryInfo di = new DirectoryInfo(HostingEnvironment.MapPath(mDirectoryPath));
				if(!di.Exists)
					di.Create();

				FileInfo fi = new FileInfo(HostingEnvironment.MapPath(mPath));
				using(FileStream fs = fi.Open(FileMode.CreateNew, FileAccess.Write, FileShare.None))
					using(StreamWriter sw = new StreamWriter(fs, contentEncoding))
						sw.Write(content);
            }

            string returnUrl = this.ReturnUrl;
        	if (string.IsNullOrEmpty(returnUrl))
        	{
				var url = BXRoutesHelper.MakeAbsoluteUrlPathForPagePath(this.mPath);
				returnUrl = !string.IsNullOrEmpty(this.mQueryString) ? string.Concat(url, "?", this.mQueryString) : url;					
        	}
        	Redirect(returnUrl, string.Empty, BXDialogGoodbyeWindow.LayoutType.Success);
        }
        catch (System.Threading.ThreadAbortException)
        {
            //...игнорируем, вызвано Reload();
        }
        catch (Exception ex)
        {
            ShowError(ex.Message);
        }
    }

    protected string ReturnUrl
    {
        get 
        {
			var url = Request.QueryString.Get("returnUrl") ?? BXRoutesHelper.MakeVirtualUrlPathForPagePath(this.mPath);
        	if (!url.StartsWith("~/"))
        	{
        		return url;
        	}

        	int whatInd = url.IndexOf('?');
        	if (whatInd < 0)
        	{
        		return VirtualPathUtility.ToAbsolute(url);
        	}

        	return string.Concat(VirtualPathUtility.ToAbsolute(url.Substring(0, whatInd)), url.Substring(whatInd));
        }
    }

    protected string ClientPath
    {
        get { return VirtualPathUtility.ToAbsolute(mPath); }
    }

    protected string ClientUrl
    {
        get 
        {
			return !string.IsNullOrEmpty(mQueryString) ? string.Concat(BXSite.GetUrlForPath(mPath, null), "?", mQueryString) : BXSite.GetUrlForPath(mPath, null);
        }
    }

    protected override void OnPreRender(EventArgs e)
    {
        ClientScriptManager cs = ClientScript;
        if (cs == null)
            throw new InvalidOperationException("Could not find ClientScriptManager instance!");

        if (mMode == VisualPageEditorMode.Standard)
        {
            

            //cs.RegisterStartupScript(GetType(), "setCharge",
            //    string.Format("if(typeof(window[\"BXVisualPageEditorDialogManager\"]) == \"undefined\") throw \"Could not find BXVisualPageEditorDialogManager!\";\r\nif(!document.getElementById(\"{0}\")) throw \"Could not find element with ID = '{0}'!\";\r\nBXVisualPageEditorDialogManager.getInstance().set_charge(document.getElementById(\"{0}\").pMainObj);", VisualEditor.ClientID),
            //    true);
			//cs.RegisterStartupScript(GetType(), "startMgr",
			//    string.Format("if(typeof(window[\"BXVisualPageEditorDialogManager\"]) == \"undefined\") throw \"Could not find BXVisualPageEditorDialogManager!\";\r\nBXVisualPageEditorDialogManager.getInstance().start(\"{0}\");", VisualEditor.ClientID),
			//    true);
        }
        else if (mMode == VisualPageEditorMode.PlainText)
        {
            //TextEditor.Attributes.Add("style", "border-width:0px; height:100%; width:100%; padding:0px; margin:0px; overflow-y:auto;");
            //"display:block; float:left;" - для hasLayout = true, чтобы эл-т не вылазил за свои границы;
            TextEditor.Attributes.Add("style", "border:solid 1px #CCCCCC; width:100%; padding:0px; margin:0px; height:99%; overflow-y:auto; wrap:soft; display:block;");
        }

		if (mForcedRedirection)
            {
                string returnUrl = ReturnUrl;
                if (string.IsNullOrEmpty(returnUrl))
                    returnUrl = ClientUrl;

                cs.RegisterStartupScript(GetType(), "forcedRedirection",
                    string.Format("if(typeof(window[\"BXVisualPageEditorDialogManager\"]) == \"undefined\") throw \"Could not find BXVisualPageEditorDialogManager!\";\r\nBXVisualPageEditorDialogManager.getInstance().set_redirectAfterExit(true);\r\nBXVisualPageEditorDialogManager.getInstance().set_redirectionUrl(\"{0}\");",
                    returnUrl),
                    true);
            }

        base.OnPreRender(e);
    }

    /// <summary>
    /// CheckUserAuthorization
    /// Проверить авторизацию пользователя для работы с диалогом
    /// </summary>
    /// <returns></returns>
    protected override bool CheckUserAuthorization()
    {
        return BXUser.IsCanOperate(BXRoleOperation.Operations.FileManage) && BXSecureIO.CheckView(mPath);
    }

    protected override string GetParametersBagName()
    {
        return "BitrixDialogVisualPageEditorParamsBag";
    }

    protected override void ExternalizeParameters(BXParamsBag<string> paramsBag)
    {
        if (paramsBag == null)
            throw new ArgumentNullException("paramsBag");

        //string content = mMode == VisualPageEditorMode.Standard ? VisualEditor.Content : TextEditor.Text;
		string content = TextEditor.Text;
        paramsBag.Add("content", content);
    }

    protected override void InternalizeParameters(BXParamsBag<string> paramsBag)
    {
        if (paramsBag == null)
            throw new ArgumentNullException("paramsBag");

        if (paramsBag.ContainsKey("content"))
        {
            string content = paramsBag["content"];
            if (!string.IsNullOrEmpty(content))
            {
                if (mMode == VisualPageEditorMode.Standard)
                {
                    //VisualEditor.AutoLoadContent = false;
                    //VisualEditor.Content = content;
                }
                else
                    TextEditor.Text = content;
            }
        }
    }
}
