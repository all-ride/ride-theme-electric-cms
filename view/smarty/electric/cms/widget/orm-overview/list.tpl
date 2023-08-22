{* widget: orm.overview action: index; translation: template.orm.overview.list *}

<div class="widget widget-content-overview widget-content-overview-list {$app.cms.properties->getWidgetProperty('style.container')}" id="widget-{$app.cms.widget}">
{if $title}
    <h2 class="toc {$app.cms.properties->getWidgetProperty('style.title')}">{$title}</h2>
{/if}

{if $filters}
    {include 'cms/helper/orm.filters.form'}
{/if}

{if $result}
    <ul>
    {foreach from=$result item="content"}
        <li>{if $content->url}<a href="{$content->url}">{$content->title}</a>{else}{$content->title}{/if}</li>
    {/foreach}
    </ul>

    {if $pagination}
        {if $pagination->getPages() >= $pagination->getPage() && $pagination->getPages() > 1}
            <div class="pagination">
                {pagination href=$pagination->getHref() pages=$pagination->getPages() page=$pagination->getPage()}
            </div>
        {/if}
    {/if}

    {if $moreUrl}
    <p><a href="{$moreUrl}" class="more">{$moreLabel}</a></p>
    {/if}
{else}
    <p>{$emptyResultMessage|text}</p>
{/if}
</div>
