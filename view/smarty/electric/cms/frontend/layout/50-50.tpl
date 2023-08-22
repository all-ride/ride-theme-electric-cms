{function name="layout_50_50" section=null widgets=null}
<div class="grid" id="section-{$region}-{$section}">
{$block = '1'}
    <div class="grid__12 grid--bp-med__6" id="block-{$section}-{$block}">
{if isset($widgets[$block])}
    {foreach $widgets[$block] as $widget}
        {$widget}
    {/foreach}
{/if}
    </div>
{$block = '2'}
    <div class="grid__12 grid--bp-med__6" id="block-{$section}-{$block}">
{if isset($widgets[$block])}
    {foreach $widgets[$block] as $widget}
        {$widget}
    {/foreach}
{/if}
    </div>
</div>
{/function}
