{extends file="base/index"}

{if isset($app.cms.context)}
    {block name="head_title"}{$app.cms.context.title.node} - {$app.cms.context.title.site}{/block}
{/if}

{block name="head" append}
{if isset($app.cms.context.canonical)}
    <link rel="canonical" href="{$app.cms.context.canonical}"/>
{/if}

{if isset($app.cms.node)}
    {$meta = $app.cms.node->getMeta($app.locale)}
    {if $meta}
        {foreach $meta as $metaName => $metaValue}
    <meta property="{$metaName}" content="{$metaValue}" />
        {/foreach}
    {/if}
{/if}
{/block}

{block name="styles" append}
    <link href="{$app.url.base}/electric/css/front.min.css" rel="stylesheet" media="screen">
{/block}

{block name="container"}

{foreach $layouts as $layout}
    {include file=$layout->getFrontendResource() inline}
{/foreach}

{function name="region" region=null class=null}
    {if isset($widgets.$region)}
    <div class="{$class}">
        {foreach $regions.$region as $section => $layout}
            {if isset($widgets.$region.$section)}
                {$functionName = "layout-`$layout`"|replace:"-":"_"}
                {$style = $app.cms.node->getSectionStyle($region, $section)}
                {$title = $app.cms.node->getSectionTitle($region, $section, $app.locale)}
                {$isFullWidth = $app.cms.node->isSectionFullWidth($region, $section)}
                <div class="section {$style}">
                    {if $isFullWidth}
                        {if $title}
                            <div class="section__title">{$title}</div>
                        {/if}
                        {call $functionName section=$section widgets=$widgets.$region.$section style=$style}
                    {else}
                        <div class="container">
                            {if $title}
                                <div class="section__title">{$title}</div>
                            {/if}
                            {call $functionName section=$section widgets=$widgets.$region.$section style=$style}
                        </div>
                    {/if}
                </div>
            {/if}
        {/foreach}
    </div>
    {/if}
{/function}

<div class="container">
    {call region region="header" class="row region region-header"}

    <div class="grid">
        {call region region="menu" class="grid--bp-med__3 region region-menu"}

        <div class="grid--bp-med__9 region region-layout">
            {if isset($app.messages)}
                {$_messageTypes = ["error" => "danger", "warning" => "warning", "success" => "success", "information" => "info"]}
                {foreach $_messageTypes as $_messageType => $_messageClass}
                    {$_messages = $app.messages->getByType($_messageType)}
                    {if $_messages}
                        <div class="alert alert-{$_messageClass}">
                        {if $_messages|count == 1}
                            {$_message = $_messages|array_pop}
                            <p>{$_message->getMessage()}</p>
                        {else}
                            <ul>
                            {foreach $_messages as $_message}
                                <li>{$_message->getMessage()}</li>
                            {/foreach}
                            </ul>
                        {/if}
                        </div>
                    {/if}
                {/foreach}
            {/if}

            {call region region="content"}
        </div>
    </div>

    {call region region="footer" class="row region region-footer"}
</div>
{/block}
