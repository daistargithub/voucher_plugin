{extends file="$layouts_admin"}
{block name="style"}
<link rel="stylesheet" type="text/css" href="{$app_url}ui/lib/footable/css/footable.core.min.css" />
    <link rel="stylesheet" type="text/css" href="{$app_url}apps/voucher/views/css/global.css" />
{/block}
{block name="content"}
    <div class="row">

        <div class="col-md-8">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>
                        {if $type eq 'add'}
                            Add Voucher Page Form
                        {else}
                            Edit Voucher Page Form
                        {/if}
                    </h5>
                </div>
                <div class="ibox-content" id="ibox_form">
                    <div class="alert alert-danger" id="emsg">
                        <span id="emsgbody"></span>
                    </div>

                    <form class="form-horizontal" id="rform">

                        <div class="form-group">
                            <label class="col-md-2 control-label" for="title">Title <small class="red">*</small></label>

                            <div class="col-md-10">
                                <input type="text" id="title" name="title" class="form-control" value="{$val['title']}" autocomplete="off">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-2 control-label" for="payment">Payment</label>

                            <div class="col-md-10">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" class="i-checks" name="payment_req" value="1" {if $val['payment_req'] eq '1'}checked{/if}>
                                        Require Payment
                                    </label>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-2 control-label" for="product">Product <small class="red">*</small></label>

                            <div class="col-md-10">

                                <select id="product" name="product_id" class="form-control" style="width:100%">
                                    <option value="">Select Product</option>
                                    {foreach $product_list as $p}
                                        <option value="{$p['id']}" {if $p['id'] eq $val['product_id']}selected{/if} >{$p['name']}</option>
                                    {/foreach}
                                </select>
                                <span class="help-block">
                                    Select existing created product
                                </span>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-2 control-label" for="status_id">Status <small class="red">*</small></label>

                            <div class="col-md-10">

                                <select id="status_id" name="status_id" class="form-control" style="width:100%">
                                    <option value="{$val['status_id']}" selected>{$val['status_id']}</option>
                                    <option value="redeem" >Redeem</option>
                                    <option value="pending" >Pending</option>
                                    <option value="confirm" >Confirm</option>

                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-2 control-label" for="address">Address</label>

                            <div class="col-md-10">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" class="i-checks" name="address" value="1" {if $val['address'] eq '1'}checked{/if}>
                                         Include user address
                                    </label>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-2 control-label" for="date_range">Date Range</label>

                            <div class="col-md-10">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" class="i-checks" name="date_range" value="1" {if $val['date_range'] eq '1'}checked{/if}>
                                         Include depart & return date
                                    </label>
                                </div>
                            </div>
                        </div>


                        <div class="form-group"><label class="col-md-2 control-label" for="remark">Remark</label>

                            <div class="col-md-10"><textarea id="remark" name="remark" class="form-control" rows="4"></textarea>

                            </div>
                        </div>


                        <input type="hidden" name="pid" id="pid" value="{$pid}">
                        <input type="hidden" name="vid" id="vid" value="{$vid}">
                        <input type="hidden" name="front_img" id="front_img" value="{$val['front_img']}">
                        <input type="hidden" name="back_img" id="back_img" value="{$val['back_img']}">


                    </form>
                </div>

                <div class="ibox-title">
                    <h5>
                       Custom Field
                    </h5>
                </div>
                <div class="ibox-content" id="application_ajaxrender">

                    <form class="form-horizontal" id="cform">

                        {foreach $cf as $c}
                            <div class="form-group">
                                <label class="col-lg-4 control-label" for="cf{$c['id']}">{$c['fieldname']}</label>
                                {if ($c['fieldtype']) eq 'text'}

                                    <div class="col-lg-4">
                                        <input type="text" id="cf{$c['id']}" name="cf{$c['id']}" class="form-control">
                                        {if ($c['description']) neq ''}
                                            <span class="help-block">{$c['description']}</span>
                                        {/if}
                                    </div>

                                {elseif ($c['fieldtype']) eq 'password'}

                                    <div class="col-lg-4">
                                        <input type="password" id="cf{$c['id']}" name="cf{$c['id']}" class="form-control">
                                        {if ($c['description']) neq ''}
                                            <span class="help-block">{$c['description']}</span>
                                        {/if}
                                    </div>

                                {elseif ($c['fieldtype']) eq 'dropdown'}
                                    <div class="col-lg-4">
                                        <select id="cf{$c['id']}" class="form-control">
                                            {foreach explode(',',$c['fieldoptions']) as $fo}
                                                <option>{$fo}</option>
                                            {/foreach}
                                        </select>
                                        {if ($c['description']) neq ''}
                                            <span class="help-block">{$c['description']}</span>
                                        {/if}
                                    </div>


                                {elseif ($c['fieldtype']) eq 'textarea'}

                                    <div class="col-lg-4">
                                        <textarea id="cf{$c['id']}" name="cf{$c['id']}" class="form-control" rows="3"></textarea>
                                        {if ($c['description']) neq ''}
                                            <span class="help-block">{$c['description']}</span>
                                        {/if}
                                    </div>

                                {elseif ($c['fieldtype']) eq 'date'}

                                    <div class="col-lg-4">
                                        <input type="text" id="cf{$c['id']}" name="cf{$c['id']}" class="form-control" datepicker data-date-format="yyyy-mm-dd" data-auto-close="true">



                                        {if ($c['description']) neq ''}
                                            <span class="help-block">{$c['description']}</span>
                                        {/if}

                                    </div>
                                {else}

                                {/if}
                                <div class="col-lg-4"><a href="#" class="btn btn-primary sys_edit" id="f{$c['id']}"><i class="fa fa-pencil"></i> {$_L['Edit']}</a>

                                    <a href="#" class="btn btn-danger cdelete" id="d{$c['id']}"><i class="fa fa-trash"></i> {$_L['Delete']}</a>


                                </div>
                            </div>
                            {foreachelse}

                            <h4 class="muted text-center">{$_L['Custom Fields Not Available']}</h4>

                        {/foreach}
                        <p class=" text-center"><a href="" class="btn btn-outline btn-success sys_add"><i class="fa fa-plus"></i> {$_L['Add Custom Field']}</a></p>


                    </form>

                </div>
                <div class="ibox-content" id="ibox-form_submit">
                    <div class="form-group">
                        <div class="col-md-offset-2 col-md-10" style="text-align:right">
                            {if $type eq 'add'}
                                <button class="btn btn-primary" type="submit" id="submit"><i class="fa fa-check"></i>{$_L['Submit']}</button>
                            {else}
                                <button class="btn btn-primary" type="submit" id="submit"><i class="fa fa-check"></i>{$_L['Update']}</button>
                            {/if}
                        </div>
                    </div>
                </div>
                <br>
                <br>

            </div>
        </div>

        <div class="col-md-4">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    Upload Voucher Front
                </div>
                <div class="ibox-content" id="ibox_form">

                    <form action="" class="dropzone" id="upload_container1">

                        <div class="dz-message">
                            <h3> <i class="fa fa-cloud-upload"></i>  {$_L['Drop File Here']}</h3>
                            <br />
                            <span class="note">{$_L['Click to Upload']}</span>
                        </div>

                    </form>

                </div>

                <div class="ibox-content" id="ibox_form" style="text-align: center;">
                    {if $type neq 'add'}
                        <img id="voucher_front" src="{$baseUrl}/apps/voucher/public/voucher_imgs/{$val['front_img']}" style="border:1px solid darkgray" width="100%">
                    {else}
                        <img id="voucher_front" src="" style="border:1px solid darkgray" width="100%">
                    {/if}
                </div>
            </div>

            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    Upload Voucher Back
                </div>
                <div class="ibox-content" id="ibox_form">

                    <form action="" class="dropzone" id="upload_container2">

                        <div class="dz-message">
                            <h3> <i class="fa fa-cloud-upload"></i>  {$_L['Drop File Here']}</h3>
                            <br />
                            <span class="note">{$_L['Click to Upload']}</span>
                        </div>

                    </form>

                </div>

                <div class="ibox-content" id="ibox_form" style="text-align: center;">
                    {if $type neq 'add'}
                        <img id="voucher_back" src="{$baseUrl}/apps/voucher/public/voucher_imgs/{$val['back_img ']}" style="border:1px solid darkgray"  width="100%">
                    {else}
                        <img id="voucher_back" src="" style="border:1px solid darkgray" width="100%">
                    {/if}
                </div>
            </div>

        </div>


    </div>
{/block}
{block name=script}
    <script type="text/javascript" src="{$app_url}apps/voucher/views/js/add_page.js"></script>
    <script type="text/javascript" src="{$app_url}apps/voucher/views/js/custom_fields.js"></script>
{/block}
