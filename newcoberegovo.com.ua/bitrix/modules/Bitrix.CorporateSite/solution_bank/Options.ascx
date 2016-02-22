<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Options.ascx.cs" Inherits="bitrix_modules_bitrix_corporatesite_Options" EnableViewState="false" %>

<bx:BXValidationSummary ID="errorMessage" runat="server" CssClass="errorSummary" ValidationGroup="vgInnerForm_Bank" HeaderText="<%$ Loc:Kernel.Error %>" />
<% if (Request["status"] == "ok") { %> 
<bx:BXMessage ID="successMessage" runat="server" CssClass="ok" IconClass="ok" Title="<%$ Loc:Kernel.Information %>" Content="Настройки успешно сохранены" />
<% } %>
<bx:BXTabControl ID="TabControl_Bank" ValidationGroup="vgInnerForm_Bank" runat="server" OnCommand="TabControl_Command">
	<bx:BXTabControlTab runat="server" ID="Tab_Bank" Selected="True" Title="Настройки параметров компонентов ( Сайт компании сферы услуг )" Text="Компоненты">
		<table border="0" cellpadding="0" cellspacing="0" class="edit-table">
		       <tr class="heading">
				<td colspan="2">Депозиты</td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Путь ЧПУ:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Bank_DepositsSefFolder" /></td>
			</tr>
		    <tr valign="top">
				<td class="field-name" width="40%">Путь к списку депозитов:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Bank_DepositsBackUrl" /></td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Путь к депозиту:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Bank_DepositsDetailUrl" /></td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Инфоблок:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Bank_DepositsIblockId_int" /></td>
			</tr>
			<tr class="heading">
				<td colspan="2">Новости</td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Путь ЧПУ:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Bank_NewsSefFolder" /></td>
			</tr>
			
			<tr valign="top">
				<td class="field-name" width="40%">Путь к новости:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Bank_NewsDetailUrl" /></td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Инфоблок:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Bank_BankNewsIBlockId_int" /></td>
			</tr>
			
			<tr class="heading">
				<td colspan="2">Вакансии</td>
			</tr>
			
			<tr valign="top">
				<td class="field-name" width="40%">Путь ЧПУ:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Bank_VacanciesSefFolder" /></td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Инфоблок:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Bank_VacanciesIblockId_int" /></td>
			</tr>
			
			<tr class="heading">
				<td colspan="2">Руководство</td>
			</tr>
			
			<tr valign="top">
				<td class="field-name" width="40%">Путь к списку руководства:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Bank_ManagementDetailUrl" /></td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Инфоблок:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Bank_ManagementIBlockId_int" /></td>
			</tr>
			
			<tr class="heading">
				<td colspan="2">Обратная связь</td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Инфоблок:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Bank_FeedBackIBlockId_int" /></td>
			</tr>
			
			<tr class="heading">
				<td colspan="2">Шаблон сайта</td>
			</tr>
			
			<tr valign="top">
				<td class="field-name" width="40%">Включаемая область слогана компании:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Bank_TemplateSloganIncludeArea" /></td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Включаемая область логотипа сайта:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Bank_TemplateLogoIncludeArea" /></td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Включаемая область подписи сайта:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Bank_TemplateCopyrightIncludeArea" /></td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Включаемая область баннера:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Bank_BannerIncludeArea" /></td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Включаемая область текста баннера:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Bank_BannerTextIncludeArea" /></td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Включаемая область с телефоном компании:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Bank_TemplatePhoneIncludeArea" /></td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Включаемая область с расписанием работы компании:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Bank_TemplateScheduleIncludeArea" /></td>
			</tr>
			
			<tr class="heading">
				<td colspan="2">Разное</td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Путь к странице поиска:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Bank_SearchUrl" /></td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Путь ЧПУ к странице авторизации:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Bank_LoginSefFolder" /></td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Путь для меню на главной странице:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Bank_DefaultPageMenuPath" /></td>
			</tr>
		</table>
	</bx:BXTabControlTab>
</bx:BXTabControl>