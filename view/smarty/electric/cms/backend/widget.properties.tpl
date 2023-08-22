{extends file="cms/backend/index"}

{block name="head_title" prepend}{translate key="title.widget.properties" widget=$widgetName} - {$node->getName($locale)} - {/block}

{block name="taskbar_panels" append}
    {if !$site->isAutoPublish()}
        {include file="cms/backend/taskbar"}

        {url id="cms.node.content.widget.properties" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => "%revision%", "node" => $node->getId(), "region" => $region, "section" => $section, "block" => $block, "widget" => $widgetId] var="url"}
        {call taskbarPanelPublish url=$url revision=$node->getRevision() revisions=$site->getRevisions()}
    {/if}

    {url id="cms.node.content.widget.properties" parameters=["locale" => "%locale%", "site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId(), "region" => $region, "section" => $section, "block" => $block, "widget" => $widgetId] var="url"}
    {call taskbarPanelLocales url=$url locale=$locale locales=$locales}
{/block}

{block name="content_title" append}
    <div class="page-header">
        <h1>{$node->getName($locale)} <small>{translate key="title.widget.properties" widget=$widgetName} ({$region})</small></h1>
    </div>
{/block}

{block name="content_body" append}
    {include file=$propertiesTemplate inline}
{/block}
