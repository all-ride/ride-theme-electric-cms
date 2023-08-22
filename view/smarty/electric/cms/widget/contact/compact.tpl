{* widget: contact action: index; translation: widget.contact *}

<div class="widget widget-contact {$app.cms.properties->getWidgetProperty('style.container')}" id="widget-{$app.cms.widget}">
    {include file="base/form.prototype"}

    <form action="{$app.url.request}" method="post" role="form">
        <div class="form__item">
            {call formWidget form=$form row="name"}
            {call formWidgetErrors form=$form row="name"}
        </div>
        <div class="form__item">
            {call formWidget form=$form row="email"}
            {call formWidgetErrors form=$form row="email"}
        </div>
        <div class="form__item">
            {call formWidget form=$form row="message"}
            {call formWidgetErrors form=$form row="message"}
        </div>

        {call formRows form=$form}

        <div class="form__actions">
            <button type="submit" class="btn btn--default">{translate key="button.submit"}</button>
        </div>
    </form>
</div>
