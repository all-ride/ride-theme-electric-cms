{* widget: assets action: index; translation: widget.assets *}

{if $assets}
<div class="widget widget-assets clearfix {$app.cms.properties->getWidgetProperty('style.container')}" id="widget-{$app.cms.widget}">
    {if $title}
        <h2 class="toc {$app.cms.properties->getWidgetProperty('style.title')}">{$title}</h2>
    {/if}
    <div class="grid grid--bp-med-6-col">
    {foreach $assets as $asset}
        <div class="grid__item">
            <a href="{url id="assets.value" parameters=["asset" => $asset->getId()]}" title="{$asset->getName()|escape}">
        {if $asset->getThumbnail()}
                <img src="{image src=$asset->getThumbnail() width=200 height=200 transformation="crop"}" class="img-responsive" />
        {/if}
            </a>
        </div>
    {/foreach}
    </div>
</div>
{/if}
