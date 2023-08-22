{extends file="cms/backend/index"}

{block name="head_title" prepend}{translate key="title.node.visibility"} - {$node->getName($locale)} - {/block}

{block name="taskbar_panels" append}
    {if !$site->isAutoPublish()}
        {include file="cms/backend/taskbar"}

        {url id="cms.node.visibility" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => "%revision%", "node" => $node->getId()] var="url"}
        {call taskbarPanelPublish url=$url revision=$node->getRevision() revisions=$site->getRevisions()}
    {/if}

    {url id="cms.node.visibility" parameters=["locale" => "%locale%", "site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId()] var="url"}
    {call taskbarPanelLocales url=$url locale=$locale locales=$locales}
{/block}

{block name="content_title" append}
    <div class="page-header">
        <h1>{$node->getName($locale)} <small>{translate key="title.node.visibility"}</small></h1>
    </div>
    {include 'cms/helper/node.actions'}
    {call renderNodeActions actions=$nodeActions current='visibility'}
{/block}

{block name="content_body" append}
    <p>{translate key="label.node.action.visibility.intro"}</p>
    {include file="base/form.prototype"}

    <form id="{$form->getId()}" action="{$app.url.request}" method="POST" role="form" class="form grid">
        <div class="form__group grid--bp-med__10">
            {if $form->hasRow('availableLocales')}
                {call formRow form=$form row="availableLocales"}
            {/if}

            {call formRow form=$form row="published"}

            <div class="grid">
                <div class="grid--bp-med__6">
                    {call formRow form=$form row="publishStart"}
                </div>
                <div class="grid--bp-med__6">
                    {call formRow form=$form row="publishStop"}
                </div>
            </div>

            {call formRows form=$form}

            {call formActions referer=$referer}
        </div>
    </form>
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/electric/js/form.js"></script>
{/block}
