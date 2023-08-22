<div class="widget widget-mailchimp-subscribe {$app.cms.properties->getWidgetProperty('style.container')}" id="widget-{$app.cms.widget}">
    {if $title}
        <h3 class="{$app.cms.properties->getWidgetProperty('style.title')}">{$title}</h3>
    {/if}

    {include file="base/form.prototype"}
    <form id="{$form->getId()}" class="form" action="{$app.url.request}" method="post" role="form">
        {*{call formWidget form=$form row="email"}*}
        {call formRows form=$form}
        <button type="submit" class="btn" name="subscribe">{translate key="button.subscribe"}</button>
    </form>
</div>
