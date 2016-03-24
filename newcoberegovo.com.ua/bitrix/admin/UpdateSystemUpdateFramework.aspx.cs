using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Text;
using System.Web;
using System.Web.Hosting;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using Bitrix.UI;
using System.Xml;
using System.Collections.Generic;

public partial class bitrix_admin_UpdateSystemUpdateFramework : BXAdminPage
{
	private static readonly string[] Framework4Assemblies = new string[]
	{
		"System, Version=4.0.0.0, Culture=neutral, PublicKeyToken=B77A5C561934E089",
		"System.Configuration, Version=4.0.0.0, Culture=neutral, PublicKeyToken=B03F5F7F11D50A3A",
		"System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=B77A5C561934E089",
		"System.Design, Version=4.0.0.0, Culture=neutral, PublicKeyToken=B03F5F7F11D50A3A",
		"System.Drawing, Version=4.0.0.0, Culture=neutral, PublicKeyToken=B03F5F7F11D50A3A",
		"System.Web, Version=4.0.0.0, Culture=neutral, PublicKeyToken=B03F5F7F11D50A3A",
		"System.Web.Services, Version=4.0.0.0, Culture=neutral, PublicKeyToken=B03F5F7F11D50A3A",
		"System.Web.RegularExpressions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=B03F5F7F11D50A3A",
		"System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=B77A5C561934E089",

		"System.Core, Version=4.0.0.0, Culture=neutral, PublicKeyToken=B77A5C561934E089",
		"System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35",
		"System.Xml.Linq, Version=4.0.0.0, Culture=neutral, PublicKeyToken=B77A5C561934E089",
		"System.Data.DataSetExtensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=B77A5C561934E089"
	};
	private static readonly string[] CollectionTags = new string[] { "add", "remove" };
		
	public override void ProcessRequest(HttpContext context)
	{
		if (context.Request.QueryString["convert4"] != null)
		{
			System.Net.Mime.ContentDisposition cd = new System.Net.Mime.ContentDisposition();
			cd.FileName = "web.config";

			context.Response.ContentType = "application/x-octet-stream";
			context.Response.AddHeader("Content-Disposition", cd.ToString());
			context.Response.ContentEncoding = Encoding.UTF8;
			
			XmlWriterSettings ws = new XmlWriterSettings();
			ws.Indent = true;
			ws.IndentChars = "\t";
			ws.Encoding = Encoding.UTF8;			

			using (XmlWriter xml = XmlWriter.Create(context.Response.OutputStream, ws))
			{
				MakeConfig(xml);
			}

			context.Response.End();
			return;
		}
		
		base.ProcessRequest(context);
	}
	
	protected void ContextMenu_CommandClick(object sender, CommandEventArgs e)
	{
		if (e.CommandName == "ViewUpdates")
			Response.Redirect("UpdateSystem.aspx");
	}
	protected void Page_LoadComplete(object sender, EventArgs e)
	{
		MasterTitle = GetMessageRaw("MasterTitle");
	}	
	
	private static void MakeConfig(XmlWriter xml)
	{
		XmlDocument doc = new XmlDocument();
		doc.Load(HostingEnvironment.MapPath("~/web.config"));

		XmlElement root = doc.DocumentElement;
		
		PatchConfigSections(root);
		PatchAppSettings(root);

		XmlElement systemWeb = Node(root, "system.web");
		Set(Node(systemWeb, "httpRuntime"), "requestValidationMode", "2.0");
		
		XmlElement pages = Node(systemWeb, "pages");
		Set(pages, "controlRenderingCompatibilityVersion", "3.5");
		Set(pages, "clientIDMode", "AutoID");

		PatchPageControls(Node(pages, "controls"));
		PatchPageNamespaces(Node(pages, "namespaces"));

		XmlElement compilation = Node(systemWeb, "compilation");
		Set(compilation, "targetFramework", "4.0");

		PatchAssemblies(Node(compilation, "assemblies"));
		
		PatchModules((XmlElement)systemWeb.SelectSingleNode("httpModules"));
		PatchHttpHandlers((XmlElement)systemWeb.SelectSingleNode("httpHandlers"));

		PatchModules((XmlElement)root.SelectSingleNode("system.webServer/modules"));		
		PatchHandlers((XmlElement)root.SelectSingleNode("system.webServer/handlers"));

		DeleteNode(root, "system.codedom", null);
		DeleteNode(root, "runtime", null);		

		doc.Save(xml);
	}

