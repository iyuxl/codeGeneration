<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<div class="container-fluid">
    <div class="row">
        <div class="col-lg-12" id="objContext">
            <form role="form" id="objSaveForm" th:action="@{/bk/${CLASS_NAME_LINK}/create}" onsubmit="return false;">
                    <#list adds as data>
                    <#if data.columnKey == "PRI" >
                        <input type="hidden" name="${data.column_Name}" th:value="*{obj != null}? *{obj.${data.column_Name}} : ''">
                    <#else >
                    <div class="form-group">
                        <label><#if data.isNullable == "NO">*</#if>${data.columnComment}:</label>
                        <input type="text" name="${data.column_Name}" title="${data.columnComment}" placeholder="${data.columnComment}" th:value="*{obj != null}? *{obj.${data.column_Name}} : ''"
                               class="form-control" notnull="<#if data.isNullable == "NO">true</#if>" >
                    </div>
                    </#if>
                    </#list>
                <button type="button" class="btn btn-lg btn-success btn-block" onclick="goSave('/bk/${CLASS_NAME_LINK}/create', ${symbol}('#objSaveForm'), 'objForm', 'editModal')">保  存</button>
            </form>
        </div>
    </div>
</div>
</html>