$(function() {
    $('.widget-text-toc').each(function() {
        var divIndex = $(this);
        var index = $('<ul></ul>');
        var subindex = null;

        $('.widget h2.toc:not(.toc-ignore), .widget h3.toc:not(.toc-ignore)', divIndex.parents('.region')).each(function() {
            var title = $(this);
            var label = title.data('label-menu');

            if (label === undefined) {
              label = title.text().trim();
            }

            var anchor = label.toLowerCase().replace(/ /g, '-');
            title.prepend($('<a name="' + anchor + '"></a>'));

            if (title.context.localName == 'h3') {
                if (subindex === null) {
                    subindex = $('<ul></ul>');
                }

                subindex.append($('<li><a href="#' + anchor + '">' + label + '</a></li>'));
            } else {
                if (subindex) {
                    $('li', index).last().append(subindex);

                    subindex = null;
                }

                index.append($('<li><a href="#' + anchor + '">' + label + '</a></li>'));
            }
        });

        if (subindex) {
            $('li', index).last().append(subindex);
        }

        divIndex.append(index);
    });
});
