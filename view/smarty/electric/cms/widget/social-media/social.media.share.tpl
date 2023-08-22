{$title = $app.cms.context.title.node|text}
{$url = $app.url.request}
{include file="cms/widget/social-media/services"}
<nav class="nav nav--social">
  <ul>
    {if isset($socialMedia)}
        {foreach $socialMedia as $media}
          <li>{call renderSocialMedia url=$url title=$title media=$media}</li>
        {/foreach}
    {/if}
  </ul>
</nav>
