{function name="taskbarPanelPublish" url=null revision=null revisions=null}
    <li class="dropdown">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
            {translate key="label.revision"}: <strong>{$revision}</strong>
            <i class="icon icon--angle-down"></i>
        </a>
        <ul class="dropdown__menu">
        {foreach $revisions as $r}
            <li>
                <a href="{$url|replace:"%25revision%25":$r}">{$r}</a>
            </li>
        {/foreach}
        </ul>
    </li>
    <li>
        <form class="navbar__form" action="{url id="cms.node.publish" parameters=["site" => $site->getId(), "revision" => $site->getRevision(), "locale" => $locale, "node" => $site->getId()]}">
            <button class="btn btn-primary navbar-btn">{translate key="button.publish"}</button>
        </form>
    </li>
{/function}
