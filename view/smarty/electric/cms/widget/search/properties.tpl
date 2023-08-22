{include file="base/form.prototype"}

<form id="{$form->getId()}" class="form" action="{$app.url.request}" method="POST" role="form">
    <div class="form__group">
        {call formRows form=$form}

        <div class="form__actions">
            <button type="submit" name="action" class="btn btn--default">{translate key="button.save"}</button>
            <a class="btn btn--link" href="{url id="cms.node.content" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId(), "region" => $region]}">{translate key="button.cancel"}</a>
        </div>
    </div>
</form>
