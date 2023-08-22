$(function() {
    $("#form-search-result-engine").on('change', function() {
        $(this).parents("form").submit();
    });
});
