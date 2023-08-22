{function name="layout_25_75" section=null widgets=null}
<div class="grid" id="section-{$region}-{$section}">
{$block = '1'}
    <div class="grid__12 grid--bp-med__3" id="block-{$section}-{$block}">
{if isset($widgets[$block])}
    {foreach $widgets[$block] as $widget}
        {$widget}
    {/foreach}
{/if}
    </div>
{$block = '2'}
    <div class="grid__12 grid--bp-med__9" id="block-{$section}-{$block}">
{if isset($widgets[$block])}
    {foreach $widgets[$block] as $widget}
        {$widget}
    {/foreach}
{/if}
    </div>
</div>
{/function}
