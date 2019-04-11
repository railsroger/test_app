// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require spree/backend/jquery-ui-1.10.4.custom.min
//= require spree/backend
//= require spree/backend/ace/ace
//= require spree/backend/redactor
//= require spree/backend/galleryPlugin
//= require_tree .

$(function() {
    var btns = document.querySelectorAll('.copy-url');

    for (var i = 0; i < btns.length; i++) {
        btns[i].addEventListener('mouseleave', clearTooltip);
        btns[i].addEventListener('blur', clearTooltip);
    }
    function clearTooltip(e) {
        e.currentTarget.classList.remove('tooltipped', 'tooltipped-s');
        e.currentTarget.removeAttribute('aria-label');
    }
    function showTooltip(elem, msg) {
        elem.classList.add('btn', 'tooltipped', 'tooltipped-s');
        elem.setAttribute('aria-label', msg);
    }
    new ClipboardJS('.copy-url');

    var clipboardButtons = new ClipboardJS('.btn');

    clipboardButtons.on('success', function(e) {
        showTooltip(e.trigger, 'Copied!');
    });

    $('textarea[data-editor]').each(function() {
        var textarea = $(this);
        var mode = textarea.data('editor');
        var editDiv = $('<div>', {
            // position: 'absolute',
            // width: textarea.width(),
            // height: textarea.height(),
            'class': textarea.attr('class')
        }).insertBefore(textarea);
        textarea.css('display', 'none');
        var editor = ace.edit(editDiv[0]);
        editor.renderer.setShowGutter(textarea.data('gutter'));
        editor.getSession().setValue(textarea.val());
        editor.getSession().setMode("ace/mode/" + mode);
        textarea.closest('form').submit(function() {
            textarea.val(editor.getSession().getValue());
        });
        editor.setTheme("ace/theme/chrome");
        editor.setAutoScrollEditorIntoView(true);
        editor.setOption("minLines", 10);
        editor.setOption("maxLines", 100);
    });

    $(document).on('change', '#content_block_kind', function() {
        var kind = $(this).val();
        $('[data-kinds]').hide();
        $('[data-kinds] .form-control').attr('disabled', 'disabled');
        $('[data-kinds="' + kind + '"]').show();
        $('[data-kinds="' + kind + '"] .form-control').attr('disabled', false);
    });
    $('#content_block_kind').trigger('change');
});
