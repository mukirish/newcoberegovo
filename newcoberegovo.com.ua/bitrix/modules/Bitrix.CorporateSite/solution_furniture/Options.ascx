<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Options.ascx.cs" Inherits="bitrix_modules_bitrix_corporatesite_Options" EnableViewState="false" %>

<bx:BXValidationSummary ID="errorMessage" runat="server" CssClass="errorSummary" ValidationGroup="vgInnerForm_Bank" HeaderText="<%$ Loc:Kernel.Error %>" />
<% if (Request["status"] == "ok") { %> 
<bx:BXMessage ID="successMessage" runat="server" CssClass="ok" IconClass="ok" Title="<%$ Loc:Kernel.Information %>" Content="Настройки успешно сохранены" />
<% } %>
<bx:BXTabControl ID="TabControl_Furniture" ValidationGroup="vgInnerForm_Furn" runat="server" OnCommand="TabControl_Command">
	<bx:BXTabControlTab runat="server" ID="Tab_Furniture" Selected="True" Title="Настройки параметров компонентов ( Сайт компании производственной сферы)" Text="Компоненты">
		<table border="0" cellpadding="0" cellspacing="0" class="edit-table">
		    <tr class="heading">
				<td colspan="2">Новости</td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Путь ЧПУ:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Furniture_NewsSEFFolder" /></td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Путь к новости:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Furniture_NewsDetailUrl" /></td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Инфоблок:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Furniture_NewsIblockId_int" /></td>
			</tr>
			<tr class="heading">
				<td colspan="2">Услуги</td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Путь ЧПУ:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Furniture_ServicesSEFFolder" /></td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Инфоблок:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Furniture_ServicesIblockId_int" /></td>
			</tr>
			<tr class="heading">
				<td colspan="2">Вакансии</td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Путь ЧПУ:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Furniture_VacanciesSEFFolder" /></td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Инфоблок:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Furniture_VacanciesIblockId_int"/></td>
			</tr>
			<tr class="heading">
				<td colspan="2">Продукты</td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Путь ЧПУ:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Furniture_ProductsSEFFolder" /></td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Путь к продукту:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Furniture_ProductsDetailUrl" /></td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Инфоблок:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Furniture_CatalogIblockId_int" /></td>
			</tr>
			
			<tr class="heading">
				<td colspan="2">Шаблон сайта</td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Включаемая область слогана компании:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Furniture_TemplateSloganIncludeArea" /></td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Включаемая область логотипа сайта:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Furniture_TemplateLogoIncludeArea" /></td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Включаемая область подписи сайта:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Furniture_TemplateCopyrightIncludeArea" /></td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Включаемая область баннера:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Furniture_TemplateBannerIncludeArea" /></td>
			</tr>
			<tr class="heading">
				<td colspan="2">Разное</td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Путь ЧПУ к странице авторизации:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Furniture_LoginSEFFolder" /></td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Путь к странице поиска:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Furniture_SearchUrl" /></td>
			</tr>
		</table>
	</bx:BXTabControlTab>
</bx:BXTabControl>
