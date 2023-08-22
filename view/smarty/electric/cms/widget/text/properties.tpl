{include file="base/form.prototype"}

<form id="{$form->getId()}" class="form" action="{$action}" method="POST" role="form" enctype="multipart/form-data">
    <div class="form__group">
        {if $form->hasRow("existing")}
        <div class="form__item--existing clearfix superhidden" data-locale="{$locale|replace:"_":"-"}" data-url-text="{url id="api.orm.detail" parameters=["model" => "Text", "id" => "%id%"]}">
            <div class="form__item">
                <label class="form__label" for="form-text-existing">{translate key="label.text.existing.select"}</label>
                <div class="form__select-item">
                    {call formWidget form=$form row="existing"}
                </div>
            </div>
            <div class="form__item">
                {call formWidget form=$form row="existing-new"}
                <div class="preview"></div>
            </div>
        </div>
        {/if}

        <div class="tab">
            <div class="tabbable">
                <ul class="tabs">
                    <li class="tabs__tab active"><a href="#tabText" data-toggle="tab">{translate key="title.text"}</a></li>
                    <li class="tabs__tab"><a href="#tabCta" data-toggle="tab">{translate key="title.cta"}</a></li>
                    <li class="tabs__tab"><a href="#tabView" data-toggle="tab">{translate key="title.view"}</a></li>
                </ul>
            </div>

            <div class="tabs__content">
                <div id="tabText" class="tabs__pane active">
                    {call formRow form=$form row="body"}

                    {if $form->hasRow("existing")}
                    <p class="text-right">
                        <a href="#" id="btn-text-reuse">{translate key="button.text.existing"}</a>
                    </p>
                    {/if}

                    {call formRow form=$form row="title-use"}
                    {call formRow form=$form row="title"}
                    {call formRow form=$form row="subtitle"}
                    {call formRow form=$form row="image-use"}
                    {call formRow form=$form row="image-src"}
                    {call formRow form=$form row="image-align"}

                    {if $form->hasRow("locales-all")}
                        {call formRow form=$form row="locales-all"}
                    {/if}
                </div>

                <div id="tabCta" class="tabs__pane">
                    {call formRow form=$form row="cta"}
                </div>

                <div id="tabView" class="tabs__pane">
                    {call formRow form=$form row="template"}
                </div>
            </div>

            {call formRows form=$form}
        </div>

        <div class="form__actions">
            <button id="btn-submit" type="submit" name="action" class="btn btn--default">{translate key="button.save"}</button>
            <a id="btn-cancel" class="btn btn--link" href="{url id="cms.node.content" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId(), "region" => $region]}">{translate key="button.cancel"}</a>
        </div>
    </div>
</form>
