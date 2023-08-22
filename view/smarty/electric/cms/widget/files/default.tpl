{* widget: files action: index; translation: widget.files *}

<div class="widget widget-files {$app.cms.properties->getWidgetProperty('style.container')}" id="widget-{$app.cms.widget}">
{if $title}
    <h2 class="toc {$app.cms.properties->getWidgetProperty('style.title')}">{$title}</h2>
{/if}
    <ul class="{$app.cms.properties->getWidgetProperty('style.list')}">
    {foreach $files as $index => $file}
        <li><a href="{$file.url}">{$file.label}</a></li>
    {/foreach}
    </ul>
</div>
