{if $myviews}
    <div class="list-group">
        <div id="myviewlist" class="list-group">
            {$myviews.tablerows|safe}
        </div>
    {if $myviews.pagination}
        <div id="myviews_page_container" class="hidden">{$myviews.pagination|safe}</div>
    {/if}
    {if $myviews.pagination_js}
    <script type="application/javascript">
        addLoadEvent(function() {literal}{{/literal}
            {$myviews.pagination_js|safe}
            removeElementClass('myviews_page_container', 'hidden');
        {literal}}{/literal});
    </script>
    {/if}
    </div>
{else}
<div class="panel-body">
    <p class="lead text-small">{str tag='noviewstosee' section='group'}</p>
</div>
{/if}

