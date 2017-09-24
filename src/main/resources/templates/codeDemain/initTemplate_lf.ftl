<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<div class="breadcrumbs">
    <ul class="breadcrumb">
        <li>
            <i class="ace-icon fa fa-home home-icon"></i>
            <a href="#">主页面</a>
        </li>
        <li>
            <a href="#">上级目录名称</a>
        </li>
        <li class="active">当前目录名称</li>
    </ul>
    <div class="page-content">
        <#--<div class="page-content-area">
            <div class="page-header">
                <h1>当前目录名称
                    <small><i class="ace-icon fa fa-angle-double-right"></i>
                        页面内容简介
                    </small></h1>
            </div>
        </div>-->
        <div class="row">
            <div class="col-sm-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <form  action="#" id="objForm"  onsubmit="return false;" >
                            <div class="form-group">
                                <div class="row">
                                <#list inits as data>
                                    <#if data.data_Type == "Date">
                                        <div class="col-xs-3 col-md-3" style="margin-top:4px;">
                                            <input type="text" name="search_GT_${data.column_Name}" id="x" placeholder="${data.columnComment}" title="${data.columnComment}"
                                                   onClick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true,readOnly:true})"
                                                   class="form-control" th:value="${data.symbol}{param.search_GT_${data.column_Name}}" />
                                        </div>
                                    <#else>
                                        <div class="col-xs-3 col-md-3" style="margin-top:4px;">
                                            <input type="text" name="search_LIKE_${data.column_Name}" id="search_EQ_${data.column_Name}"
                                                   class="form-control" th:value="${data.symbol}{param.search_EQ_${data.column_Name}}" />
                                        </div>
                                    </#if>
                                </#list>
                                    <button type="button" class="btn btn-sm btn-info" id="search_btn" onclick="goObjs()">查 询</button>
                                    <button type="button" class="btn btn-sm btn-default" onclick="clearForm('objForm')">清 空</button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <div class="dataTable_wrapper" id="listResult"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    function goObjs() {
        showWait();
        var param = $("#objForm").serialize();
        $("#listResult").load("[[@{/bk/${CLASS_NAME_LINK}/list}]]", param, function() {
            closeWait();
        });
    }

    function createObj(url) {
        normalModal("editModal", "editContext", url, "xxx新增")
    }

    function updateObj(url) {
        normalModal("editModal", "editContext", url, "xxx修改")
    }

    $(document).ready(function() {
        ('#objForm input').each(function () {
            $(this).keydown(function (event) {
                if (event.keyCode == 13) {
                    goObjs();
                }
            });
        });
        goObjs();
    });
</script>
</html>