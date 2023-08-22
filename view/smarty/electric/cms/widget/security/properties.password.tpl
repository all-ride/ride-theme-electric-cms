{include file="base/form.prototype"}

<form id="{$form->getId()}" class="form" action="{$app.url.request}" method="POST" role="form" enctype="multipart/form-data">
    <div class="form__group">
        <div class="tab">
            <div class="tabbable">
                <ul class="tabs">
                    <li class="tabs__tab active"><a href="#tabWidget" data-toggle="tab">{translate key="widget.password"}</a></li>
                    <li class="tabs__tab"><a href="#tabView" data-toggle="tab">{translate key="title.view"}</a></li>
                </ul>
            </div>

            <div class="tab__content">
                <div id="tabWidget" class="tab__pane active">
                    {call formRow form=$form row="subject"}
                    {call formRow form=$form row="message"}
                                    </div>

                <div id="tabView" class="tab__pane">
                    {call formRow form=$form row="template_request"}
                    {call formRow form=$form row="template_reset"}
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
