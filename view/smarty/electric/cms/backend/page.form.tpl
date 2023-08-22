{extends file="cms/backend/index"}

{block name="head_title" prepend}{if $node->getId()}{translate key="title.page.edit"}{else}{translate key="title.page.add"}{/if} - {/block}

{block name="taskbar_panels" append}
    {if $node->getId()}
        {url id="cms.page.edit" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => "%revision%", "node" => $node->getId()] var="urlPublish"}
        {url id="cms.page.edit" parameters=["locale" => "%locale%", "site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId()] var="urlLocales"}
    {else}
        {url id="cms.page.add" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => "%revision%"] var="urlPublish"}
        {url id="cms.page.add" parameters=["locale" => "%locale%", "site" => $site->getId(), "revision" => $site->getRevision()] var="urlLocales"}
    {/if}

    {if !$site->isAutoPublish()}
        {include file="cms/backend/taskbar"}

        {call taskbarPanelPublish url=$urlPublish revision=$node->getRevision() revisions=$site->getRevisions()}
    {/if}

    {call taskbarPanelLocales url=$urlLocales locale=$locale locales=$locales}
{/block}

{block name="content_title" append}
    <div class="page-header">
        {if $node->getId()}
        <h1>{$node->getName($locale)} <small>{translate key="title.page.edit"}</small></h1>
            {include 'cms/helper/node.actions'}
            {call renderNodeActions actions=$nodeActions current='settings'}
        {else}
        <h1>{translate key="title.page.add"}</h1>
        {/if}
    </div>
{/block}

{block name="content_body" append}
    {include file="base/form.prototype"}

    <form id="{$form->getId()}" class="form-horizontal" action="{$app.url.request}" method="POST" role="form" enctype="multipart/form-data">
        <div class="form__group">
            {call formRow form=$form row="name"}

            <div class="form__item">
                <a href="#" class="btn-alternate-names">{translate key="button.names.alternate"}</a>
            </div>

            {$rows = $form->getRows()}

            {$hasData = false}
            {if $rows['name-title']->data || $rows['name-menu']->data || $rows['name-breadcrumb']->data}
                {$hasData = true}
            {/if}

            <div class="form__item alternate-names{if !$hasData} superhidden{/if}">
                {call formRow form=$form row="name-title"}
                {call formRow form=$form row="name-menu"}
                {call formRow form=$form row="name-breadcrumb"}
            </div>

            {call formRow form=$form row="route"}

            {if isset($rows["theme"]) }
                {call formRow form=$form row="theme"}
            {/if}

            {call formRows form=$form}

            {call formActions referer=$referer}
        </div>
    </form>
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/electric/js/form.js"></script>
    <script>
        $(function() {
            $('.btn-alternate-names').click(function(e) {
                e.preventDefault();
                $('.alternate-names').toggleClass('superhidden');
            });
        });
    </script>
{/block}