	private static void PatchModules(XmlElement modules)
	{
		if (modules == null)
		{
			return;
		}

		foreach (string tag in CollectionTags)
		{
			DeleteNode(modules, tag, "[@name='ScriptModule']");
		}		
	}
	private static void PatchHandlers(XmlElement handlers)
	{
		if (handlers == null)
		{
			return;
		}

		foreach (string tag in CollectionTags)
		{
			DeleteNode(handlers, tag, "[@name='WebServiceHandlerFactory-Integrated']");
			DeleteNode(handlers, tag, "[@name='ScriptHandlerFactory']");
			DeleteNode(handlers, tag, "[@name='ScriptHandlerFactoryAppServices']");
			DeleteNode(handlers, tag, "[@name='ScriptResource']");			
		}	
	}
	private static void PatchHttpHandlers(XmlElement httpHandlers)
	{		
		if (httpHandlers == null)
		{
			return;
		}

		foreach (string tag in CollectionTags)
		{
			DeleteNode(httpHandlers, tag, "[@path='*.asmx']");
			DeleteNode(httpHandlers, tag, "[@path='*_AppService.axd']");
			DeleteNode(httpHandlers, tag, "[@path='ScriptResource.axd']");					
		}	
	}	
	private static void PatchAssemblies(XmlElement assemblies)
	{
		foreach (string asm in Framework4Assemblies)
		{
			string prefix = asm.Remove(asm.IndexOf(','));
			XmlElement node = Node(
				assemblies, 
				"add", 
				string.Format("[starts-with(lower-case(string(@assembly)), lower-case('{0},'))]", prefix)
			);
			Set(node, "assembly", asm);
		}
	}
	private static void PatchPageNamespaces(XmlElement namespaces)
	{
		XmlNode clear = namespaces.SelectSingleNode("clear");
		while (clear != null)
		{
			List<XmlNode> delete = new List<XmlNode>();
			foreach (XmlNode node in namespaces.ChildNodes)
			{
				delete.Add(node);
				if (node == clear)
				{
					break;
				}
			}
			foreach (XmlNode node in delete)
			{
				namespaces.RemoveChild(node);
			}

			clear = namespaces.SelectSingleNode("clear");
		}

		Node(namespaces, 0, "clear");
		Node(namespaces, "add", "namespace", "System");
		Node(namespaces, "add", "namespace", "System.Collections");
		Node(namespaces, "add", "namespace", "System.Collections.Generic");
		Node(namespaces, "add", "namespace", "System.Collections.Specialized");
		Node(namespaces, "add", "namespace", "System.Configuration");
		Node(namespaces, "add", "namespace", "System.Text");
		Node(namespaces, "add", "namespace", "System.Text.RegularExpressions");
		Node(namespaces, "add", "namespace", "System.Linq");
		Node(namespaces, "add", "namespace", "System.Xml.Linq");
		Node(namespaces, "add", "namespace", "System.Web");
		Node(namespaces, "add", "namespace", "System.Web.Caching");
		Node(namespaces, "add", "namespace", "System.Web.SessionState");
		Node(namespaces, "add", "namespace", "System.Web.Security");
		Node(namespaces, "add", "namespace", "System.Web.Profile");
		Node(namespaces, "add", "namespace", "System.Web.UI");
		Node(namespaces, "add", "namespace", "System.Web.UI.WebControls");
		Node(namespaces, "add", "namespace", "System.Web.UI.WebControls.WebParts");
		Node(namespaces, "add", "namespace", "System.Web.UI.HtmlControls");
	}
	private static void PatchPageControls(XmlElement controls)
	{
		DeleteNode(controls, "add", "[@tagPrefix='asp' and @namespace='System.Web.UI' and starts-with(@assembly, 'System.Web,')]");
		DeleteNode(controls, "add", "[@tagPrefix='asp' and @namespace='System.Web.UI' and starts-with(@assembly, 'System.Web.Extensions,')]");
		DeleteNode(controls, "add", "[@tagPrefix='asp' and @namespace='System.Web.UI.WebControls' and starts-with(@assembly, 'System.Web,')]");
		DeleteNode(controls, "add", "[@tagPrefix='asp' and @namespace='System.Web.UI.HtmlControls' and starts-with(@assembly, 'System.Web,')]");
				
		XmlElement bitrix = Node(controls, "add", "[@tagPrefix='bx' and @namespace='Bitrix.UI' and @assembly='Main']");
		Set(bitrix, "tagPrefix", "bx");
		Set(bitrix, "namespace", "Bitrix.UI");
		Set(bitrix, "assembly", "Main");
	}
	private static void PatchConfigSections(XmlElement root)
	{
		XmlElement configSections = FindNode(root, "configSections");		
		if (configSections == null)
		{
			return;
		}

		XmlNode oldSections = FindNode(configSections,  "sectionGroup", "[@name='system.web.extensions']");
		if (oldSections != null)
		{
			configSections.RemoveChild(oldSections);
		}
	}
	private static void PatchAppSettings(XmlElement root)
	{
		XmlElement appSettings = Node(root, 2, "appSettings");
		Set(
			Node(appSettings, "add", "key", "enableSimpleMembership"),
			"value",
			"false"
		);

		Set(
			Node(appSettings, "add", "key", "autoFormsAuthentication"),
			"value",
			"false"
		);
	}

