{include file="base/form.prototype"}

<form id="{$form->getId()}" class="form" action="{$app.url.request}" method="POST" role="form">
    <div class="form__group">
        {call formRows form=$form}

        <div class="form__actions">
            <button type="submit" class="btn btn--default">{translate key="button.submit"}</button>
        </div>
    </div>
</form>
