{extends file="cms/backend/index"}

{block name="head_title" prepend}{translate key="title.node.varnish"} - {$node->getName($locale)} - {/block}

{block name="taskbar_panels" append}
    {if !$site->isAutoPublish()}
        {include file="cms/backend/taskbar"}

        {url id="cms.node.varnish" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => "%revision%", "node" => $node->getId()] var="url"}
        {call taskbarPanelPublish url=$url revision=$node->getRevision() revisions=$site->getRevisions()}
    {/if}

    {url id="cms.node.varnish" parameters=["locale" => "%locale%", "site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId()] var="url"}
    {call taskbarPanelLocales url=$url locale=$locale locales=$locales}
{/block}

{block name="content_title" append}
    <div class="page-header">
        <h1>{$node->getName($locale)} <small>{translate key="title.node.varnish"}</small></h1>
    </div>
    {include 'cms/helper/node.actions'}
    {call renderNodeActions actions=$nodeActions current='varnish'}
{/block}

{block name="content_body" append}
    {include file="base/form.prototype"}

    {isGranted permission="cms.node.varnish.manage" var="isGranted"}{/isGranted}
    {if $isGranted}
    <h3>{translate key="title.headers"}</h3>

    <form id="{$formHeaders->getId()}" action="{$app.url.request}" method="POST" role="form" class="form grid">
        <div class="form__group grid--bp-med__10">
            {call formRows form=$formHeaders}

            {call formActions referer=$referer}
        </div>
    </form>
    {/if}

    <h3>{translate key="title.cache.clear"}</h3>

    <p>{translate key="label.confirm.varnish.clear"}</p>

    <form id="{$formClear->getId()}" action="{$app.url.request}" method="POST" role="form" class="form grid">
        <div class="form__group grid--bp-med__10">
            {call formRows form=$formClear}

            {call formActions referer=$referer submit="button.clear"}
        </div>
    </form>
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/electric/js/form.js"></script>
{/block}
