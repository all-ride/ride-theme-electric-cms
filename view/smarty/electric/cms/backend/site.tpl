{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.sites"} - {/block}

{block name="content_title" append}
    <div class="page-header">
        <h1>{translate key="title.sites"}</h1>
    </div>
{/block}

{block name="content_body" append}
    <ul>
    {foreach $sites as $site}
        <li><a href="{$site.url}">{$site.name}</a></li>
    {/foreach}
    </ul>

    {url var="actionUrl" id="cms.site.add" parameters=["locale" => $locale]}
    {isGranted url=$actionUrl}
        <a href="{$actionUrl}" class="btn btn--brand"><i class="icon icon--plus"></i> {translate key="button.site.add"}</a>
    {/isGranted}
{/block}
