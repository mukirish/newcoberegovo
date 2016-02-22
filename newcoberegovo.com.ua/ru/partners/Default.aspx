<%@ Page Language="C#" Inherits="Bitrix.UI.BXPublicPage, Main"                                                 Title="Партнеры" %>
<script runat="server" id="@__bx_pagekeywords">
	public override void SetPageKeywords(System.Collections.Generic.IDictionary<string, string> keywords)
	{
		keywords[@"keywords"]=@"";
		keywords[@"description"]=@"";
	}
</script>

<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="bxcontent" > 
    <div class="wrap-content">
        <div class="container">
            <p><h3>Партнери <img src="/img/cont_img.png" /></h3></p>
            <!--Documentations-->
            <div class="page">
                <div class="row">
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
                        <img class="col-xs-10 col-sm-10 col-md-10 col-lg-10" src="/img/logo.png" />
                    </div>
                    <div class="col-xs-10 col-sm-10 col-md-10 col-lg-10">
                        <a href="#"><h2>Link</h2></a>
                    </div>
                </div>
                <div class="row" style="margin-top:15px;">
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
                        <img class="col-xs-10 col-sm-10 col-md-10 col-lg-10" src="/img/logo.png" />
                    </div>
                    <div class="col-xs-10 col-sm-10 col-md-10 col-lg-10">
                        <a href="#"><h2>Link</h2></a>
                    </div>
                </div>
                <div class="row" style="margin-top:15px;">
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
                        <img class="col-xs-10 col-sm-10 col-md-10 col-lg-10" src="/img/logo.png" />
                    </div>
                    <div class="col-xs-10 col-sm-10 col-md-10 col-lg-10">
                        <a href="#"><h2>Link</h2></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>