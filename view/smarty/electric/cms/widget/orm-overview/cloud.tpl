{* widget: orm.overview action: index; translation: template.orm.overview.cloud *}

<div class="widget widget-content-overview widget-content-overview-cloud {$app.cms.properties->getWidgetProperty('style.container')}" id="widget-{$app.cms.widget}">
{if $title}
    <h2 class="toc {$app.cms.properties->getWidgetProperty('style.title')}">{$title}</h2>
{/if}

{if $result}
    {foreach from=$result item="content"}
        {if $content->url}<a href="{$content->url}"><span class="{$content->data->weightClass}">{$content->title}</span></a>{else}<span class="{$content->data->weightClass}" data-weight="{$content->data->weight}">{$content->title}</span>{/if}
    {/foreach}

    {if $moreUrl}
    <p><a href="{$moreUrl}" class="more">{$moreLabel}</a></p>
    {/if}
{else}
    <p>{$emptyResultMessage|text}</p>
{/if}
</div>
