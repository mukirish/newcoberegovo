$(
    function () {
        //// предупреждающее окно при удалении
        $("#PMFolderListOk").click(
            function () {
                if ($('#PrivateMessagesFolderListtable input[type="checkbox"]:checked').length == 0)
                {
                    event.preventDefault();
                }
                else if ($("#SelectLisOperation").val() == 'Delete') {
                    window.confirm(this.getAttribute("data-confirm-message")) || event.preventDefault();
                }
            }
        );

        //// навешивание классов на строки при выборе
        $('#PrivateMessagesFolderListtable input[type="checkbox"]').click(
            function () {
                var row = $(this).closest('tr');
                if (this.checked) {
                    row.addClass("forum-row-selected");
                    if ($("#SelectLisOperation").val() == "Edit") {
                        row.addClass('pmfolderList-row-edit');
                    }
                } else {
                    row.removeClass("forum-row-selected");
                    row.removeClass("pmfolderList-row-edit");
                }
            }
        );

        //// навешивание стилей редактирования компанента при изменении значения селектора
        $("#SelectLisOperation").change(
            function () {
                var row = $('#PrivateMessagesFolderListtable input[type="checkbox"]:checked').closest('tr');
                this.value == "Edit" ? row.addClass('pmfolderList-row-edit') : row.removeClass("pmfolderList-row-edit");
            }
        );

        //// проверка названия папки сообщения при создании папки
        $("#bPMFLCreateFolder").click(
            function (event) {
                var value = $("#NewFolderName").val();
                if (!/\S/.test(value)) {
                    event.preventDefault();
                    var div = document.getElementById("PMFoldersList_Errors");
                    div.style.display = "block";
                }
            }
        );
    }
);