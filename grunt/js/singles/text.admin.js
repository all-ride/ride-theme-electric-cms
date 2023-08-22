$(function() {
    var $cels = $('.text-usage');
    $cels.each(function(){
        var $cel = $(this),
            celOffest = $cel.offset(),
            $elements = $cel.find('li');

        if($elements.length > 3) {
          var $toggleElements = $elements.slice(3).hide(),
              defaultLinkText = translations.more + ' »',
              altLinkText = '« ' + translations.less,
              $link = $('<a href="#" style="margin-left: 40px" class="btn btn--default btn-xs">' + defaultLinkText + '</a>');

          $link
            .appendTo($cel)
            .on('click', function(e) {
              e.preventDefault();
              if($link.data('is-open')) {
                $link
                  .data('is-open', false)
                  .text(defaultLinkText);
                $('html,body').animate({
                  scrollTop: celOffest.top
                }, 200);
              } else {
                $link
                  .data('is-open', true)
                  .text(altLinkText);
              }
              $toggleElements.toggle();
            });
        }
    });
});
