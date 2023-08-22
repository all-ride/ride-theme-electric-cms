{function name="layout_100_no_grid" section=null widgets=null}
<div id="section-{$region}-{$section}">
{$block = '1'}
    <div id="block-{$section}-{$block}">
{if isset($widgets[$block])}
    {foreach $widgets[$block] as $widget}
        {$widget}
    {/foreach}
{/if}
    </div>
</div>
{/function}
