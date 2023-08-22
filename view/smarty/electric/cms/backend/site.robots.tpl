{extends file="cms/backend/index"}

{block name="head_title" prepend}{translate key="title.site.robots"} - {$site->getName($locale)} - {/block}

{block name="taskbar_panels" append}
    {if !$site->isAutoPublish()}
        {include file="cms/backend/taskbar"}

        {url id="cms.site.robots" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => "%revision%"] var="url"}
        {call taskbarPanelPublish url=$url revision=$site->getRevision() revisions=$site->getRevisions()}
    {/if}

    {url id="cms.site.robots" parameters=["locale" => "%locale%", "site" => $site->getId(), "revision" => $site->getRevision()] var="url"}
    {call taskbarPanelLocales url=$url locale=$locale locales=$locales}
{/block}

{block name="content_title" append}
    <div class="page-header">
        <h1>{$site->getName($locale)} <small>{translate key="title.site.robots"}</small></h1>
    </div>
{/block}

{block name="content_body" append}
    <p>{translate key="label.node.action.robots.intro"}</p>
    {include file="base/form.prototype"}

    <form id="{$form->getId()}" action="{$app.url.request}" method="POST" role="form">
        <div class="form__group">
            {call formRows form=$form}

            {call formActions referer=$referer}
        </div>
    </form>
{/block}
