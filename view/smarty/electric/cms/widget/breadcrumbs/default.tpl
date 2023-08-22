{* widget: breadcrumbs; action: index; translation: widget.breadcrumbs *}

<div class="widget widget-breadcrumbs {$app.cms.properties->getWidgetProperty('style.container')}" id="widget-{$app.cms.widget}">
    <div class="breadcrumb {$app.cms.properties->getWidgetProperty('style.menu')}" itemscope="" itemtype="http://schema.org/BreadcrumbList">
        {foreach $app.cms.context.breadcrumbs as $url => $label}
            <span itemprop="itemListElement" itemscope="" itemtype="http://schema.org/ListItem" class="breadcrumb__item{if $label@last} breadcrumb__item--active{/if}">
              {strip}
              <a href="{$url}" itemprop="item">
                <span itemprop="name">{$label}</span>
              </a>{if !$label@last} &rsaquo;{/if}
              <meta itemprop="position" content="{$label@iteration}">
              {/strip}
            </span>
        {/foreach}
    </div>
</div>