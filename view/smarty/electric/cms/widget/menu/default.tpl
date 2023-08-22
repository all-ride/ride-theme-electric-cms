{* widget: menu; action: index; translation: widget.menu *}

{*
    Renders the items of a menu
*}
{function name="renderMenu" items=null prefix=null number=null depth=null class=null}
    {assign var="prefix" value="`$prefix``$number`"}

    <ul class="{$prefix} {$class}">
    {foreach $items as $node}
        {if $node->hideInMenu() || (!$app.user && $node->hideForAnonymousUsers()) || ($app.user && $node->hideForAuthenticatedUsers())}
            {continue}
        {/if}

        {if $node->isPublished() && $nodeTypes[$node->getType()]->getFrontendCallback() && $node->isAvailableInLocale($app.locale) && $node->isAllowed($app.security)}
        <li class="{if $node@first}first {/if}{cycle values="even,odd" name=$prefix}{if $app.cms.node->hasParent($node->getId())} active-trail{elseif $app.cms.node->getId() == $node->getId()} active{/if}{if $node@last} last{/if}">
            <a href="{$app.url.script}{$node->getRoute($app.locale)}"><span>{$node->getName($app.locale, "menu")}</span></a>
            {if $node->getChildren() && $depth > 1}
                {call renderMenu items=$node->getChildren() prefix="`$prefix`sub" number=$number depth=$depth-1}

                {assign var="number" value=$number+1}
            {/if}
        </li>
        {/if}
    {/foreach}
    </ul>
{/function}

<div class="widget widget-menu {$app.cms.properties->getWidgetProperty('style.container')}" id="widget-{$app.cms.widget}">
    {if $title}
        <h2 class="toc {$app.cms.properties->getWidgetProperty('style.title')}">{$title}</h2>
    {/if}

    {if $items === false}
        {$items = $app.cms.context.title.nodes}
    {/if}

    {call renderMenu prefix="menu" items=$items number=1 depth=$depth class=$app.cms.properties->getWidgetProperty('style.menu')}
</div>
