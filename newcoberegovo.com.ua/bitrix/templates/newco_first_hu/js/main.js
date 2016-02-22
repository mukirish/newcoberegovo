$(document).ready(function () {
        var blocks = $('.lang > li > ul');

        blocks
            .hide()
            .parent().click(function () {
                $(this).find('ul').toggle(20);
            });


    var blocks2 = $('.v_ul li #inline_content2');

    blocks2
        .hide()
        .parent().click(function () {
            $(this).find('#inline_content2').toggle(20);
        });


    $(".inline").colorbox({inline:true, width:"800px"});







});