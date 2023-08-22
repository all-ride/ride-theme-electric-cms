{include file="base/form.prototype"}

<form id="{$form->getId()}" class="form" action="{$app.url.request}" method="POST" role="form" enctype="multipart/form-data">
    <p>{translate key="label.login.authenticated"}</p>
    <div class="form__group">
        <div class="tab">
            <div class="tabbable">
                <ul class="tabs">
                    <li class="tabs__tab active"><a href="#tabWidget" data-toggle="tab">{translate key="widget.login"}</a></li>
                    <li class="tabs__tab"><a href="#tabView" data-toggle="tab">{translate key="title.view"}</a></li>
                </ul>
            </div>

            <div class="tabs__content">
                <div id="tabWidget" class="tabs__pane active">
                    <div class="form__item form__item--radios">
                        <label class="form__label">
                            {call formWidget form=$form row="authenticated" part="referer"}
                            {translate key="label.login.redirect.referer"}
                        </label>
                    </div>

                    <div class="form__item form__item--radios">
                        <label class="form__label">
                            {call formWidget form=$form row="authenticated" part="node"}
                            {translate key="label.login.redirect.node"}
                        </label>
                        <div class="redirect-type redirect-type-node">
                            {call formWidget form=$form row="node"}
                            {call formWidgetErrors form=$form row="node"}
                        </div>
                    </div>

                    <div class="form__item form__item--radios">
                        <label class="form__label">
                            {call formWidget form=$form row="authenticated" part="render"}
                            {translate key="label.login.render"}
                        </label>
                    </div>

                    <div class="form__item form__item--radios">
                        <label class="form__label">
                            {call formWidget form=$form row="authenticated" part="nothing"}
                            {translate key="label.login.nothing"}
                        </label>
                    </div>
                </div>

                <div id="tabView" class="tabs__pane">
                    {call formRow form=$form row="template"}
                </div>
            </div>
        </div>

        {call formRows form=$form}

        <div class="form__actions">
            <button id="btn-submit" type="submit" name="action" class="btn btn--default">{translate key="button.save"}</button>
            <a id="btn-cancel" class="btn btn--link" href="{url id="cms.node.content" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId(), "region" => $region]}">{translate key="button.cancel"}</a>
        </div>
    </div>
</form>
