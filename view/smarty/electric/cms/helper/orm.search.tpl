{if isset($searchWidgetId) && isset($app.cms.context["orm.search.`$searchWidgetId`"])}
    {$searchForm = $app.cms.context["orm.search.`$searchWidgetId`"]}
{/if}

{if isset($searchForm)}
    {include file="base/form.prototype"}

    <form action="{$app.url.request}" method="POST" role="form">
        {call formRows form=$searchForm}
        <button type="submit" class="btn" name="sa">{translate key="button.search"}</button>
    </form>
{/if}
