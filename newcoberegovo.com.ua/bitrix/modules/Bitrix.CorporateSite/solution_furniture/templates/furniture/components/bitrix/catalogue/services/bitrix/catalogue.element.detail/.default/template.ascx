﻿<%@ Reference Control="~/bitrix/components/bitrix/catalogue.element.detail/component.ascx" %>
<%@ Control Language="C#" AutoEventWireup="true" Inherits="Bitrix.IBlock.Components.CatalogueElementDetailTemplate" %>
<%@ Import Namespace="Bitrix.IBlock.Components" %>

<%
if (!String.IsNullOrEmpty(Component.errorMessage))
{ 
	%><span class="errortext"><%=Component.errorMessage%></span><%
}
else if (Component.Element != null)
{
	%>

		<div class="catalog-item-desc-float">
			<%
	            if (Component.Element.DetailText.Length > 0)
	            {
		            %><%= Component.Element.DetailText%><%
	            }
	            else if (Component.Element.PreviewText.Length > 0)
	            {
		            %><%= Component.Element.PreviewText%><%
	            }
            	
	            %>
            		
		</div>
	<% 
	string title = Parameters.Get("Template_BackTitle");
	string url = Parameters.Get("Template_BackUrlTemplate");
	bool link = false;
	if (!string.IsNullOrEmpty(title) && !string.IsNullOrEmpty(url))
	{
		Bitrix.DataTypes.BXParamsBag<object> replace = new Bitrix.DataTypes.BXParamsBag<object>();
		
		replace["ElementId"] = replace["ELEMENT_ID"] = Component.ElementId;
		replace["ElementCode"] = replace["ELEMENT_CODE"] = Component.ElementCode;
		
		int sectionId = Parameters.GetInt("SectionId");
		if (sectionId == 0 && Component.Element != null &&  Component.Element.Sections.Count != 0)
			sectionId = Component.Element.Sections[0].SectionId;
		replace["SectionId"] = replace["SECTION_ID"] = sectionId;
        if (sectionId == 0)
            url = url.Replace("#SectionId#/", "");
		replace["SectionCode"] = replace["SECTION_CODE"] = Parameters.GetString("SectionCode", "");
		url = Component.ResolveTemplateUrl(url, replace);
		link = true;
	}
%>	
		
	<% if (link){%>
	    <a class="news-detail-link" href="<%= Encode(url) %>">&larr; <%=Encode(title) %></a>
        <%} %>
<%
} 
%>

	<script runat="server">
	protected override void PreLoadTemplateDefinition(Bitrix.Components.BXParametersDefinition def)
	{
		def["Template_BackTitle"] = new Bitrix.Components.BXParamText(GetMessageRaw("Param.BackTitle"), GetMessageRaw("DefaultBackTitle"), Bitrix.Components.BXCategory.UrlSettings);
		def["Template_BackUrlTemplate"] = new Bitrix.Components.BXParamText(GetMessageRaw("Param.BackUrlTemplate"), "~/services/#SECTION_ID#/", Bitrix.Components.BXCategory.UrlSettings);
	}
    </script>