{* widget: title; action: index; translation: widget.title *}

<div class="widget widget-title {$app.cms.properties->getWidgetProperty('style.container')}" id="widget-{$app.cms.widget}">
{if !isset($heading)}
    {$heading = 1}
{/if}

{if !isset($title) || $title === null}
    {$title = $app.cms.context.title.node}
{/if}

{if isset($anchor) && $anchor}
    <a name="{$anchor}"></a>
{/if}

    <h{$heading} class="{$app.cms.properties->getWidgetProperty('style.title')}">{$title|text}</h{$heading}>
</div>
