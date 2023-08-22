{extends file="cms/backend/index"}

{block name="head_title" prepend}{translate key="title.trash"} - {$site->getName($locale)} - {/block}

{block name="taskbar_panels" append}
    {if !$site->isAutoPublish()}
        {include file="cms/backend/taskbar"}

        {url id="cms.site.trash" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => "%revision%"] var="url"}
        {call taskbarPanelPublish url=$url revision=$site->getRevision() revisions=$site->getRevisions()}
    {/if}

    {url id="cms.site.trash" parameters=["locale" => "%locale%", "site" => $site->getId(), "revision" => $site->getRevision()] var="url"}
    {call taskbarPanelLocales url=$url locale=$locale locales=$locales}
{/block}

{block name="content_title" append}
    <div class="page-header">
        <h1>{$site->getName($locale)} <small>{translate key="title.trash"}</small></h1>
    </div>
{/block}

{block name="content_body" append}
    {if $trashNodes}
        {include file="base/form.prototype"}

        <form id="{$form->getId()}" action="{$app.url.request}" method="POST" role="form" class="form">
            <div class="form__group">
                {call formRows form=$form}

                <div class="form__actions">
                    <button type="submit" class="btn btn--default">{translate key="button.restore"}</button>
                    {if $referer}
                        <a href="{$referer}" class="btn btn--link">{translate key="button.cancel"}</a>
                    {/if}
                </div>
            </fieldset>
        </form>
    {else}
        <p>{translate key="label.trash.empty"}</p>
    {/if}
{/block}
