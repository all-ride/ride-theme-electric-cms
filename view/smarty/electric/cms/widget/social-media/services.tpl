{function name="renderSocialMedia" url=null title=null media=null}
    {if $media == 'facebook'}
        <a href="http://www.facebook.com/sharer.php?u={$url}"
           onclick="javascript:window.open(this.href, '', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=450,width=600'); return false;"
           target="_blank" class="share-link share-link--{$media}" title="Share on {$media}"><span class="visuallyhidden">{translate key="label.share.{$media}"}</span><i class="icon icon--{$media}-square"></i>
        </a>
    {elseif $media == 'google'}
        <a href="https://plus.google.com/share?url={$url}"
           onclick="javascript:window.open(this.href, '', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=450,width=600'); return false;"
           target="_blank" class="share-link share-link--{$media}" title="Share on {$media}"><span class="visuallyhidden">{translate key="label.share.{$media}"}</span><i class="icon icon--{$media}-square"></i>
        </a>
    {elseif $media =='pinterest'}
        <a href="https://pinterest.com/pin/create/bookmarklet/?&url={$url}&description={$title}"
           onclick="javascript:window.open(this.href, '', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=450,width=600'); return false;"
           target="_blank" class="share-link share-link--{$media}" title="Share on {$media}"><span class="visuallyhidden">{translate key="label.share.{$media}"}</span><i class="icon icon--{$media}-square"></i>
        </a>
    {elseif $media =='linkedIn'}
        <a href="http://www.linkedin.com/shareArticle?url={$url}&title={$title}"
           onclick="javascript:window.open(this.href, '', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=450,width=600'); return false;"
           target="_blank" class="share-link share-link--{$media}" title="Share on {$media}"><span class="visuallyhidden">{translate key="label.share.{$media}"}</span><i class="icon icon--{$media}-square"></i>
        </a>
    {elseif $media =='digg'}
        <a href="http://digg.com/submit?url={$url}&title={$title}"
           onclick="javascript:window.open(this.href, '', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=450,width=600'); return false;"
           target="_blank" class="share-link share-link--{$media}" title="Share on {$media}"><span class="visuallyhidden">{translate key="label.share.{$media}"}</span><i class="icon icon--{$media}-square"></i>
        </a>
    {elseif $media =='reddit'}
        <a href="http://reddit.com/submit?url={$url}&title={$title}"
           onclick="javascript:window.open(this.href, '', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=450,width=600'); return false;"
           target="_blank" class="share-link share-link--{$media}" title="Share on {$media}"><span class="visuallyhidden">{translate key="label.share.{$media}"}</span><i class="icon icon--{$media}-square"></i>
        </a>
    {elseif $media =='stumbleUpon'}
        <a href="http://reddit.com/submit?url={$url}&title={$title}"
           onclick="javascript:window.open(this.href, '', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=450,width=600'); return false;"
           target="_blank" class="share-link share-link--{$media}" title="Share on {$media}"><span class="visuallyhidden">{translate key="label.share.{$media}"}</span><i class="icon icon--{$media}-square"></i>
        </a>
    {elseif $media =='tumblr'}
        <a href="http://www.tumblr.com/share/link?url={$url}&name={$title}"
           onclick="javascript:window.open(this.href, '', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=450,width=600'); return false;"
           target="_blank" class="share-link share-link--{$media}" title="Share on {$media}"><span class="visuallyhidden">{translate key="label.share.{$media}"}</span><i class="icon icon--{$media}-square"></i>
        </a>
    {elseif $media == 'twitter'}
        <a href="https://twitter.com/share?url={$url}"
           onclick="javascript:window.open(this.href, '', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=450,width=600'); return false;"
           target="_blank" class="share-link share-link--{$media}" title="Share on {$media}"><span class="visuallyhidden">{translate key="label.share.{$media}"}</span><i class="icon icon--{$media}-square"></i>
        </a>
    {elseif $media == 'email'}
        <a href="mailto:?Subject=&Body={$url}"><span class="visuallyhidden">{translate key="label.share.{$media}"}</span><i class="icon icon--envelope-square"></i>
        </a>
    {/if}

{/function}
