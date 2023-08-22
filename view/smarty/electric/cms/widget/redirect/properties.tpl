{include file="base/form.prototype"}

<form id="{$form->getId()}" class="form" action="{$app.url.request}" method="POST" role="form" enctype="multipart/form-data">
    <div class="form__group">

        <div class="form__item form__item--radios">
            <div class="form__radio-item">
                <label class="form__label form__label--radio">
                    {call formWidget form=$form row="type" part="node"}
                    {translate key="label.node"}
                </label>
            </div>
        </div>

        <div class="form__item">
            {call formWidget form=$form row="node"}
            {call formWidgetErrors form=$form row="node"}
        </div>

        <div class="form__item form__item--radios">
            <div class="form__radio-item">
                <label class="form__label form__label--radio">
                    {call formWidget form=$form row="type" part="url"}
                    {translate key="label.url"}
                </label>
            </div>
        </div>

        <div class="form__item">
            {call formWidget form=$form row="url"}
            {call formWidgetErrors form=$form row="url"}
        </div>

        {call formRows form=$form}

        <div class="form__actions">
            <button id="btn-submit" type="submit" name="action" class="btn btn--default">{translate key="button.save"}</button>
            <a id="btn-cancel" class="btn btn--link" href="{url id="cms.node.content" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId(), "region" => $region]}">{translate key="button.cancel"}</a>
        </div>
    </div>
</form>
