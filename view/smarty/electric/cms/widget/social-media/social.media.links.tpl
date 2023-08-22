{if $socialMedia}
    <nav class="widget-social-media nav--social">
      {if $title}
          <h2 class="{$app.cms.properties->getWidgetProperty('style.title')}">{$title}</h2>
      {/if}
        <ul>
        {foreach from=$socialMedia item=media}
          <li>
            <a href="{$media['url']}" target="_blank"><i class="icon icon--{$media['name']}-square"></i></a>
          </li>
        {/foreach}
        </ul>
    </nav>
{/if}
