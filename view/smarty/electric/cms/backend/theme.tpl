{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.themes"} - {/block}

{block name="content_title" append}
    <div class="page-header">
        <h1>{translate key="title.themes"}</h1>
    </div>
{/block}

{block name="content_body" append}
    <p><a href="{url id="cms.theme.add"}" class="btn btn--default">{translate key="button.theme.add"}</a></p>
    <ul>
    {foreach $themes as $theme}
        <li><a href="{url id="cms.theme.edit" parameters=["theme" => $theme->getName()]}">{$theme->getDisplayName()}</a></li>
    {/foreach}
    </ul>
{/block}
