function TopicList_SelectRow(row) {
    if (row == null)
        return;

    if (row.className.match(/forum-row-selected/))
        row.className = row.className.replace(/\s*forum-row-selected/i, '');
    else
        row.className += ' forum-row-selected';
}

function TopicList_SelectAll(table) {
    if (table == null)
        return;
    var inputs = table.getElementsByTagName("INPUT");
    if (!inputs)
        return;
    var status;
    var hasStatus = false;
    for (var i = 0; i < inputs.length; i++) {
        var input = inputs[i];
        if (input.type != "checkbox")
            continue;

        if (!hasStatus) {
            status = !input.checked;
            hasStatus = true;
        }

        if (input.checked != status)
            input.click();
    }
}

function SelectOperation_OKClick() {
    var ddl = document.getElementById('SelectOperation');
    if (ddl.value == '' || document.querySelector(".forum-row-selected")==null) {
        return false;
    }
    if (ddl.value == "Delete") {
        return window.confirm("Вы действительно хотите удалить отмеченные переписки?");
    }
    return true;
}