function handleTextReuse(isChecked) {
    var $alert = $('.notice--warning');
    if (isChecked) {
        $alert.addClass('superhidden');
    } else {
        $alert.removeClass('superhidden');
    }
}

$('#form-text-existing-new').change(function() {
    handleTextReuse(this.checked);
    return false;
});
handleTextReuse($('#form-text-existing-new').is(':checked'));

var $existing = $('.form__item--existing');
$existing
    .addClass('superhidden')
    .on('change', '.form__select', function() {
        var $this = $(this);

        var locale = $existing.data('locale');
        var url = $existing.data('url-text');
        url = url.replace('%25id%25', $this.val());

        $.ajax({
            url: url,
            type: "GET",
            beforeSend: function(xhr) { xhr.setRequestHeader('Accept-Language', locale);},
            success: function(data) {
                var preview = '';
                if (data.title) {
                    preview += '<h3>' + data.title + '</h3>';
                }
                if (data.subtitle) {
                    preview += '<h4>' + data.subtitle + '</h4>';
                }
                if (data.body) {
                    preview += data.body;
                }

                $('.preview', $existing).html(preview);
            }
        });
    });


$('#btn-text-reuse').click(function(e) {
    e.preventDefault();
    $('.tab').addClass('superhidden');
    $('.form__item--existing').removeClass('superhidden').data('id', $('.form__item--existing select').val());

    $('#btn-cancel').click(function() {
        $('.form__item--existing select').val($('.form__item--existing').data('id'));

        $('.tab').removeClass('superhidden');
        $('.form__item--existing').addClass('superhidden');

        $('#btn-cancel').unbind();
        $('#btn-submit').unbind();

        return false;
    });

    $('#btn-submit').click(function() {
        var oldTextId = $('.form__item--existing').data('id');
        var textId = $('.form__item--existing select').val();
        if (textId && textId != oldTextId) {
            var form = $('#form-text');

            var url = form.attr('action') + '?text=' + textId;
            if ($('#form-text-existing-new').is(':checked')) {
                url += '&new=1';
            }

            form.attr('action', url);
        } else {
            $('#btn-cancel').trigger('click');

            return false;
        }
    });
});
