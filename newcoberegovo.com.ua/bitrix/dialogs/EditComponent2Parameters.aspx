<%@ Page Language="C#" AutoEventWireup="false" CodeFile="EditComponent2Parameters.aspx.cs" Inherits="BXDialogEditComponent2Parameters" %>
<%@ Import Namespace="Bitrix.Components" %>
<html>
<head id="Head" runat="server">
    <title></title>
</head>

<body>
    <form id="form1" runat="server">
        <bx:BXPageAsDialogBehaviour runat="server" ID="Behaviour" UseStandardStyles="true" OnSave="Behaviour_Save" />
        <table cellspacing="0" class="bx-width100"><tbody>
        <% 
            foreach (BXCategory category in ComponentCategories)
           {
               string sectionId = HttpUtility.HtmlAttributeEncode(string.Concat("paramsection_", category.Code)),
                sectionExpanderId = HttpUtility.HtmlAttributeEncode(string.Concat("paramsection_expander_", category.Code)); %>            

        <tr id="<%= sectionId %>" class="section">
            <td colspan="4">
                <table cellspacing="0"><tbody>
                    <tr>
                        <td>
                        <a id="<%= sectionExpanderId %>" class="bx-popup-sign bx-popup-minus" title="<%= GetMessage("ToolTip.ExpandCollapseSection") %>" onclick="var expand = this.className == 'bx-popup-sign bx-popup-plus'; Bitrix.ComponentParametersEditor.getInstance().expandSection('<%= category.Code %>', expand);" href="javascript:void(0)"></a>                            
                        </td>
                        <td><%= HttpUtility.HtmlEncode(category.Title)%></td>  
                    </tr>
                </tbody></table>
            </td>
        </tr>
            <% 
                BXParametersDefinition parameters = GetComponentParamDefinitionByCategory(category);
               if (parameters.Count > 0) { %>
            <%  
                foreach (KeyValuePair<string, BXParam> kv in parameters) { %>
                <%= RenderComponentRow(kv.Value, kv.Key)%>
            <%  } %>
            <% } %>
            <% else{ %>
               <tr>
                    <td><%= GetMessage("NoData") %></td>
               </tr>                             
            <% }%>
            <tr class="empty">
                <td colspan="2">
                    <div class="empty"></div>
                </td>
            </tr> 
            <script type="text/javascript">
                Bitrix.ComponentParametersEditor.getInstance().setSection(Bitrix.ComponentParameterSection.create("<%= category.Code %>", "<%= sectionId %>", "<%= sectionExpanderId %>"));
            </script>                 
        <% }%>       
        </tbody></table>
        <% componentParameters.Visible = false; %>
        <asp:PlaceHolder runat="server" ID="componentParameters"></asp:PlaceHolder>
    </form>
</body>
</html>
