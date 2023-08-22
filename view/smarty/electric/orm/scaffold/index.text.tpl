{extends file="orm/scaffold/index"}

{block name="scripts" prepend}
    <script type="text/javascript">
        var translations = {
            more: '{translate key="label.show.more"}',
            less: '{translate key="label.show.less"}'
        };
    </script>
{/block}
{block name="scripts" append}
    <script src="{$app.url.base}/electric/js/text.admin.js"></script>
{/block}
