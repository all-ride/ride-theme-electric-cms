{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.repository"} - {/block}

{block name="content_title"}
    <div class="page-header">
        <h1>{translate key="title.repository"}</h1>
    </div>
{/block}

{block name="content_body" append}
    <form action="{$app.url.request}" method="POST" role="form">
        <p class="lead"><button type="submit" class="btn btn--default">{translate key="button.update.repository"}</button></p>
    </form>

    {foreach $commits as $commit}
        <div class="commit">
            <p><strong>{$commit->getFriendlyRevision()}</strong>: {$commit->message}</p>
            <p class="text-muted"><small>{translate key="label.repository.update" author=$commit->author|escape date=$commit->date}</small></p>
        </div>
        {if !$commit@last}<hr />{/if}
    {/foreach}
{/block}
