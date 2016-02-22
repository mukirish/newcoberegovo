<%@ Control Language="C#" ClassName="template" Inherits="Bitrix.UI.BXComponentTemplate" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="Bitrix" %>
<%@ Import Namespace="Bitrix.DataTypes" %>
<%@ Import Namespace="Bitrix.Services" %>

<script runat="server">
	protected void Search_Click(object sender, EventArgs args)
	{
		BXParamsBag<object> p = new BXParamsBag<object>();
		p.Add("query", query.Text);

		Component.ProcessCommand("search", p, new List<string>());
	}
</script>

<div id="search-form" onkeypress="return FireDefaultButton(event, '<%= Bitrix.Services.Js.BXJSUtility.Encode(search.ClientID) %>');">
	<asp:TextBox ID="query" runat="server" placeholder="Пошук по сайту..." />
	<asp:Button ID="search" CssClass="button" runat="server" OnClick="Search_Click" />
</div>
