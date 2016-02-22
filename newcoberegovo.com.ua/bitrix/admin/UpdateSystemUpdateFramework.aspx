<%@ Page Language="C#" MasterPageFile="~/bitrix/admin/AdminMasterPage.master" AutoEventWireup="true" CodeFile="UpdateSystemUpdateFramework.aspx.cs" Inherits="bitrix_admin_UpdateSystemUpdateFramework" Title="<%$ LocRaw:PageTitle %>"  EnableViewState="false" %>
<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.Web.Hosting" %>

<asp:Content ID="mainContent" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<bx:BXMessage ID="resultMessage" runat="server" CssClass="Ok" IconClass="Ok" Visible="False" />
	<bx:BXContextMenuToolbar ID="BXContextMenuToolbar1" runat="server" OnCommandClick="ContextMenu_CommandClick">
	<Items>
		<bx:BXCmSeparator ID="BXCmSeparator1" runat="server">
		</bx:BXCmSeparator>
		<bx:BXCmImageButton ID="BXCmImageButton2" runat="server" 
			CommandName="ViewUpdates" Text="<%$ LocRaw:ActionText.ToUpdateSystem %>"  >
		</bx:BXCmImageButton>
	</Items>
	</bx:BXContextMenuToolbar>
	
	<div width="100%" class="notes">
	<table width="100%" cellspacing="0" cellpadding="0" border="0" class="notes">
		<tr class="top">
			<td class="left"><div class="empty"></div></td>
			<td><div class="empty"></div></td>
			<td class="right"><div class="empty"></div></td>
		</tr>
		<tr>
			<td class="left"><div class="empty"></div></td>
			<td class="content">
	 
			<%
				bool fw4libraries = Environment.Version.Major >= 4;				
			%>
			<% if (fw4libraries) { %>
				<%= this.GetMessageRaw("Framework4Installed") %>
			<% } else { %>
				<%= this.GetMessageRaw("Framework4NotInstalled") %>
			<% } %>
			<p>&nbsp;</p>	
			<%
			bool fw4Configured = false;
			
			try
			{								
				XmlDocument config = new XmlDocument();
				config.Load(HostingEnvironment.MapPath("~/web.config"));
				
				XmlNode element = config.DocumentElement.SelectSingleNode("system.web/compilation");
				if (element != null)
				{
					XmlAttribute attr = element.Attributes["targetFramework"];
					if (attr != null && !string.IsNullOrEmpty(attr.Value))
					{
						try
						{
							Version version = new Version(attr.Value);
							if (version.Major >= 4)
							{
								fw4Configured = true;
							}
						}
						catch
						{							
						}
					}
				}			
			}
			catch
			{				
			}		
			%>	
					
			<% if (fw4Configured) { %>
				<%= this.GetMessageRaw("Framework4Configured") %>
			<% } else { %>
				<%= this.GetMessageRaw("Framework4NotConfigured") %>
			<% } %>


			</td>
			<td class="right"><div class="empty"></div></td>
		</tr>
		<tr class="bottom">
			<td class="left"><div class="empty"></div></td>
			<td><div class="empty"></div></td>
			<td class="right"><div class="empty"></div></td>
		</tr>
	</table>
	</div>
</asp:Content>

