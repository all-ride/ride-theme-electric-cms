<div class="widget widget-search-form widget-search-form-content {$app.cms.properties->getWidgetProperty('style.container')}" id="widget-{$app.cms.widget}">
    <form id="cse-search-box" action="{$action}" role="search" class="form-inline" method="post">
        <div class="form-group">
            <label class="sr-only" for="form-search-query">{translate key="label.query.search"}</label>
            <input type="search" id="form-search-query" name="query" class="form-control" />
        </div>
        <button type="submit" class="btn" name="sa">{translate key="button.search"}</button>
    </form>
</div>
