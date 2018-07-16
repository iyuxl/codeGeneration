<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<div class="container-fluid">
    <div class="row" id="objContext">
        <form class="form-horizontal" role="form" id="objSaveForm" th:action="@{/bk/${CLASS_NAME_LINK}/create}"
              onsubmit="return false;">
        <#list adds as data>
            <#if data.columnKey == "PRI" >
                <input type="hidden" name="${data.column_Name}"
                       th:value="*{obj != null}? *{obj.${data.column_Name}} : ''"/>
            <#else >
                <div class="form-group">
                    <label class="col-sm-2 control-label no-padding-right"><#if data.isNullable == "NO">
                        *</#if>${data.columnComment}:</label>
                    <div class="col-sm-9">
                        <input type="text" name="${data.column_Name}" title="${data.columnComment}"
                               placeholder="${data.columnComment}"
                               th:value="*{obj != null}? *{obj.${data.column_Name}} : ''"
                               class="form-control" notnull="<#if data.isNullable == "NO">true</#if>"
                               comment="${data.columnComment}"/>
                    </div>
                </div>
            </#if>
        </#list>
            <div class="space-4"></div>
            <div class="form-group">
                <div class="col-md-2"></div>
                <div class="col-md-9" th:insert="bk/button::save (@{/bk/${CLASS_NAME_LINK}/create})"/>
            </div>
        </form>
    </div>
</div>
<script th:replace="bk/js::initSave('objSaveFormButton', 'objSaveForm')"/>
</html>