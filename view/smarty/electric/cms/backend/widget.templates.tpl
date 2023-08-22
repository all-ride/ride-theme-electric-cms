{extends file="cms/backend/index"}

{block name="head_title" prepend}{translate key="title.widget.templates" widget=$widgetName} - {$node->getName($locale)} - {/block}

{block name="taskbar_panels" append}
    {if !$site->isAutoPublish()}
        {include file="cms/backend/taskbar"}

        {url id="cms.node.content.widget.templates" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => "%revision%", "node" => $node->getId(), "region" => $region, "widget" => $widgetId] var="url"}
        {call taskbarPanelPublish url=$url revision=$node->getRevision() revisions=$site->getRevisions()}
    {/if}

    {url id="cms.node.content.widget.templates" parameters=["locale" => "%locale%", "site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId(), "region" => $region, "widget" => $widgetId] var="url"}
    {call taskbarPanelLocales url=$url locale=$locale locales=$locales}
{/block}

{block name="content_title" append}
    <div class="page-header">
        <h1>{$node->getName($locale)} <small>{translate key="title.widget.templates" widget=$widgetName}</small></h1>
    </div>
{/block}

{block name="content_body" append}
    {include file="base/form.prototype"}

<form class="form-horizontal" action="{$app.url.request}" method="POST" role="form">
    <div class="form__group">
    <div class="tabbable">
        <ul class="tabs">
        {foreach $templates as $file => $content}
            <li class="tabs__tab {if $content@first} active{/if}"><a href="#{$file|replace:".":"-"}" data-toggle="tab">{$file}</a></li>
        {/foreach}
        </ul>

        <div class="tabs__content">
        {foreach $templates as $file => $content}
            <div id="{$file|replace:".":"-"}" class="tabs__pane clearfix{if $content@first} active{/if}">
                <br />
                {call formWidget form=$form row="content" part=$file}
                <br />

                {call formRow form=$form row="path" part=$file}
            </div>
        {/foreach}
        </div>

        <div class="form__group">
            <div class="col-lg-offset-2 col-lg-10">
                <button type="submit" class="btn btn--default">{translate key="button.save"}</button>
                {if $referer}
                    <a href="{$referer}" class="btn">{translate key="button.cancel"}</a>
				{else}
                    <a class="btn btn--link" href="{url id="cms.node.content" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId(), "region" => $region]}">{translate key="button.cancel"}</a>
                {/if}
            </div>
        </div>
    </div>
</form>

{/block}
