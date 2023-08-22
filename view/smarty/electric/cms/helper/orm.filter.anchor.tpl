{if isset($filterWidgetId) && isset($app.cms.context["orm.filters.`$filterWidgetId`"])}
    {$bodyComponent = $app.cms.node->get('body.components')}
    {if !strstr($bodyComponent, 'form')}
        {$app.cms.node->set('body.components', "`$bodyComponent` form")}
    {/if}
    {$filters = $app.cms.context["orm.filters.`$filterWidgetId`"]}
    {$filterUrl = $app.cms.context["orm.filters.`$filterWidgetId`.url"]}
{/if}

{if isset($filters)}
    {foreach $filters as $filterName => $filter}
        <div class="filter filter--{$filterName}">
            <h3>{$filterName}</h3>
            <ul class="list--unstyled">
            {foreach $filter.urls as $label => $url}
                <li><a{if $filter.values.$label == $filter.value || (is_array($filter.value) && in_array($filter.values.$label, $filter.value))} class="active"{/if} href="{$url}">{$label}</a></li>
            {/foreach}
                <li><a href="{$filter.empty}">{translate key="button.view.all"}</a></li>
            </ul>
        </div>
    {/foreach}
{/if}
