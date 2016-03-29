<%@ Reference Control="~/bitrix/components/bitrix/iblock.element.webform/component.ascx" %>
<%@ Control Language="C#" Inherits="Bitrix.IBlock.Components.IBlockElementWebFormTemplate" AutoEventWireup="True" %>
<%@ Import Namespace="Bitrix.IBlock.Components" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="Bitrix" %>

<%
if (Component.IsPermissionDenied)
{
	return;
}
else if (Component.IsSavingElementSuccess)
{
	if (Component.Element == null)
	{
		%><span class="notetext"><%=Component.SuccessMessageAfterCreateElement%></span><br /><%
		return;
	}
	else
	{
		%><span class="notetext"><%=Component.SuccessMessageAfterUpdateElement%></span><br /><%	
	}
}
else if (!String.IsNullOrEmpty(Component.errorMessage))
{ 
	%><span class="errortext"><%=Component.errorMessage%></span><br /><%
	return;
}	

foreach (string error in Component.SummaryErrors)
{
	%><span class="errortext"><%= error %></span><br /><%
}
if (Component.SummaryErrors.Count > 0)
{
	%><br /><%
}	                                                   	
%>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="display: none;">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Закрити"><span aria-hidden="true">×</span></button>
                <h4 class="modal-title" id="myModalLabel">Відправити форму</h4>
            </div>
            <div class="modal-body">
                    <%IBlockElementWebFormComponent.ElementField field = Component.ElementFields["PROPERTY_VACANCY"]; %>
                    <input name="<%= field.FormFieldName%>" id="<%= field.UniqueId%>" type="hidden" class="created-vacancy-name" />
                    
                    <%field = Component.ElementFields["Name"]; %>
                    <input name="<%= field.FormFieldName%>" id="<%= field.UniqueId%>" type="hidden" class="created-vacancy-name" />

                    <%field = Component.ElementFields["PROPERTY_LAST_NAME"]; %>
                    <div class="form-group">
                        <label for="<%= field.FormFieldName%>"><%= field.Title %></label>
                        <input name="<%= field.FormFieldName %>" id="<%= field.UniqueId %>" type="text" class="form-control"/>
                    </div>
                    <%field = Component.ElementFields["PROPERTY_FIRST_NAME"]; %>
                    <div class="form-group">
                        <label for="<%= field.FormFieldName%>"><%= field.Title %></label>
                        <input name="<%= field.FormFieldName %>" id="<%= field.UniqueId %>" type="text" class="form-control"/>
                    </div>
                    <%field = Component.ElementFields["PROPERTY_EMAIL"]; %>
                    <div class="form-group">
                        <label for="<%= field.FormFieldName%>"><%= field.Title %></label>
                        <input name="<%= field.FormFieldName %>" id="<%= field.UniqueId %>" type="email" class="form-control"/>
                    </div>
                    <%field = Component.ElementFields["PROPERTY_PHONE"]; %>
                    <div class="form-group">
                        <label for="<%= field.FormFieldName%>"><%= field.Title %></label>
                        <input name="<%= field.FormFieldName %>" id="<%= field.UniqueId %>" type="tel" class="form-control"/>
                    </div>
                    <%field = Component.ElementFields["PreviewText"]; %>
                    <div class="form-group">
                        <label for="<%= field.FormFieldName%>">Супровідний текст</label>
                        <textarea name="<%= field.FormFieldName%>" id="<%= field.UniqueId%>" class="form-control" rows="3"></textarea>
                    </div>
                    <%field = Component.ElementFields["PROPERTY_FILE"]; %>
                    <div class="form-group">
                        <label for="<%= field.FormFieldName%>"><%= field.Title %></label>
                        <input name="<%= field.FormFieldName %>" id="<%= field.UniqueId %>" type="file" />
                        <p class="help-block">Приймаються файли у форматах PDF, RTF, TXT, DOC, DOCX, ODT</p>
                    </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Закрити</button>
                <asp:Button runat="server" ID="SaveButton" CssClass="btn btn-success" Text="Відправити" OnClick="SaveWebForm" />
            </div>
        </div>
    </div>
</div>

<script>
    $(function() {
        $('.create-vacancy-request').click(function() {
            $('.created-vacancy-name').val($(this).data('vacancy'));
        });
    });
</script>

<script runat="server">
	protected override void OnLoad(EventArgs e)
	{
		if (Component.IsPermissionDenied)
		{
			Bitrix.Security.BXAuthentication.AuthenticationRequired();
		}
	}

	public override string Title
	{
		get
		{
			return GetMessageRaw("Title");
		}
	}
</script>