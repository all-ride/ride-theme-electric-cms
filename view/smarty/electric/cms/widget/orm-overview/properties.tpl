{include file="base/form.prototype"}

<form id="{$form->getId()}" class="form" action="{$app.url.request}" method="POST" role="form">
    <div class="form__group">
        <div class="tabbable">
            <ul class="tabs">
                {if $form->hasRow('model')}
                    <li class="tabs__tab active"><a href="#tabQuery" data-toggle="tab">{translate key="title.query"}</a></li>
                {/if}
                {if $form->hasRow('parameters-type')}
                    <li class="tabs__tab"><a href="#tabParameters" data-toggle="tab">{translate key="title.parameters.url"}</a></li>
                {/if}
                {if $form->hasRow('content-mapper')}
                    <li class="tabs__tab"><a href="#tabMapper" data-toggle="tab">{translate key="title.content.mapper"}</a></li>
                {/if}
                <li class="tabs__tab {if !$form->hasRow('model') && !$form->hasRow('parameters-type') && !$form->hasRow('content-mapper')}active{/if}"><a href="#tabView" data-toggle="tab">{translate key="title.view"}</a></li>
            </ul>

            <div class="tabs__content">
                <div id="tabQuery" class="tabs__pane active">
                    {if $form->hasRow('model') && $form->hasRow('include-unlocalized')}
                        {call formRow form=$form row="model"}
                        {call formRow form=$form row="include-unlocalized"}
                    {/if}
                    {if $form->hasRow('condition') && $form->hasRow('filters') && $form->hasRow('search')}
                        <h4>{translate key="title.condition"}</h4>
                        {call formRow form=$form row="condition"}
                        {call formRow form=$form row="filters"}
                        {call formRow form=$form row="search"}
                    {/if}
                    {if $form->hasRow('order-field') && $form->hasRow('order-direction')}
                        <h4>{translate key="title.order"}</h4>
                        <div class="form-group grid clearfix">
                            <label class="grid--bp-med__2 control-label">{translate key="label.order.field"}</label>
                            <div class="grid--bp-med__10">
                                {call formWidget form=$form row="order-field" class="form__select--inline"}
                                {call formWidget form=$form row="order-direction" class="form__select--inline"}
                                <button class="btn btn--default btn-order-add" id="form-content-properties-order-add">{translate key="button.add"}</button>
                                <div class="help-block">{translate key="label.order.field.description"}</div>
                            </div>
                        </div>
                        {call formRow form=$form row="order"}
                    {/if}

                    {if $form->hasRow('pagination-enable')}
                        <h4>{translate key="title.pagination"}</h4>

                        {call formRow form=$form row="pagination-enable"}

                        {call formRow form=$form row="pagination-rows" class="pagination-attribute"}

                        {call formRow form=$form row="pagination-offset" class="pagination-attribute"}
                    {/if}
                </div>
                {if $form->hasRow('parameters-type')}
                    <div id="tabParameters" class="tabs__pane">
                        <p>{translate key="label.parameters.description"}</p>
                        <div class="control-group grid">
                            <label class="grid--bp-med__2 control-label">{translate key="label.parameters"}</label>
                            <div class="grid--bp-med__10">
                                <div class="form__item form__item--radios form__item--radios">
                                    <div class="form__radio-item">
                                        <label class="form__label form__label--radio">
                                            {call formWidget form=$form row="parameters-type" part="none"}
                                            {translate key="label.parameters.none"}
                                        </label>
                                    </div>
                                    <div class="form__radio-item">
                                        <label class="form__label form__label--radio">
                                            {call formWidget form=$form row="parameters-type" part="numeric"}
                                            {translate key="label.parameters.numeric"}
                                        </label>
                                        <div class="help-block">{translate key="label.parameters.numeric.description"}</div>
                                        {call formRow form=$form row="parameters-number" class="parameters-enable parameters-numeric"}
                                    </div>
                                    <div class="form__radio-item">
                                        <label class="form__label form__label--radio">
                                            {call formWidget form=$form row="parameters-type" part="named"}
                                            {translate key="label.parameters.named"}
                                        </label>
                                        <div class="help-block">{translate key="label.parameters.named.description"}</div>
                                        {call formRow form=$form row="parameters-name" class="parameters-enable parameters-named"}
                                    </div>
                                </div>
                            </div>
                        </div>
                        {if $form->hasRow('parameters-none')}
                        {call formRow form=$form row="parameters-none"}
                        {/if}
                    </div>
                {/if}
                {if $form->hasRow('content-mapper')}
                    <div id="tabMapper" class="tabs__pane">
                        {call formRow form=$form row="content-mapper"}
                    </div>
                {/if}

                <div id="tabView" class="tabs__pane {if !$form->hasRow('model') && !$form->hasRow('parameters-type') && !$form->hasRow('content-mapper')}active{/if}">
                    {if $form->hasRow('template')}
                        {call formRow form=$form row="template"}
                    {/if}
                    {if $form->hasRow('view-processor')}
                        {call formRow form=$form row="view-processor"}
                    {/if}
                    {call formRow form=$form row="title"}
                    {if $form->hasRow('empty-result-view')}
                        {call formRow form=$form row="empty-result-view"}
                    {/if}
                    {if $form->hasRow('empty-result-message')}
                        {call formRow form=$form row="empty-result-message"}
                    {/if}

                    {if $form->hasRow('pagination-show')}
                        <h4 class="pagination-attribute">{translate key="title.pagination"}</h4>

                        {call formRow form=$form row="pagination-show" class="pagination-attribute"}
                        {call formRow form=$form row="pagination-ajax" class="pagination-attribute pagination-ajax"}
                        {call formRow form=$form row="more-show" class="pagination-attribute"}
                        {call formRow form=$form row="more-label" class="pagination-attribute more-attribute"}
                        {call formRow form=$form row="more-node" class="pagination-attribute more-attribute"}
                    {/if}
                    {if $form->hasRow('format-title')}
                        <h4>{translate key="title.formats.data"}</h4>
                        {call formRow form=$form row="format-title"}
                    {/if}
                    {if $form->hasRow('format-teaser')}
                    {call formRow form=$form row="format-teaser"}
                    {/if}
                    {if $form->hasRow('format-image')}
                        {call formRow form=$form row="format-image"}
                    {/if}
                    {if $form->hasRow('format-date')}
                        {call formRow form=$form row="format-date"}
                    {/if}
                </div>
            </div>
        </div>

        <div class="form__actions">
            <button type="submit" class="btn btn--default">{translate key="button.save"}</button>
            <button type="submit" name="cancel" class="btn btn--link">{translate key="button.cancel"}</button>
        </div>
    </div>
</form>
