{* widget: orm.overview action: index; translation: template.orm.overview.alphabet *}

<div class="widget widget-content-overview widget-content-overview-alphabet {$app.cms.properties->getWidgetProperty('style.container')}" id="widget-{$app.cms.widget}">
{if $title}
    <h2 class="toc {$app.cms.properties->getWidgetProperty('style.title')}">{$title}</h2>
{/if}

{if $result}
    {$chars = [
        'A' => false,
        'B' => false,
        'C' => false,
        'D' => false,
        'E' => false,
        'F' => false,
        'G' => false,
        'H' => false,
        'I' => false,
        'J' => false,
        'K' => false,
        'L' => false,
        'M' => false,
        'N' => false,
        'O' => false,
        'P' => false,
        'Q' => false,
        'R' => false,
        'S' => false,
        'T' => false,
        'U' => false,
        'V' => false,
        'W' => false,
        'X' => false,
        'Y' => false,
        'Z' => false,
        '0-9' => false,
        '%' => false
    ]}
    {$char = null}
    {foreach $result as $content}
        {if $content->title[0]|upper != $char}
            {$char = $content->title[0]|upper}
            {if is_numeric($char)}
                {$char = "0-9"}
            {/if}

            {if isset($chars[$char])}
                {$chars[$char] = true}
            {else}
                {$chars['%'] = true}
            {/if}
        {/if}
    {/foreach}

    <ul class="tabs abc">
    {foreach $chars as $char => $charState}
        {if $charState}
            <li class="tabs__tab"><a href="#{$char}">{$char}</a></li>
        {else}
            <li class="tabs__tab"><a href="#" class="disabled text-muted">{$char}</a></li>
        {/if}
    {/foreach}
    </ul>

    {$half = count($result) / 2}
    {$hasDivided = false}

    <div class="row">
        <div class="grid--bp-med__6">
    {$numeric = []}
    {$other = []}
    {$rendered = 0}

    {$char = null}
    {foreach $result as $content}
        {if $content->title[0]|upper != $char}
            {$oldChar = $char}
            {$char = $content->title[0]|upper}
            {if is_numeric($char)}
                {$numeric[] = $content}
                {$char = $oldChar}

                {continue}
            {elseif !isset($chars[$char]) || $char == '%'}
                {$other[] = $content}
                {$char = $oldChar}

                {continue}
            {/if}

            {if $oldChar}
            </ul>
            {/if}
            {if !$hasDivided && $rendered > $half}
        </div>
        <div class="grid--bp-med__6">
                {$hasDivided = true}
            {/if}

            <a name="{$char}"></a>
            <h4>{$char}</h4>
            <ul class="result">
        {/if}

                <li>{if $content->url}<a href="{$content->url}">{$content->title}</a>{else}{$content->title}{/if}</li>
        {$rendered = $rendered + 1}
    {/foreach}
            </ul>

    {if $numeric}
            <a name="0-9"></a>
            <h4>0-9</h4>
            <ul class="result">
        {foreach $numeric as $content}
                <li>{if $content->url}<a href="{$content->url}">{$content->title}</a>{else}{$content->title}{/if}</li>
        {/foreach}
            </ul>
    {/if}

    {if $other}
            <a name="%"></a>
            <h4>%</h4>
            <ul class="result">
        {foreach $other as $content}
                <li>{if $content->url}<a href="{$content->url}">{$content->title}</a>{else}{$content->title}{/if}</li>
        {/foreach}
            </ul>
    {/if}

        </div>
    </div>

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
