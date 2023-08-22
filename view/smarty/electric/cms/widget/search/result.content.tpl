<div class="widget widget-search-form widget-search-form-content {$app.cms.properties->getWidgetProperty('style.container')}" id="widget-{$app.cms.widget}">
{if $result.total == 0}
    {if $query}
        <p>{translate key="label.search.query.none" query=$query}</p>
    {else}
        <p>{translate key="label.search.query.provide"}</p>
    {/if}
{else}
    {if $result.total == 1}
        <p>{translate key="label.search.query.result" query=$query}</p>
    {else}
        <p>{translate key="label.search.query.results" query=$query total=$result.total}</p>
    {/if}

    {foreach $result.types as $contentType => $contentResult}
        {assign var="entries" value=$contentResult->getEntries()}

        {if $entries}
        <div class="search-type">
            <h3>{$contentType}</h3>
            {foreach $entries as $content}
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

            {if $urlMore}
                {assign var="numResults" value=$entries|@count}
                {assign var="totalNumResults" value=$contentResult->getTotal()}
                {assign var="remainingResults" value=$totalNumResults-$numResults}
                {if $remainingResults}
                <div class="more">
                    <a href="{$urlMore}&amp;type={$contentType}">{translate key="button.search.results.more" total=$remainingResults}</a>
                </div>
                {/if}
            {/if}
        </div>
        {/if}
    {/foreach}
{/if}

</div>
