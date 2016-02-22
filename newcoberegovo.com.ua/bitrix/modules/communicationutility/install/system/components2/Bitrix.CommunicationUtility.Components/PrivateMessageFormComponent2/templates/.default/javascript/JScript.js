/// <reference path="../../../../../../../Scripts/jquery-1.5.1-vsdoc.js" />

$(function () {
    $("#Recievers").keydown(
        function (event) {
            switch (event.which) {
                case 38:
                    var childs = $("#find-panel").children();
                    if ((dropDownMenu.Users = childs.length) > 0) {
                        if (dropDownMenu.SelectedUser > 1) {
                            var a = dropDownMenu.SelectedUser;
                            childs[--a].removeClass("active");
                            childs[a - 1].addClass("active");
                        }
                    }
                    break;
                case 40:
                    var childs = $("#find-panel").children();
                    if ((dropDownMenu.Users = childs.length) > 0) {
                        if (dropDownMenu.SelectedUser > 1) {
                            var a = dropDownMenu.SelectedUser;
                            childs[a - 1].removeClass("active");
                            childs[++a].addClass("active");
                        }
                    }
                    break;
            }
        }
    );
    
    //// вывод возможных адресатов в ниспадающем списке
    $("#Recievers").keyup(
        function (event) {
            if (event.which == 40) {
                return;
            }
            if (!/\S/.test(this.value)) {
                $("#find-panel").addClass("display-none");
                return;
            }
            else {
                $.getJSON(
                    urlList.getUsers,
                    {
                        bxValidationToken: document.getElementsByName("bxValidationToken")[0].attributes["value"].value,
                        userName: this.value
                    },
                    function (data) {
                        var panel = $("#find-panel");
                        panel.empty();
                        $.each(data, function () {
                            $('<span class="available-user">').data('user', this).text(this.name + " (" + this.id + ")").appendTo(panel);
                        });
                    }
                );
                $("#find-panel").removeClass("display-none");
            }
        });

    //// вывод preview
    $("button#preview").click(
        function () {
            event.preventDefault();
            var value = $("#MessageContent").val();
            if (!/\S/.test(value)) {
                return;
            }

            $("div#preview-message").load(
                urlList.getPreview,
                {
                    bxValidationToken: document.getElementsByName("bxValidationToken")[0].attributes["value"].value,
                    text: value
                },
                function () {
                    $("div#preview-content").removeClass("display-none");
                });
        }
    );

    //// скрытие окна при клике вне поиска
    $('html').click(
        function () {
            $("#find-panel").addClass("display-none");
        }
    );

    //// добавление пользователя при выборе в ниспадающем списке
    $(document).on(
        'click',
        'div#find-panel span.available-user',
        function () {
            var user = $(this).data('user');
            if (selectedUsers[user.id]) {
                return;
            }
            selectedUsers[user.id] = user.id;
            var li = '<li><input type="hidden" name="SelectedUsers" value="' + user.id + '"/>'
                + user.name + " (" + user.id + ")"
                + "<a href = '" + user.profileUrl + "' class = 'showRecievers'>" + dict.profile + "</a>"
                + "<a class = 'remove-selected-user' href = '#'>" + dict.remove + "</a>"
                + '</li>';
            $(li).data("user", user).appendTo("ul#showRecievers");
        }
    );

    //// удаление пользователя из списка получателей
    $(document).on(
        'click',
        'li a.remove-selected-user',
        function () {
            var li = $(this).closest("li");
            if (li.data('user') != null) {
                delete selectedUsers[li.data('user').id];
            }
            li.remove();
        }
    );

    //// Валидация отправки на сервер
    $("button#save").click(
        function () {
            var hasErrors = false;
            var hasRecievers = $("#Recievers").length == 0;
            for (var user in selectedUsers) {
                hasRecievers = true;
                break;
            }

            $("div#pmForm-errors ul#errors-list").empty();

            if (!hasRecievers) {
                hasErrors = true;
                $("div#pmForm-errors").removeClass("display-none");
                $("<li>").text(dict.noRecievers).appendTo("div#pmForm-errors ul#errors-list");

            }

            if (!/\S/.test($("#MessageContent").val())) {
                hasErrors = true;
                $("div#pmForm-errors").removeClass("display-none");
                $("<li>").text(dict.noContent).appendTo("div#pmForm-errors ul#errors-list");
            }

            if (!/\S/.test($("#TopicTitle").val())) {
                hasErrors = true;
                $("div#pmForm-errors").removeClass("display-none");
                $("<li>").text(dict.noTitle).appendTo("div#pmForm-errors ul#errors-list");
            }

            if (hasErrors) {
                event.preventDefault();
            }
        }
    );

});

    //// Список идентификаторов пользователей, уже имеющихся в списке получаетелей сообщения
    var selectedUsers = { };
    //// объект для ниспадающего списка возможных получателей
    var availaleUsersCount;

    var dropDownMenu = {
        Users: 0,
        SelectedUser : 0
    };
    
    
