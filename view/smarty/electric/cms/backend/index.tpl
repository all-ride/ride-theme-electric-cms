{extends file="base/index.sidebar"}

{block name="styles" append}
    <link href="{$app.url.base}/electric/css/cms.min.css" rel="stylesheet" media="screen">
{/block}

{block name="content_title" append}
    {if isset($breadcrumbs)}
        <div class="breadcrumb">
            {foreach $breadcrumbs as $url => $label}
                <span itemscope itemtype="http://data-vocabulary.org/Breadcrumb" class="breadcrumb__item{if $label@last} breadcrumb__item--active{/if}">
                  <a href="{$url}" itemprop="url">
                    <span itemprop="title">{$label}</span>
                  </a>{if !$label@last} &rsaquo;{/if}
                </span>
            {/foreach}
        </div>
    {/if}
{/block}

{block name="sidebar"}
    {if isset($nodeCreateActions)}

    {$treeIcons = [
        'site' => 'globe',
        'page' => 'file-o',
        'folder' => 'folder-open-o',
        'entry' => 'hdd-o',
        'reference' => 'share-square-o',
        'redirect' => 'refresh',
        'home' => 'home'
    ]}
    <div class="btn-group clearfix">
        <a href="#" class="btn btn--brand" data-toggle="dropdown">{translate key="button.create"} <i class="icon icon--angle-down"></i></a>
        <ul class="dropdown__menu" role="menu">
            {foreach $nodeCreateActions as $nodeTypeName => $nodeActionUrl}
                <li><a href="{$nodeActionUrl}"><i class="icon icon--{$treeIcons[$nodeTypeName]}"></i> {translate key="label.node.type.`$nodeTypeName`"}</a></li>
            {/foreach}
        </ul>
        {* {if isset($site)} *}
        <a href="{url id="cms.site.trash" parameters=["site" => $site->getId(), "revision" => $site->getRevision(), "locale" => $locale]}" class="btn btn--default">
            {translate key="title.trash"}
            <i class="icon icon--trash-o"></i>
        </a>
        {* {/if} *}
    </div>
    {/if}

    <div class="site-tree">
        <div class="spinner spinner--sml"></div>
    </div>
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/electric/js/cms/lib/jquery.mjs.nestedSortable.js"></script>
    <script src="{$app.url.base}/electric/js/cms/tree.js"></script>
    {if isset($site)}
    <script type="text/javascript">
        $(function() {
            // push the tree intializer to the end of the event queu
            setTimeout(function() {
                joppaInitializeNodeTree(
                    '{url id="cms.site.tree" parameters=["site" => $site->getId(), "revision" => $site->getRevision(), "locale" => $locale]}?date={$site->getDateModified()}',
                    '{url id="cms.node.collapse" parameters=["site" => $site->getId(), "revision" => $site->getRevision(), "locale" => $locale, "node" => "%node%"]}',
                    '{url id="cms.site.order" parameters=["site" => $site->getId(), "revision" => $site->getRevision(), "locale" => $locale]}',
                    {$collapsedNodes},
                    {if isset($node)}'{$node->getId()}'{else}null{/if}
                )
            }, 0);
        });
    </script>
    {/if}
{/block}
