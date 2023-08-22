{* widget: orm.overview action: index; translation: template.orm.overview.block *}

<div class="widget widget-content-overview widget-content-overview-block {$app.cms.properties->getWidgetProperty('style.container')}" id="widget-{$app.cms.widget}">
{if $title}
    <h2 class="toc {$app.cms.properties->getWidgetProperty('style.title')}">{$title}</h2>
{/if}

{if $filters}
    {include 'cms/helper/orm.filter.form'}
{/if}

{if $result}
    {foreach from=$result item="content"}
    <div class="content clearfix {cycle values="odd,even"}">
        {if $content->image}
        <div class="image">
            {if $content->url}
            <a href="{$content->url}">
                <img src="{image src=$content->image width=125 height=125 transformation="resize"}" />
            </a>
            {else}
            <img src="{image src=$content->image width=125 height=125 transformation="resize"}" />
            {/if}
        </div>
        {/if}
        <h3>{if $content->url}<a href="{$content->url}">{$content->title}</a>{else}{$content->title}{/if}</h3>
        <div class="teaser">{$content->teaser}</div>
    </div>
    {/foreach}

    {if $pagination}
        {pagination href=$pagination->getHref() pages=$pagination->getPages() page=$pagination->getPage()}
    {/if}

    {if $moreUrl}
    <p><a href="{$moreUrl}" class="more">{$moreLabel}</a></p>
    {/if}
{else}
    <p>{$emptyResultMessage|text}</p>
{/if}
</div>