	private static XmlElement Node(XmlElement node, string name)
	{
		return Node(node, name, null);
	}
	private static XmlElement Node(XmlElement node, string name, string suffix)
	{
		return (XmlElement)(node.SelectSingleNode(name + suffix, new XContext()) ?? node.AppendChild(node.OwnerDocument.CreateElement(name)));
	}
	private static void DeleteNode(XmlElement node, string name, string suffix)
	{
		XmlNode child = node.SelectSingleNode(name + suffix, new XContext());
		if (child != null)
		{
			node.RemoveChild(child);
		}
	}
	private static XmlElement FindNode(XmlElement node, string name)
	{
		return (XmlElement)node.SelectSingleNode(name);
	}
	private static XmlElement FindNode(XmlElement node, string name, string suffix)
	{
		return (XmlElement)node.SelectSingleNode(name + suffix, new XContext());
	}
	private static XmlElement Node(XmlElement node, string name, string attr, string value)
	{
		XmlElement n = (XmlElement)node.SelectSingleNode(name + "[@" + attr + "='" + value + "']");
		if (n == null)
		{
			n = (XmlElement)node.AppendChild(node.OwnerDocument.CreateElement(name));
			n.Attributes.Append(node.OwnerDocument.CreateAttribute(attr)).Value = value;
		}
		return n;
	}
	private static XmlElement Node(XmlElement node, int index, string name)
	{
		return Node(node, index, name, null);
	}
	private static XmlElement Node(XmlElement node, int index, string name, string suffix)
	{
		XmlElement n = (XmlElement)node.SelectSingleNode(name + suffix,  new XContext());
		if (n != null)
			node.RemoveChild(n);
		else
			n = (XmlElement)node.AppendChild(node.OwnerDocument.CreateElement(name));

		if (index >= node.ChildNodes.Count || node.ChildNodes.Count == 0)
			node.AppendChild(n);
		else
			node.InsertBefore(n, node.ChildNodes[index]);

		return n;
	}
	private static void Set(XmlElement node, string name, string value)
	{
		(node.Attributes[name] ?? node.Attributes.Append(node.OwnerDocument.CreateAttribute(name))).Value = value;
	}

	private class XContext : System.Xml.Xsl.XsltContext
	{
		public override System.Xml.Xsl.IXsltContextFunction ResolveFunction(string prefix, string name, System.Xml.XPath.XPathResultType[] ArgTypes)
		{
			if (name == "lower-case")
				return new LowerCaseFunction();
			else if (name == "ends-with")
				return new EndsWithFunction();
			return null;
		}

		public override int CompareDocument(string baseUri, string nextbaseUri)
		{
			return 0;
		}

		public override bool PreserveWhitespace(System.Xml.XPath.XPathNavigator node)
		{
			return true;
		}

		public override System.Xml.Xsl.IXsltContextVariable ResolveVariable(string prefix, string name)
		{
			return null;
		}

		public override bool Whitespace
		{
			get { return true; }
		}
	}
	private class LowerCaseFunction : System.Xml.Xsl.IXsltContextFunction
	{
		#region IXsltContextFunction Members

		public System.Xml.XPath.XPathResultType[] ArgTypes
		{
			get { return new System.Xml.XPath.XPathResultType[] { System.Xml.XPath.XPathResultType.String };  }
		}

		public object Invoke(System.Xml.Xsl.XsltContext xsltContext, object[] args, System.Xml.XPath.XPathNavigator docContext)
		{
			return (args[0].ToString()).ToLower();
		}

		public int Maxargs
		{
			get { return 1; }
		}

		public int Minargs
		{
			get { return 1; }
		}

		public System.Xml.XPath.XPathResultType ReturnType
		{
			get { return System.Xml.XPath.XPathResultType.Boolean; }
		}

		#endregion
	}
	private class EndsWithFunction : System.Xml.Xsl.IXsltContextFunction
	{
		#region IXsltContextFunction Members

		public System.Xml.XPath.XPathResultType[] ArgTypes
		{
			get { return new System.Xml.XPath.XPathResultType[] { System.Xml.XPath.XPathResultType.String, System.Xml.XPath.XPathResultType.String };  }
		}

		public object Invoke(System.Xml.Xsl.XsltContext xsltContext, object[] args, System.Xml.XPath.XPathNavigator docContext)
		{
			return (args[0].ToString()).EndsWith(args[1].ToString());
		}

		public int Maxargs
		{
			get { return 2; }
		}

		public int Minargs
		{
			get { return 2; }
		}

		public System.Xml.XPath.XPathResultType ReturnType
		{
			get { return System.Xml.XPath.XPathResultType.Boolean; }
		}

		#endregion
	}
}

