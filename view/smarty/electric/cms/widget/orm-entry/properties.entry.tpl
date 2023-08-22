{include file="base/form.prototype"}

<form id="{$form->getId()}" class="form" action="{$app.url.request}" method="POST" role="form">
    <div class="form__group">
        <div class="tabbable">
            <ul class="tabs">
                <li class="tabs__tab active"><a href="#tabQuery" data-toggle="tab">{translate key="title.query"}</a></li>
                {if $form->hasRow('content-mapper')}
                    <li class="tabs__tab"><a href="#tabMapper" data-toggle="tab">{translate key="title.content.mapper"}</a></li>
                {/if}
                {if $form->hasRow('model')}
                    <li class="tabs__tab"><a href="#tabView" data-toggle="tab">{translate key="title.view"}</a></li>
                {/if}
            </ul>

            <div class="tabs__content">
                <div id="tabQuery" class="tabs__pane active">
                    {if $form->hasRow('model')}
                        {call formRow form=$form row="model"}
                    {/if}
                    {call formRow form=$form row="entry"}
                    {if $form->hasRow('include-unlocalized')}
                        {call formRow form=$form row="include-unlocalized"}
                    {/if}
                </div>

                {if $form->hasRow('content-mapper')}
                    <div id="tabMapper" class="tabs__pane">
                        {call formRow form=$form row="content-mapper"}
                    </div>
                {/if}

                <div id="tabView" class="tabs__pane">
                    {if $form->hasRow('template')}
                        {call formRow form=$form row="template"}
                    {/if}
                    {if $form->hasRow('view-processor')}
                        {call formRow form=$form row="view-processor"}
                    {/if}
                    {if $form->hasRow('title' && $form->hasRow('breadcrumb'))}
                        {call formRow form=$form row="title"}
                        {call formRow form=$form row="breadcrumb"}
                    {/if}

                    {if $form->hasRow('format-title')}
                        <h4>{translate key="title.formats.data"}</h4>

                        {call formRow form=$form row="format-title"}
                        {call formRow form=$form row="format-teaser"}
                        {call formRow form=$form row="format-image"}
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
