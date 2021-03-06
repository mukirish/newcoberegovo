﻿<%@ Page Language="C#"
    MasterPageFile="~/bitrix/admin/AdminMasterPage.master" 
	AutoEventWireup="false" 
	CodeFile="AdvertisingSpaceList.aspx.cs" 
	Inherits="bitrix_admin_AdvertisingSpaceList" 
	Title="<%$ LocRaw:PageTitle %>" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<asp:UpdatePanel ID="UpdatePanel" runat="server">
		<ContentTemplate>
       
			<bx:BXAdminFilter ID="ItemFilter" runat="server" AssociatedGridView="ItemGrid">
				<bx:BXTextBoxStringFilter Key="Name" Text="<%$ LocRaw:FilterText.Name %>" Visibility="AlwaysVisible" />
				<bx:BXTextBoxFilter Key="ID" Text="ID" ValueType="Integer" />
				<bx:BXTextBoxStringFilter Key="Code" Text="<%$ LocRaw:FilterText.Code %>" />
				<bx:BXTextBoxFilter Key="Sort" Text="<%$ LocRaw:FilterText.Sort %>" ValueType="Integer" />
				<bx:BXTextBoxStringFilter Key="XmlId" Text="<%$ LocRaw:FilterText.XmlId %>" />
			</bx:BXAdminFilter>

			<bx:BXContextMenuToolbar ID="ItemListToolbar" runat="server">
				<Items>
					<bx:BXCmSeparator SectionSeparator="true" />
					<bx:BXCmImageButton ID="AddButton" Text="<%$ LocRaw:ActionText.Add %>"
						Title="<%$ LocRaw:ActionTitle.Add %>" CssClass="context-button icon btn_new"
						Href="AdvertisingSpaceEdit.aspx" />
				</Items>
			</bx:BXContextMenuToolbar>
			
			<bx:BXPopupPanel ID="PopupPanelView" runat="server">
				<Commands>
					<bx:CommandItem UserCommandId="edit" Default="True" IconClass="edit" 
						ItemText="<%$ LocRaw:PopupText.Edit %>" ItemTitle="<%$ LocRaw:PopupTitle.Edit %>" OnClickScript="window.location.href = 'AdvertisingSpaceEdit.aspx?id=' + UserData['ID']; return false;"  />
					<bx:CommandItem UserCommandId="delete" Default="True" IconClass="delete" ItemText="<%$ LocRaw:PopupText.Delete %>"
						ItemTitle="<%$ LocRaw:PopupTitle.Delete %>" ShowConfirmDialog="true" ConfirmDialogText="<%$ LocRaw:PopupConfirmDialogText.Delete %>" />
				</Commands>
			</bx:BXPopupPanel>
			
			<bx:BXValidationSummary ID="ErrorMessage" runat="server" CssClass="errorSummary" HeaderText="<%$ Loc:Kernel.Error %>" ValidationGroup="GridView"/>
			
			<br />
			
			<bx:BXGridView ID="ItemGrid" runat="server"
				ContentName="<%$ LocRaw:TableTitle %>" AllowSorting="True" AllowPaging="True" DataKeyNames="ID"  
				
				SettingsToolbarId="ItemListToolbar"
				PopupCommandMenuId="PopupPanelView"
				ContextMenuToolbarId="MultiActionMenuToolbar"
				
				DataSourceID="ItemGrid" 
				OnSelect="ItemGrid_Select" 
				OnSelectCount="ItemGrid_SelectCount"
				OnDelete="ItemGrid_Delete"
				OnRowDataBound = "ItemGrid_RowDataBound">
					<Columns>
						<asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" ReadOnly="True"/>
						<asp:TemplateField HeaderText="<%$ LocRaw:ColumnHeaderText.Name %>" SortExpression="Name">
							<itemtemplate>
								<%# Encode(((AdvertisingSpaceWrapper)Container.DataItem).Name)%>
							</itemtemplate>
						</asp:TemplateField>																	
						<asp:TemplateField HeaderText="<%$ LocRaw:ColumnHeaderText.Active %>" SortExpression="Active">
							<itemtemplate>
								<%# Encode(((AdvertisingSpaceWrapper)Container.DataItem).Active)%>
							</itemtemplate>
						</asp:TemplateField>	
						<asp:TemplateField HeaderText="<%$ LocRaw:ColumnHeaderText.DateCreated %>" SortExpression="DateCreated">
							<itemtemplate>
								<%# Encode(((AdvertisingSpaceWrapper)Container.DataItem).DateCreated)%>
							</itemtemplate>
						</asp:TemplateField>
						<asp:TemplateField HeaderText="<%$ LocRaw:ColumnHeaderText.DateLastModified %>" SortExpression="DateLastModified">
							<itemtemplate>
								<%# Encode(((AdvertisingSpaceWrapper)Container.DataItem).DateLastModified)%>
							</itemtemplate>
						</asp:TemplateField>
						<asp:TemplateField HeaderText="<%$ LocRaw:ColumnHeaderText.BannerCount %>">
							<itemtemplate>
								<%# Encode(((AdvertisingSpaceWrapper)Container.DataItem).BannerCount)%>
							</itemtemplate>
						</asp:TemplateField>													
						<asp:TemplateField HeaderText="<%$ LocRaw:ColumnHeaderText.Description %>">
							<itemtemplate>
								<%# Encode(((AdvertisingSpaceWrapper)Container.DataItem).Description)%>
							</itemtemplate>
						</asp:TemplateField>																																	
					</Columns>
					<AjaxConfiguration UpdatePanelId="UpdatePanel" />
			</bx:BXGridView>
			
			<bx:BXMultiActionMenuToolbar ID="MultiActionMenuToolbar" runat="server" ValidationGroup="GridView">
				<Items>
                    <%--					
                    <bx:BXMamImageButton CommandName="inline" ShowConfirmBar="true" DisableForAll="true"
						EnabledCssClass="context-button icon edit" DisabledCssClass="context-button icon edit-dis"
						Title="������������� ��������� ��������� �������" />
				    --%>
					<bx:BXMamImageButton CommandName="delete" ShowConfirmDialog="true" ConfirmDialogText="<%$ LocRaw:ActionConfirmDialogText.Delete %>" ConfirmDialogTextAll="<%$ LocRaw:ActionConfirmDialogTextAll.Delete %>" EnabledCssClass="context-button icon delete"
						DisabledCssClass="context-button icon delete-dis" Title="<%$ LocRaw:ActionTitle.Delete %>" />
				</Items>
			</bx:BXMultiActionMenuToolbar>			

		</ContentTemplate>
	</asp:UpdatePanel>
</asp:Content>