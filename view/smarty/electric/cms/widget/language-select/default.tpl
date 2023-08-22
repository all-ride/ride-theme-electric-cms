{* widget: language.select; action: index; translation: widget.language.select *}

<div class="widget widget-language-select {$app.cms.properties->getWidgetProperty('style.container')}" id="widget-{$app.cms.widget}">
    <ul class="locales {$app.cms.properties->getWidgetProperty('style.menu')}">
    {foreach $locales as $code => $data}
        {$locale = $data.locale}
        <li{if $code == $app.locale} class="active"{/if}><a href="{$data.url}">{$locale->getName()}</a></li>
    {/foreach}
    </ul>
</div>
