{* widget: login; action: index; translation: widget.login *}

{include file="base/form.prototype"}

<form id="{$form->getId()}" class="form" action="{$action}{if $referer}?referer={$referer|urlencode}{/if}" method="POST" role="form">
    <div class="form__group">
        {call formWidget form=$form row="__action"}

        {$errors = $form->getValidationErrors('username')}
        <div class="form-group{if $errors} has-error{/if}">
            <div class="col-lg-12">
                {call formWidget form=$form row="username"}
                {call formWidgetErrors form=$form row="username"}
            </div>
        </div>

        <div class="form-group{if $errors} has-error{/if}">
            <div class="col-lg-12">
                {call formWidget form=$form row="password"}
            </div>
        </div>

        {call formActions referer=$referer submit="button.login"}
    </div>
</form>

{if $urls}
<ul class="list-unstyled">
    {foreach $urls as $service => $url}
    <li><a href="{$url}">{translate key="button.login.`$service`"}</a></li>
    {/foreach}
</ul>
{/if}
