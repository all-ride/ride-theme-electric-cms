{extends file="cms/backend/index"}

{block name="head_title" prepend}{$site->getName($locale)} - {/block}

{block name="taskbar_panels" append}
    {if !$site->isAutoPublish()}
        {include file="cms/backend/taskbar"}

        {url id="cms.site.detail.locale" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => "%revision%"] var="url"}
        {call taskbarPanelPublish url=$url revision=$site->getRevision() revisions=$site->getRevisions()}
    {/if}

    {url id="cms.site.detail.locale" parameters=["locale" => "%locale%", "site" => $site->getId(), "revision" => $site->getRevision()] var="url"}
    {call taskbarPanelLocales url=$url locale=$locale locales=$locales}
{/block}

{block name="content_title" append}
    <div class="page-header">
        <h1>{$site->getName($locale)}</h1>
    </div>
{/block}
