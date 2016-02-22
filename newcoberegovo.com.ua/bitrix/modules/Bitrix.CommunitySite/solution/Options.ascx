<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Options.ascx.cs" Inherits="BitrixCommunityOptions" EnableViewState="false" %>

<bx:BXValidationSummary ID="errorMessage" runat="server" CssClass="errorSummary" ValidationGroup="vgInnerForm" HeaderText="<%$ Loc:Kernel.Error %>" />
<% if (Request["status"] == "ok") { %> 
<bx:BXMessage ID="successMessage" runat="server" CssClass="ok" IconClass="ok" Title="<%$ Loc:Kernel.Information %>" Content="Настройки успешно сохранены" />
<% } %>


<bx:BXTabControl ID="TabControl" ValidationGroup="vgInnerForm" runat="server" OnCommand="TabControl_Command">
	<bx:BXTabControlTab runat="server" ID="Tab" Selected="True" Title="Настройки параметров компонентов" Text="Компоненты">
		<table border="0" cellpadding="0" cellspacing="0" class="edit-table">
						
			<tr valign="top">
				<td class="field-name" width="40%">Путь к сайту:</td>
				<td width="60%"><asp:TextBox runat="server" ID="SiteFolder" /></td>
			</tr>			
			
		    <tr class="heading">
				<td colspan="2">Блоги</td>
			</tr>
			
			<tr valign="top">
				<td class="field-name" width="40%">Путь ЧПУ:</td>
				<td width="60%"><asp:TextBox runat="server" ID="BlogSefFolder" width="300px" /></td>
			</tr>
			
			<tr valign="top">
				<td class="field-name" width="40%">Путь к конкретному блогу:</td>
				<td width="60%"><asp:TextBox runat="server" ID="BlogUrlTemplate" width="300px" /></td>
			</tr>
			
			<tr valign="top">
				<td class="field-name" width="40%">Путь к записи блога:</td>
				<td width="60%"><asp:TextBox runat="server" ID="PostViewUrlTemplate" width="300px" /></td>
			</tr>
			
			<tr valign="top">
				<td class="field-name" width="40%">Теги блогов:</td>
				<td width="60%"><asp:TextBox runat="server" ID="SearchTagsUrlTemplate" width="300px" /></td>
			</tr>
			
			<tr valign="top">
				<td class="field-name" width="40%">RSS комментариев записи:</td>
				<td width="60%"><asp:TextBox runat="server" ID="PostRssUrlTemplate" width="300px" /></td>
			</tr>
			
			<tr valign="top">
				<td class="field-name" width="40%">Создать новый блог:</td>
				<td width="60%"><asp:TextBox runat="server" ID="NewBlogUrlTemplate" width="300px" /></td>
			</tr>
			
			<tr valign="top">
				<td class="field-name" width="40%">Редактирование записи:</td>
				<td width="60%"><asp:TextBox runat="server" ID="PostEditUrlTemplate" width="300px" /></td>
			</tr>
			
			<tr valign="top">
				<td class="field-name" width="40%">Создание новой записи:</td>
				<td width="60%"><asp:TextBox runat="server" ID="NewPostUrlTemplate" width="300px" /></td>
			</tr>	
			
			<tr valign="top">
				<td class="field-name" width="40%">Путь к цветовой схеме блогов:</td>
				<td width="60%"><asp:TextBox runat="server" ID="BlogColorScheme" width="300px" /></td>
			</tr>
			
			<tr valign="top">
				<td class="field-name" width="40%">ID категории, к которой привязываются новые блоги:</td>
				<td width="60%"><asp:TextBox runat="server" ID="BlogCategoryId" width="300px" /></td>
			</tr>											
			
		    <tr class="heading">
				<td colspan="2">Форумы</td>
			</tr>			
			
			<tr valign="top">
				<td class="field-name" width="40%">Путь ЧПУ:</td>
				<td width="60%"><asp:TextBox runat="server" ID="ForumSefFolder" width="300px" /></td>
			</tr>
			
			<tr valign="top">
				<td class="field-name" width="40%">Страница чтения темы:</td>
				<td width="60%"><asp:TextBox runat="server" ID="TopicReadUrlTemplate" width="300px" /></td>
			</tr>
			
			<tr valign="top">
				<td class="field-name" width="40%">Страница списка тем форума:</td>
				<td width="60%"><asp:TextBox runat="server" ID="ForumReadUrlTemplate" width="300px" /></td>
			</tr>
			
			<tr valign="top">
				<td class="field-name" width="40%">Путь к цветовой схеме форума:</td>
				<td width="60%"><asp:TextBox runat="server" ID="ForumColorScheme" width="300px" /></td>
			</tr>				
			
		    <tr class="heading">
				<td colspan="2">Пользователи</td>
			</tr>
			
			<tr valign="top">
				<td class="field-name" width="40%">Путь ЧПУ:</td>
				<td width="60%"><asp:TextBox runat="server" ID="PeopleSefFolder" width="300px" /></td>
			</tr>
			
			<tr valign="top">
				<td class="field-name" width="40%">Профиль пользователя:</td>
				<td width="60%"><asp:TextBox runat="server" ID="UserProfileUrlTemplate" width="300px" /></td>
			</tr>
			
			<tr valign="top">
				<td class="field-name" width="40%">Страница редактирования пользователя:</td>
				<td width="60%"><asp:TextBox runat="server" ID="UserProfileEditUrlTemplate" width="300px" /></td>
			</tr>			
			
			<tr valign="top">
				<td class="field-name" width="40%">Личные сообщения пользователя:</td>
				<td width="60%"><asp:TextBox runat="server" ID="UserMailUrlTemplate" width="300px" /></td>
			</tr>
			
			<tr valign="top">
				<td class="field-name" width="40%">Написать новое письмо:</td>
				<td width="60%"><asp:TextBox runat="server" ID="UserMailNewUrlTemplate" width="300px" /></td>
			</tr>
			
			<tr valign="top">
				<td class="field-name" width="40%">Страница чтения личного сообщения:</td>
				<td width="60%"><asp:TextBox runat="server" ID="UserMailReadUrlTemplate" width="300px" /></td>
			</tr>

			<tr valign="top">
				<td class="field-name" width="40%">Написать письмо пользователю:</td>
				<td width="60%"><asp:TextBox runat="server" ID="UserMailNewForUsersUrlTemplate" width="300px" /></td>
			</tr>
			
		    <tr class="heading">
				<td colspan="2">Авторизация</td>
			</tr>

			<tr valign="top">
				<td class="field-name" width="40%">Путь ЧПУ:</td>
				<td width="60%"><asp:TextBox runat="server" ID="LoginSefFolder" width="300px" /></td>
			</tr>
			
			<tr valign="top">
				<td class="field-name" width="40%">Страница входа на сайт:</td>
				<td width="60%"><asp:TextBox runat="server" ID="LoginUrlTemplate" width="300px" /></td>
			</tr>
			
			<tr valign="top">
				<td class="field-name" width="40%">Страница выхода с сайта:</td>
				<td width="60%"><asp:TextBox runat="server" ID="LogoutUrlTemplate" width="300px" /></td>
			</tr>
			
			<tr valign="top">
				<td class="field-name" width="40%">Страница регистрации нового пользователя:</td>
				<td width="60%"><asp:TextBox runat="server" ID="RegistrationUrlTemplate" width="300px" /></td>
			</tr>
			
			<tr valign="top">
				<td class="field-name" width="40%">Страница восстановления пароля:</td>
				<td width="60%"><asp:TextBox runat="server" ID="RecoveryUrlTemplate" width="300px" /></td>
			</tr>												
			
		    <tr class="heading">
				<td colspan="2">Включаемые области</td>
			</tr>
			
			<tr valign="top">
				<td class="field-name" width="40%">Включаемая область с логотипом сайта:</td>
				<td width="60%"><asp:TextBox runat="server" ID="TemplateLogoIncludeArea" width="300px" /></td>
			</tr>	
			
			<tr valign="top">
				<td class="field-name" width="40%">Включаемая область заголовка сайта:</td>
				<td width="60%"><asp:TextBox runat="server" ID="TemplateLogoText" width="300px" /></td>
			</tr>	
			
			<tr valign="top">
				<td class="field-name" width="40%">Включаемая область подписи сайта:</td>
				<td width="60%"><asp:TextBox runat="server" ID="CopyrightText" width="300px" /></td>
			</tr>													
			
		    <tr class="heading">
				<td colspan="2">Поиск</td>
			</tr>
			
			<tr valign="top">
				<td class="field-name" width="40%">Страница поиска:</td>
				<td width="60%"><asp:TextBox runat="server" ID="SearchPageUrlTemplate" width="300px" /></td>
			</tr>								

		</table>
	</bx:BXTabControlTab>
</bx:BXTabControl>
