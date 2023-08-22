{function name="layout_25_25_25_25" section=null widgets=null}
<div class="grid">
{$block = '1'}
    <div class="grid__12 grid--bp-sml__6 grid--bp-med__3" id="block-{$section}-{$block}">
{if isset($widgets[$block])}
    {foreach $widgets[$block] as $widget}
        {$widget}
    {/foreach}
{/if}
    </div>
{$block = '2'}
    <div class="grid__12 grid--bp-sml__6 grid--bp-med__3" id="block-{$section}-{$block}">
{if isset($widgets[$block])}
    {foreach $widgets[$block] as $widget}
        {$widget}
    {/foreach}
{/if}
    </div>
{$block = '3'}
    <div class="grid__12 grid--bp-med__3" id="block-{$section}-{$block}">
{if isset($widgets[$block])}
    {foreach $widgets[$block] as $widget}
        {$widget}
    {/foreach}
{/if}
    </div>
    {$block = '4'}
        <div class="grid__12 grid--bp-med__3" id="block-{$section}-{$block}">
    {if isset($widgets[$block])}
        {foreach $widgets[$block] as $widget}
            {$widget}
        {/foreach}
    {/if}
        </div>
</div>
{/function}
