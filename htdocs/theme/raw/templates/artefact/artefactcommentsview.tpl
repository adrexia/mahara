{if $allowcomments}
<div class="comments ptm">
    {if $commentcount > 0}
    <a class="commentlink" id="block_{$blockid}" data-toggle="modal" data-target="#feedbacktable_{$blockid}" href="#">
        {str tag=Comments section=artefact.comment} ({$commentcount})
    </a>
    {else}
    <a class="addcomment" href="{$artefacturl}">
        {str tag=addcomment section=artefact.comment}
        <span class="icon icon-arrow-right text-success pls"></span>
    </a>
    {/if}
</div>
{/if}

{if !$editing}
<div class="feedback modal modal-docked modal-docked-right" id="feedbacktable_{$blockid}">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header clearfix">
                <button class="deletebutton close" data-dismiss="modal">
                    <span class="times">&times;</span>
                    <span class="sr-only">{str tag=Close}</span>
                </button>
                <h4 class="modal-title pull-left">
                    <span class="icon icon-lg icon-comments prm"></span>
                    {str tag=Comments section=artefact.comment} - {$artefacttitle}
                </h4>
                {if $allowcomments}
                <a class="addcomment pull-right" href="{$artefacturl}">
                    {str tag=addcomment section=artefact.comment}
                    <span class="icon icon-arrow-right pls"></span>
                </a>
                {/if}
            </div>
            <div class="modal-body">
            {$comments->tablerows|safe}
            </div>
        </div>
    </div>
</div>
{/if}
