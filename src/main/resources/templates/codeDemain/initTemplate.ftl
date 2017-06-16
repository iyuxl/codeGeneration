<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${symbol}{pageContext.request.contextPath}" />
<c:set var="header_title">XXX管理</c:set>
<c:set var="search_conditon">
    <form action="#" id="objForm"
          onsubmit="return false;">
        <div class="form-group">
            <div class="row">
                <#list inits as data>
                    <#if data.data_Type == "Date">
                <div class="col-xs-3 col-md-3">
                    <input type="text" name="search_GT_${data.column_Name}" id="x" placeholder="${data.columnComment}" title="${data.columnComment}"
                           onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true,readOnly:true})"
                           class="form-control" value="${data.symbol}{param.search_GT_${data.column_Name}}">
                </div>
                <#else>
                <div class="col-xs-3 col-md-3">
                    <input type="text" name="search_LIKE_${data.column_Name}" id="search_LIKE_${data.column_Name}"
                           class="form-control" value="${data.symbol}{param.search_LIKE_${data.column_Name}}">
                </div>
                </#if>
                </#list>
                <button type="button" class="btn btn-default" id="search_btn" onclick="goObjs()">查 询</button>
            </div>
        </div>
    </form>
</c:set>
<%@ include file="/WEB-INF/views/bk/normal/layout.jsp"%>
<script type="text/javascript" src="${symbol}{ctx }/my97datepicker/WdatePicker.js"></script>
<script type="text/javascript">
    $('#search_EQ_xxx').keydown(function(event) {
        if (event.keyCode == 13) {
            goObjs();
        }
    });
    function goObjs() {
        showWait();
        var param = $("#objForm").serialize();
        $("#listResult").load("${symbol}{ctx}/bk/${CLASS_NAME_LINK}/list", param, function() {
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