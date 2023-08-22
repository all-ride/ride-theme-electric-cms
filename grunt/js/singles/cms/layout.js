'use strict';

function initializeContent(baseUrl) {
    var $document = $(document);
    var $body = $('body');
    var $modalWidgetAdd = $('.modal-widget-add');
    var $buttonWidgetAdd = $('.widget-add-submit');
    var $buttonWidgetAddAndClose = $('.widget-add-submit-close');
    var $modalSectionAction = $('.modal-section-action');
    var $buttonSectionAction = $('.section-action-submit');
    var $blocks = $('.section .block');
    var $sections = $('.sections');
    var $widgets = $('.widget--compact');
    var $availabilityToggle = $('.js-toggle-available');
    var $controlsToHideInLocaleMode = [
        $('.section-delete'),
        $('.section__handle'),
        $('.widget__handle'),
        $('.widget-add'),
        $('.section-add')
    ];
    var actionsDisabled = false;
    var ANIMATION_SPEED = 'medium';

    // perform a widget add to the cms
    var widgetAdd = function() {
        var widget = $('input[name=widget]:checked').val();
        if (!widget) {
            alert('no widget selected');
            return;
        }

        var section = $('input[name=section]').val();
        var block = $('input[name=block]').val();
        var $block = $('.section[data-section=' + section + '] .block[data-block=' + block + ']', $sections);

        if ($block.length !== 1) {
            alert('no block found');
            return;
        }

        $buttonWidgetAdd.attr('disabled', 'disabled');
        $buttonWidgetAddAndClose.attr('disabled', 'disabled');

        var jqxhr = $.post(baseUrl + '/sections/' + section + '/block/' + block + '/widget/' + widget, function(html) {
            var $lockedWidget = $block.find('.widget--locked');
            var $section = $lockedWidget.before(html);

            initWidgetOrder();
            initSectionActions();

            $buttonWidgetAdd.removeAttr('disabled');
            $buttonWidgetAddAndClose.removeAttr('disabled');
        });

        rideApp.common.handleXHRCallback(jqxhr, 'Widget added', 'Could not add widget');
    };

    // perform the order update to the cms
    var updateOrder = function() {
        // generate overview of the widgets in their blocks and sections
        var order = {};
        $('.section').each(function() {
            var $section = $(this);
            var section = 'section' + $section.data('section');

            if (order[section] === undefined) {
                order[section] = {};
            }

            $('.block', $section).each(function() {
                var $block = $(this);
                var block = $block.data('block');


                var $widgets = $('.widget:not(.widget--locked)', $block);
                if ($widgets.length) {
                    order[section][block] = [];
                    $widgets.each(function() {
                        order[section][block].push($(this).data('widget'));
                    });
                } else {
                    order[section][block] = 0;
                }
            });
        });

        // post the order the cms
        var jqxhr = $.post(baseUrl + '/order', {order: order});
        rideApp.common.handleXHRCallback(jqxhr, 'Order updated', 'Could not update order');
    };

    // initialize the sortable for the widgets
    var initWidgetOrder = function () {
        $blocks = $('.section .block');

        $blocks.sortable({
            handle: '.handle',
            items: '.widget:not(.widget--locked)',
            connectWith: $blocks,
            update: function (event, ui) {            // don't update twice
                if (this !== ui.item.parent()[0]) {
                    return;
                }
                updateOrder();
            },
            over: function (event, ui) {
                ui.placeholder.insertBefore($(this).children('.widget.widget--locked:first'));
            },
            activate: function (event, ui) {
                $body.addClass('is-sorting');
            },
            deactivate: function (event, ui) {
                $body.removeClass('is-sorting');
            }
        });
    };

    var initSectionOrder = function () {
        $sections.sortable({
            handle: '.panel-heading .handle',
            items: '> .section',
            update: function(event, ui) {
                updateOrder();
            },
            activate: function (event, ui) {
                $body.addClass('is-sorting');
            },
            deactivate: function (event, ui) {
                $body.removeClass('is-sorting');
            }
        });
    };

    //  Initialize section actions (style, properties) to open in modal
    var initSectionActions = function () {
      $('.section:not(.is-initialized)').addClass('is-initialized').find('.section__actions .action').on('click', function (e) {
        e.preventDefault();
        var $action = $(this);
        var href = $action.attr('href');
        if (href[0] === '#') {
            return;
        }
        $modalSectionAction.find('.modal-body').load(href + ' form', function () {
            $modalSectionAction.find('.modal-title').text($action.attr('title'));
            $modalSectionAction.find('.form__actions').hide();
            $modalSectionAction.modal('show');
        });
      });
    };

    // === locale mode functions ===
    var disableActions = function() {
        $controlsToHideInLocaleMode.forEach(function(val){
            val.hide();
        });
        actionsDisabled = true;
    };

    var enableActions = function() {
        $controlsToHideInLocaleMode.forEach(function(val){
            val.show();
        });
        actionsDisabled = false;
    };

    var toggleAvailableWidgets = function($el) {
        // hide the widgets that are not available in current locale
        var $widgetsToToggle = $('.widget.is-locked');

        if ($el.is(':checked')) {
            $widgetsToToggle.stop().hide(ANIMATION_SPEED);
            disableActions();
        } else {
            $widgetsToToggle.stop().show(ANIMATION_SPEED);
            initSectionOrder();
            initWidgetOrder();
            enableActions();
        }
    };

    var toggleAvailableSections = function($el) {
        // hide the sections that have no available widgets for the current locale
        $('div.section').each(function(){
            var $widgets = $(this).find('div.widget');
            var $unavailableWidgets = $(this).find('div.js-unavailable');
            if ($widgets.length > 0 && $widgets.length === $unavailableWidgets.length) {
                if ($el.is(':checked')){
                    $(this).stop().fadeOut(ANIMATION_SPEED);
                } else {
                    $(this).stop().fadeIn(ANIMATION_SPEED);
                }
            }
        });
    }

    // === watchers ====

    // add a new section
    $document.on('click', '.section-add', function(e) {
        if (actionsDisabled) { return; }

        e.preventDefault();

        var prepend = $(this).attr('data-method') == 'prepend';
        var $section;
        var jqxhr = $.post(baseUrl + '/sections' + (prepend ? '?prepend=1' : ''), function(html) {
            if (prepend) {
                $section = $sections.prepend(html);
            } else {
                $section = $sections.append(html);
            }
            
            $blocks = $('.section .block');

            initWidgetOrder();
            initSectionActions();
            $('.section:last', $sections).scrollTop();
        });

        rideApp.common.handleXHRCallback(jqxhr, 'Section added', 'Could not add section');
    });

    // delete a section
    $document.on('click', '.section-delete', function(e) {
        e.preventDefault();

        if (actionsDisabled) { return; }

        var $this = $(this);
        if (!confirm($this.data('confirm'))) {
            return;
        }

        var $section = $this.closest('.section');
        var jqxhr = $.ajax({
            url: baseUrl + '/sections/' + $section.data('section'),
            type: 'DELETE',
            success: function(result) {
                $section.remove();
                initWidgetOrder();
            }
        });

        rideApp.common.handleXHRCallback(jqxhr, 'Section removed', 'Could not remove section');
    });

    // change section layout
    $document.on('click', '.section__layouts > a', function(e) {
        e.preventDefault();

        if (actionsDisabled) { return; }

        var $this = $(this);
        var $section = $this.closest('.section');

        var jqxhr = $.post(baseUrl + '/sections/' + $section.data('section') + '/layout/' +  $this.data('layout'), function(html) {
            $section = $section.replaceWith(html);
            initWidgetOrder();
            initSectionActions();
        });
        rideApp.common.handleXHRCallback(jqxhr, 'Section layout changed', 'Could not change section layout');
    });

    // add widget through link
    $document.on('click', '.widget-add', function(event) {
        if (actionsDisabled) { return; }

        var $button = $(this);
        var $block = $button.parents('.block');
        var $section = $button.parents('.section');

        if ($block.length == 0) {
            $block = $('.block', $section).first();
        }

        $('input[name=section]').val($section.data('section'));
        $('input[name=block]').val($block.data('block'));

        $modalWidgetAdd.modal('show');
    });

    // widget add button
    $buttonWidgetAdd.on('click', function(e) {
        e.preventDefault();

        widgetAdd();
    });

    // widget add and close button
    $buttonWidgetAddAndClose.on('click', function(e) {
        e.preventDefault();

        widgetAdd();

        $modalWidgetAdd.modal('hide');
    });

    // delete a widget
    $document.on('click', '.widget-delete', function(e) {
        e.preventDefault();

        if (actionsDisabled) { return; }

        var $this = $(this);
        if (!confirm($this.data('confirm'))) {
            return;
        }

        var $section = $this.closest('.section');
        var $block = $this.closest('.block');
        var $widget = $this.closest('.widget');

        var jqxhr = $.ajax({
            url: baseUrl + '/sections/' + $section.data('section') + '/block/' + $block.data('block') + '/widget/' + $widget.data('widget'),
            type: 'DELETE',
            success: function(result) {
                $widget.remove();
            }
        });

        rideApp.common.handleXHRCallback(jqxhr, 'Widget removed', 'Could not remove widget');
    });

    // watch the locale mode checkbox for changes when it's available
    if ($availabilityToggle.length) {
        $availabilityToggle.on('change', function(){
            toggleAvailableSections($(this));
            toggleAvailableWidgets($(this));
        });
    }

    // filter widgets
    $('#filter-widgets').on('keyup', function(e) {
      if(e.which === 13) {
        return false;
      }
      var value = $(this).val();
      $widgets.parent().show();
      var widgets = $widgets.filter(function() {
        var string = $(this).text(),
            regexpres = new RegExp(value, 'i'),
            result = string.search(regexpres);

        return result < 0;
      }).parent().hide();
    });

    $buttonSectionAction.on('click', function (e) {
      e.preventDefault();
      var $form = $modalSectionAction.find('form');
      var jqxhr = $.post($form.attr('action'), $form.serialize(), function () {
        $modalSectionAction.modal('hide');
      });
      rideApp.common.handleXHRCallback(jqxhr, 'Updated section properties', 'Could not update section properties');
    });


    // === init ====
    initSectionOrder();
    initWidgetOrder();
    initSectionActions();

}
