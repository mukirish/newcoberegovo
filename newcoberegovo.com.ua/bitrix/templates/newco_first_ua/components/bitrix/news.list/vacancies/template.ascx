<%@ Reference Control="~/bitrix/components/bitrix/news.list/component.ascx" %>
<%@ Control Language="C#" AutoEventWireup="true" Inherits="NewsListTemplate" %>
<%@ Import namespace="Bitrix" %>
<%@ Import namespace="Bitrix.IBlock" %>
<%@ Import namespace="System.Collections.Generic" %>

<style>
    .vacancy-text {
        margin:20px 0;
        border:1px solid rgba(0, 0, 0, 0.3);
        background-color:rgba(255, 255, 255, 0.3);
        padding:30px; 
        border-radius:5px;
    }
</style>

<div class="row">
    <div class="col-xs-8 col-sm-8 col-md-8 col-lg-8">
    <% int i = 0; %>
    <%foreach (var item in Component.Items) {%>
        <% i++; %>
        <button class="btn btn-block btn-default collapsed" type="button" data-toggle="collapse" data-target="#collapse-<%=i %>" aria-expanded="false" aria-controls="collapseExample"><%= item.Name %></button>
        <div class="collapse" id="collapse-<%=i %>" aria-expanded="false" style="height: 0px;">
            <div class="well">
                <h3><%= item.Name %></h3>
                <%if (item.Properties != null) {%>
                    <ul><%
                            
                        foreach (KeyValuePair<string, Bitrix.BXCustomProperty> kvp in item.Element.Properties){
                            switch (kvp.Key) {
                                case "EXPERIENCE":%>
                                    <li><strong>Досвід:</strong> <%= kvp.Value.Value%></li><%
                                    break;
                                case "EDUCATION":%>
                                    <li><strong>Освіта:</strong> <%= kvp.Value.Value%></li><%
                                    break;
                                case "TIMETABLE":%>
                                    <li><strong>Графік:</strong> <%= kvp.Value.Value%></li><%
                                    break;
                            }
                        }%>
                    </ul>
                <%}%>
                <%// Вывод текста анонса
                if (!String.IsNullOrEmpty(item.PreviewText) && Component.ShowPreviewText) {%>
                    <div class="vacancy-text"><%=item.PreviewText%></div><%
	            }%>
                <button type="button" class="btn btn-block btn-warning" data-toggle="modal" data-target="#myModal">Подати заявку</button>
            </div>
        </div>
        <br>

    <%}%>
    </div><%--col-xs-8--%>
</div><%--row--%>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="display: none;">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Закрити"><span aria-hidden="true">×</span></button>
                <h4 class="modal-title" id="myModalLabel">Відправити форму</h4>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label for="exampleInputName2">Прізвище</label>
                        <input type="text" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputName2">Ім'я</label>
                        <input type="text" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputEmail1">E-mail</label>
                        <input type="email" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputName2">Телефон з кодом міста або оператора (050 XXX XX XX)</label>
                        <input type="tel" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputName2">Супровідний текст</label>
                        <textarea class="form-control" rows="3"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="exampleInputFile">Завантажити резюме</label>
                        <input type="file" id="exampleInputFile">
                        <p class="help-block">Приймаються файли у форматах PDF, RTF, TXT, DOC, DOCX, ODT</p>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Закрити</button>
                <button type="button" class="btn btn-success">Відправити</button>
            </div>
        </div>
    </div>
</div>