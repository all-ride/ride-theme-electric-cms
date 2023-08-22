{include file="base/form.prototype"}

<form id="{$form->getId()}" class="form" action="{$app.url.request}" method="POST" role="form">
    <div class="form__group">
        <div class="tab">
            <div class="tabbable">
                <ul class="tabs">
                    <li class="tabs__tab active"><a href="#tabWidget" data-toggle="tab">{translate key="widget.orm.comments"}</a></li>
                    <li class="tabs__tab"><a href="#tabView" data-toggle="tab">{translate key="title.view"}</a></li>
                </ul>
            </div>

            <div class="tabs__content">
                <div id="tabWidget" class="tabs__pane active">
                    {call formRow form=$form row="finish"}
                    {call formRow form=$form row="anonymous"}
                    {call formRow form=$form row="approval"}
                </div>

                <div id="tabView" class="tabs__pane">
                    {call formRow form=$form row="template"}
                    {call formRow form=$form row="title"}
                </div>
            </div>
        </div>

        {call formRows form=$form}

        <div class="form__actions">
            <button type="submit" class="btn btn--default">{translate key="button.save"}</button>
            <button type="submit" name="cancel" class="btn btn--link">{translate key="button.cancel"}</button>
        </div>
    </div>
</form>
