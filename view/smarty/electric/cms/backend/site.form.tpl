{extends file="cms/backend/index"}

{block name="head_title" prepend}{if $node->getId()}{translate key="title.site.edit"}{else}{translate key="title.site.add"}{/if} - {/block}

{block name="taskbar_panels" append}
    {if isset($site) && $site->getId()}
        {if $node->getId()}
            {if !$site->isAutoPublish()}
                {include file="cms/backend/taskbar"}

                {url id="cms.site.edit" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => "%revision%"] var="urlPublish"}

                {call taskbarPanelPublish url=$urlPublish revision=$node->getRevision() revisions=$site->getRevisions()}
            {/if}

            {url id="cms.site.edit" parameters=["locale" => "%locale%", "site" => $site->getId(), "revision" => $site->getRevision()] var="urlLocales"}
        {else}
            {url id="cms.site.add" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => "%revision%"] var="urlPublish"}
        {/if}

        {call taskbarPanelLocales url=$urlLocales locale=$locale locales=$locales}
    {/if}
{/block}

{block name="content_title" append}
    <div class="page-header">
        {if $node->getId()}
        <h1>{$node->getName($locale)} <small>{translate key="title.site.edit"}</small></h1>
        {include 'cms/helper/node.actions'}
        {call renderNodeActions actions=$nodeActions current='settings'}
        {else}
        <h1>{translate key="title.site.add"}</h1>
        {/if}
    </div>
{/block}

{block name="content_body" append}
    {include file="base/form.prototype"}

    <form id="{$form->getId()}" class="form" action="{$app.url.request}" method="POST" role="form">
        {call formRows form=$form}

        {call formActions referer=$referer}
    </form>
{/block}
