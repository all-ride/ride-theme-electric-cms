{extends file="cms/backend/index"}

{block name="head_title" prepend}{if $node->getType() == 'site'}{translate key="title.site.delete"}{else}{translate key="title.node.delete"}{/if} - {$node->getName($locale)} - {/block}

{block name="content_title" append}
    <div class="page-header">
        <h1>{$node->getName($locale)} <small>{if $node->getType() == 'site'}{translate key="title.site.delete"}{else}{translate key="title.node.delete"}{/if}</small></h1>
    </div>
{/block}

{block name="content_body" append}
    {include file="base/form.prototype"}

    {if $node->getId() == $node->getRootNodeId()}
        <div class="alert alert-warning">
            <p>{translate key="warning.site.delete"}</p>
        </div>
    {/if}

    <form action="{$app.url.request}" method="POST" role="form">
        <div class="form__group">
            <p>{translate key="label.confirm.node.delete" node=$node->getName($locale)}</p>
        </div>

        {call formWidget form=$form row="recursive"}

        {call formRows form=$form}

        <div class="form__actions">
            <button type="submit" class="btn btn--default">{translate key="button.delete"}</button>
            <a class="btn btn--link" href="{$referer}">{translate key="button.cancel"}</a>
        </div>
    </form>
{/block}
