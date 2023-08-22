{* widget: contact action: index; translation: widget.contact *}

<div class="widget widget-contact {$app.cms.properties->getWidgetProperty('style.container')}" id="widget-{$app.cms.widget}">
    {include file="base/form.prototype"}

    <form action="{$app.url.request}" method="post" role="form">
        {call formRows form=$form}

        <div class="form__actions">
            <button type="submit" class="btn">{translate key="button.submit"}</button>
        </div>
    </form>
</div>
