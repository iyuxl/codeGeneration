<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<div class="row">
    <div class="col-lg-12">
        <h4 class="page-header">XXXX管理</h4>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <form  action="#" id="objForm"  onsubmit="return false;" >
                    <div class="form-group">
                        <div class="row">
                        <#list inits as data>
                            <#if data.data_Type == "Date">
                                <div class="col-xs-3 col-md-3">
                                    <input type="text" name="search_GT_${data.column_Name}" id="x" placeholder="${data.columnComment}" title="${data.columnComment}"
                                           onClick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true,readOnly:true})"
                                           class="form-control" th:value="${data.symbol}{param.search_GT_${data.column_Name}}" />
                                </div>
                            <#else>
                                <div class="col-xs-3 col-md-3">
                                    <input type="text" name="search_LIKE_${data.column_Name}" id="search_EQ_${data.column_Name}"
                                           class="form-control" th:value="${data.symbol}{param.search_EQ_${data.column_Name}}" />
                                </div>
                            </#if>
                        </#list>
                            <button type="button" class="btn btn-default" id="search_btn" onclick="goObjs()">查 询</button>
                            <button type="button" class="btn btn-danger" onclick="clearForm('objForm')">清 空</button>
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
<script type="text/javascript">
    $('#search_EQ_xxx').keydown(function(event) {
        if (event.keyCode == 13) {
            goObjs();
        }
    });
    function goObjs() {
        showWait();
        var param = $("#objForm").serialize();
        $("#listResult").load("/bk/${CLASS_NAME_LINK}/list", param, function() {
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
        goObjs();
    });
</script>
</html>