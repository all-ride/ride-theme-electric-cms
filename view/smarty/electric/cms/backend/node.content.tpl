{extends file="cms/backend/index"}

{block name="head_title" prepend}{translate key="title.node.layout"} - {$node->getName($locale)} - {/block}

{block name="taskbar_panels" append}
    {if !$site->isAutoPublish()}
        {include file="cms/backend/taskbar"}

        {url id="cms.node.content.region" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => "%revision%", "node" => $node->getId(), "region" => $region] var="url"}
        {call taskbarPanelPublish url=$url revision=$node->getRevision() revisions=$site->getRevisions()}
    {/if}

    {url id="cms.node.content.region" parameters=["locale" => "%locale%", "site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId(), "region" => $region] var="url"}
    {call taskbarPanelLocales url=$url locale=$locale locales=$locales}
{/block}

{block name="content_title" append}
    <div class="page-header">
        <h1>{$node->getName($locale)} <small>{translate key="title.node.layout"}</small></h1>
    </div>
    {include file="cms/helper/node.actions"}
    {call renderNodeActions actions=$nodeActions current='content'}
    {if $locales|count > 1}
        <p>
            <label for="toggle-available">
                <input type="checkbox" id="toggle-available" class="js-toggle-available" /> {translate key="widget.locales.available.show"}
            </label>
        </p>
    {/if}
{/block}

{block name="content_body" append}
    {include file="cms/backend/content.prototype"}
    {foreach $layouts as $layout}
        {include file=$layout->getBackendResource() inline}
    {/foreach}
    {include file="base/form.prototype"}

    {if count($form->getRow('region')->getWidget()->getOptions()) > 1}
    <form id="{$form->getId()}" action="{url id="cms.node.content" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId()]}" method="POST" class="form-inline" role="form">
        <p>{translate key="label.region.select"} {call formWidget form=$form row="region"}</p>
    </form>
    {/if}

    <p><button class="btn btn--default section-add" data-method="prepend"><i class="icon icon--plus"></i> {translate key="button.section.add"}</button></p>

    <div class="sections">
    {foreach $sections as $section => $layout}
        {call sectionPanel site=$site node=$node section=$section layouts=$layouts layout=$layout widgets=$regionWidgets[$section] inheritedWidgets=$inheritedWidgets[$section] actions=$actions}
    {/foreach}
    </div>

    <p><button class="btn btn--default section-add" data-method="append"><i class="icon icon--plus"></i> {translate key="button.section.add"}</button></p>

    <div class="modal modal-widget-add fade" id="modalWidgetAdd" tabindex="-1" role="dialog" aria-labelledby="modalWidgetAddLabel" aria-hidden="true">
        <div class="modal-dialog modal--lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn--default" data-dismiss="modal"><i class="icon icon--times" aria-hidden="true"></i> <span class="sr-only">{'button.close'|translate}</span></button>
                    <h4 class="modal-title" id="modalWidgetAddLabel">{'button.widget.add'|translate}</h4>
                </div>
                <div class="modal-header clearfix">
                    <div class="pull--right">
                        <button type="button" class="btn btn--link" data-dismiss="modal">{translate key="button.cancel"}</button>
                        <button type="button" class="btn btn--default widget-add-submit">{translate key="button.add"}</button>
                        <button type="button" class="btn btn--default widget-add-submit-close">{translate key="button.add.close"}</button>
                    </div>
                </div>
                <div class="modal-body">
                    <form action="#" class="form-widget-add">
                        <input name="section" type="hidden" />
                        <input name="block" type="hidden" />

                        <p>{translate key="label.widgets.available.description"}</p>

                        <div class="form__item form__item">
                            <input type="text" class="form__text" placeholder="filter..." autocomplete="off" autofocus id="filter-widgets" />
                        </div>

                        <div class="form__item grid widget-row">
                        {foreach $availableWidgets as $name => $widget}
                            {isGranted permission="cms.widget.`$name`.manage"}
                        <div class="grid--bp-med__6" data-widget="{$name}">
                            <div class="widget widget--compact">
                                <div class="radio">
                                    <label>
                                        <input name="widget" value="{$name}" type="radio">
                                        <img src="{image src=$widget->getIcon() default="electric/img/cms/widget.png"}" class="handle" />
                                        {translate key="widget.`$name`"}
                                    </label>
                                </div>
                            </div>
                        </div>
                            {/isGranted}
                       {/foreach}
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn--link" data-dismiss="modal">{'button.cancel'|translate}</button>
                    <button type="button" class="btn btn--default widget-add-submit">{'button.add'|translate}</button>
                    <button type="button" class="btn btn--default widget-add-submit-close">{'button.add.close'|translate}</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal modal-section-action fade" id="modalSectionAction" tabindex="-1" role="dialog" aria-labelledby="modalSectionActionLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn--default" data-dismiss="modal"><i class="icon icon--times" aria-hidden="true"></i> <span class="sr-only">{'button.close'|translate}</span></button>
                    <h4 class="modal-title" id="modalWidgetAddLabel"></h4>
                </div>
                <div class="modal-body"></div>
                <div class="modal-footer">
                    <button type="button" class="btn btn--link" data-dismiss="modal">{'button.cancel'|translate}</button>
                    <button type="button" class="btn btn--default section-action-submit">{'button.save'|translate}</button>
                </div>
            </div>
        </div>
    </div>
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/electric/js/cms/layout.js"></script>
    <script src="{$app.url.base}/electric/js/cms/lib/modal.js"></script>
    <script type="text/javascript">
        $(function() {
            $('select[name=region]').change(function() {
                $('#form-region-select').submit();
            });

            initializeContent('{$baseAction}', '{translate key="label.confirm.widget.delete"}');
        });
    </script>
{/block}
