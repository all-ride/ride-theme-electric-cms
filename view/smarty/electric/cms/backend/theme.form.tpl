{extends file="base/index"}

{block name="head_title" prepend}{if $theme}{translate key="title.theme.edit"} - {$theme->getDisplayName()}{else}{translate key="title.theme.add"}{/if} - {/block}

{block name="content_title" append}
    <div class="page-header">
    {if $theme}
        <h1>{$theme->getDisplayName()} <small>{translate key="title.theme.edit"}</small></h1>
    {else}
        <h1>{translate key="title.theme.add"}</h1>
    {/if}
    </div>
{/block}

{block name="content_body" append}
    {include file="base/form.prototype"}

    <form id="{$form->getId()}" class="form-horizontal form form--selectize" action="{$app.url.request}" method="POST" role="form">
        <div class="form__group">
            {call formRows form=$form}

            <div class="form__actions">
                <button type="submit" class="btn btn--brand">{translate key="button.save"}</button>
                {if $urlDelete}
                    <a href="{$urlDelete}" class="btn btn--danger">{translate key="button.theme.delete"}</a>
                {/if}
                {if $referer}
                    <a href="{$referer}" class="btn btn--link">{translate key="button.cancel"}</a>
                {/if}
            </div>
        </div>
    </form>
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/electric/js/form.js"></script>
{/block}
