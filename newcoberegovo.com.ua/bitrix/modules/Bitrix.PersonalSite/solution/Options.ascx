<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Options.ascx.cs" Inherits="bitrix_modules_main_Options" EnableViewState="false" %>

<bx:BXValidationSummary ID="errorMessage" runat="server" CssClass="errorSummary" ValidationGroup="vgInnerForm" HeaderText="<%$ Loc:Kernel.Error %>" />
<% if (Request["status"] == "ok") { %> 
<bx:BXMessage ID="successMessage" runat="server" CssClass="ok" IconClass="ok" Title="<%$ Loc:Kernel.Information %>" Content="Настройки успешно сохранены" />
<% } %>


<bx:BXTabControl ID="TabControl" ValidationGroup="vgInnerForm" runat="server" OnCommand="TabControl_Command">
	<bx:BXTabControlTab runat="server" ID="Tab" Selected="True" Title="Настройки параметров компонентов" Text="Компоненты">
		<table border="0" cellpadding="0" cellspacing="0" class="edit-table">
		    <tr class="heading">
				<td colspan="2">Блог</td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Адрес блога:</td>
				<td width="60%"><asp:TextBox runat="server" ID="Blog" /></td>
			</tr>
		    <tr valign="top">
				<td class="field-name" width="40%">Путь к CSS-файлу темы блога:</td>
				<td width="60%"><asp:TextBox runat="server" ID="BlogColorScheme" /></td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Путь ЧПУ:</td>
				<td width="60%"><asp:TextBox runat="server" ID="BlogSefFolder" /></td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Путь к блогу:</td>
				<td width="60%"><asp:TextBox runat="server" ID="BlogUrl" /></td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Путь к посту:</td>
				<td width="60%"><asp:TextBox runat="server" ID="PostUrl" /></td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Путь к RSS поста:</td>
				<td width="60%"><asp:TextBox runat="server" ID="PostRssUrl" /></td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Путь к странице редактирования поста:</td>
				<td width="60%"><asp:TextBox runat="server" ID="PostEditUrl" /></td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Путь к тегам:</td>
				<td width="60%"><asp:TextBox runat="server" ID="BlogTagsUrl" /></td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Путь к комментарию:</td>
				<td width="60%"><asp:TextBox runat="server" ID="CommentUrl" /></td>
			</tr>
			<tr class="heading">
				<td colspan="2">Фотогалерея</td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Инфоблок:</td>
				<td width="60%"><asp:TextBox runat="server" ID="PhotosIBlockId_int" /></td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Путь ЧПУ:</td>
				<td width="60%"><asp:TextBox runat="server" ID="PhotosSefFolder" /></td>
			</tr>
			<tr class="heading">
				<td colspan="2">Обратная связь</td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Инфоблок:</td>
				<td width="60%"><asp:TextBox runat="server" ID="ContactsFeedbackIBlockId_int" /></td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Email:</td>
				<td width="60%"><asp:TextBox runat="server" ID="ContactsEmail" /></td>
			</tr>
			<tr class="heading">
				<td colspan="2">Шаблон сайта</td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Включаемая область названия сайта:</td>
				<td width="60%"><asp:TextBox runat="server" ID="TemplateTitleIncludeArea" /></td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Включаемая область подписи сайта:</td>
				<td width="60%"><asp:TextBox runat="server" ID="TemplateSignatureIncludeArea" /></td>
			</tr>
			<tr class="heading">
				<td colspan="2">Разное</td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Путь к странице профиля:</td>
				<td width="60%"><asp:TextBox runat="server" ID="ProfileUrl" /></td>
			</tr>
			<tr valign="top">
				<td class="field-name" width="40%">Путь ЧПУ к странице авторизации:</td>
				<td width="60%"><asp:TextBox runat="server" ID="LoginSefFolder" /></td>
			</tr>
		</table>
	</bx:BXTabControlTab>
</bx:BXTabControl>
