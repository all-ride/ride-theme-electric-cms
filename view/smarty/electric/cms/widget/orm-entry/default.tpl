{* widget: orm.entry; action: index; translation: widget.orm.entry.default *}

<div class="widget widget-content-detail {$app.cms.properties->getWidgetProperty('style.container')}" id="widget-{$app.cms.widget}">
    <div class="content clearfix">
        {if $content->image}
        <div class="image">
            <img src="{image src=$content->image width=125 height=125 transformation="resize"}" />
        </div>
        {/if}
        {if !$properties->getTitle()}
            <h2 class="{$app.cms.properties->getWidgetProperty('style.title')}">{$content->title}</h2>
        {/if}
        <div class="teaser">{$content->teaser}</div>
    </div>
</div>
