{function name="layout_33_33_33" site=null node=null section=null widgets=null inheritedWidgets=null actions=null}
<div class="grid">
{$block = '1'}
    <div class="grid--bp-med__4 block droppable widgets" id="block-{$section}-{$block}" data-section="{$section}" data-block="{$block}">
{if isset($widgets[$block])}
    {foreach $widgets[$block] as $widgetId => $widget}
        {call widgetPanel site=$site node=$node widget=$widget widgetId=$widgetId inheritedWidgets=$inheritedWidgets[$block] actions=$actions}
    {/foreach}
{/if}
        <button class="widget widget--locked widget--button widget-add"><i class="icon icon--plus"></i>{translate key="button.widget.add"}</button>
    </div>

{$block = '2'}
    <div class="grid--bp-med__4 block droppable widgets" id="block-{$section}-{$block}" data-section="{$section}" data-block="{$block}">
{if isset($widgets[$block])}
    {foreach $widgets[$block] as $widgetId => $widget}
        {call widgetPanel site=$site node=$node widget=$widget widgetId=$widgetId inheritedWidgets=$inheritedWidgets[$block] actions=$actions}
    {/foreach}
{/if}
        <button class="widget widget--locked widget--button widget-add"><i class="icon icon--plus"></i>{translate key="button.widget.add"}</button>
    </div>

{$block = '3'}
    <div class="grid--bp-med__4 block droppable widgets" id="block-{$section}-{$block}" data-section="{$section}" data-block="{$block}">
{if isset($widgets[$block])}
    {foreach $widgets[$block] as $widgetId => $widget}
        {call widgetPanel site=$site node=$node widget=$widget widgetId=$widgetId inheritedWidgets=$inheritedWidgets[$block] actions=$actions}
    {/foreach}
{/if}
        <button class="widget widget--locked widget--button widget-add"><i class="icon icon--plus"></i>{translate key="button.widget.add"}</button>
    </div>
</div>
{/function}
