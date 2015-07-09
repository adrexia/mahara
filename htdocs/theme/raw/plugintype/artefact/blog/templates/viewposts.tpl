{foreach from=$posts item=post}
    <div class="post list-group-item">
        <div class="clearfix">
            <div class="post-heading pull-left">
                <h4 class="title">
                    <a href="{$WWWROOT}artefact/artefact.php?artefact={$post->id}&view={$options.viewid}">{$post->title}</a>
                </h4>
                <div class="postdetails metadata">
                    <span class="icon icon-calendar mrs"></span>
                    {$post->postedby}
                </div>
                {if $post->tags}
                <div class="tags metadata">
                    <span class="icon icon-tags"></span>
                    <strong>{str tag=tags}:</strong>
                    {list_tags owner=$post->owner tags=$post->tags}
                </div>
                {/if}
            </div>
            {if $post->files}
            <div class="btn-group btn-group-top" role="group" id="postfiles_{$post->id}">
                <button type="button" class="btn btn-default">
                    <span class="icon icon-paperclip icon-lg"></span>
                    <span class="sr-only">{str tag=attachedfiles section=artefact.blog}</span>
                </button>
            </div>
            {/if}
        </div>
        <div class="post-content clearfix mtl">
            {if $post->files}
            <ul class="list-group list-group-unbordered pull-right sr-only">
                {foreach from=$post->files item=file}
                <li class="list-group-item">
                    <a href="{$WWWROOT}artefact/artefact.php?artefact={$file->attachment}&view={$options.viewid}" class="outer-link icon-on-hover">
                        <span class="sr-only">
                            {str tag=Download section=artefact.file} {$file->title}
                        </span>
                    </a>
                    {if $file->icon}
                    <img src="{$file->icon}" alt="">
                    {else}
                    <span class="icon icon-{$file->artefacttype} icon-lg text-default"></span>
                    {/if}
                    <span class="title list-group-item-heading plm inline">
                        <a href="{$WWWROOT}artefact/file/download.php?file={$file->attachment}&amp;view={$options.viewid}" class="inner-link">
                            {$file->title}
                            <span class="metadata"> -
                                [{$file->size|display_size}]
                            </span>
                        </a>
                    </span>
                    <span class="icon icon-download icon-lg pull-right pts text-watermark icon-action"></span>
                </li>
                {/foreach}
            </ul>
            {/if}
            {$post->description|clean_html|safe}
        </div>

        {if $options.viewid && $post->allowcomments}
        <div class="comments clearfix ptm pbl">
            {if $post->commentcount > 0}
            <a id="blockpost_{$post->id}" class="commentlink" data-toggle="modal" data-target="#feedbacktable_0{$post->id}{$options.blockid}" href="#">
                {str tag=Comments section=artefact.comment} ({$post->commentcount})
            </a>
            {else}
                {if $post->allowcomments}
                <a class="addcomment" href="{$WWWROOT}artefact/artefact.php?artefact={$post->id}&view={$options.viewid}">
                    {str tag=addcomment section=artefact.comment}
                    <span class="icon icon-arrow-right text-success pls"></span>
                </a>
                {/if}
            {/if}
        </div>
        <div class="feedback modal modal-docked modal-docked-right" id="feedbacktable_0{$post->id}{$options.blockid}">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header clearfix">
                        <button class="deletebutton close" data-dismiss="modal">
                            <span class="times">&times;</span>
                            <span class="sr-only">{str tag=Close}</span>
                        </button>
                        <h4 class="modal-title pull-left">
                            <span class="icon icon-lg icon-comments prm"></span>
                            {str tag=Comments section=artefact.comment} -
                            {$post->title}
                        </h4>
                        {if $post->allowcomments}
                        <a class="addcomment pull-right" href="{$WWWROOT}artefact/artefact.php?artefact={$post->id}&view={$options.viewid}">
                            {str tag=addcomment section=artefact.comment}
                            <span class="icon icon-arrow-right pls"></span>
                        </a>
                        {/if}
                    </div>
                    <div class="modal-body">
                    {$post->comments->tablerows|safe}
                    </div>
                </div>
            </div>
        </div>
        {/if}
    </div>
{/foreach}
