<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<div class="container-fluid">
    <div class="row">
        <div class="col-sm-12" id="objContext">
            <form role="form" id="objSaveForm" th:action="@{/bk/${CLASS_NAME_LINK}/create}" onsubmit="return false;">
            <#list adds as data>
                <#if data.columnKey == "PRI" >
                    <input type="hidden" name="${data.column_Name}"
                           th:value="*{obj != null}? *{obj.${data.column_Name}} : ''"/>
                <#else >
                    <div class="form-group">
                        <label><#if data.isNullable == "NO">*</#if>${data.columnComment}:</label>
                        <input type="text" name="${data.column_Name}" title="${data.columnComment}"
                               placeholder="${data.columnComment}"
                               th:value="*{obj != null}? *{obj.${data.column_Name}} : ''"
                               class="form-control" notnull="<#if data.isNullable == "NO">true</#if>"
                               comment="${data.columnComment}"/>
                    </div>
                </#if>
            </#list>
                <button type="button" class="btn btn-lg btn-success btn-block" id="objSaveFormButton"
                        th:onclick="'javascript:goSave(&quot;' + @{/bk/${CLASS_NAME_LINK}/create} + '&quot;, ${symbol}(&quot;#objSaveForm&quot;), &quot;objForm&quot;, &quot;editModal&quot;);'">
                    保 存
                </button>
            </form>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $('#objSaveForm input').each(function () {
            $(this).keydown(function (event) {
                if (event.keyCode == 13) {
                    $("#objSaveFormButton", $("#objSaveForm")).click();
                }
            });
        })
    });
</script>
</html>