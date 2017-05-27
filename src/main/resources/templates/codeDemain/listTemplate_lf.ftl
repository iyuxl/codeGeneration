<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<div class="row">
    <div class="col-lg-12">
        <div class="table-responsive">
            <table class="table table-bordered table-hover table-striped">
                <thead>
                <tr>
                    <#list lists as data>
                        <th>${data.columnComment}</th>
                    </#list>
                        <th>操作</th>
                </tr>
                </thead>
                <tbody>
                    <tr th:each="obj : ${symbol}{objs.content}">
                        <#list lists as data>
                        <td <#if data.data_Type == "Date"> th:utext="${symbol}{#dates.format(obj.${data.column_Name}, 'yyyy年MM月dd日 HH:mm:ss E')}">
                            <#elseif data.data_Type == "String"> th:utext="${symbol}{obj.${data.column_Name}}">
                            <#elseif data.columnKey == "PRI" > th:utext="${symbol}{obj.${data.column_Name}}">
                            <#else > th:text="${symbol}{#numbers.formatDecimal(obj.${data.column_Name}, 1, 2)}">
                            </#if>
                        </td>
                        </#list>
                        <td><a class="btn btn-default" href="#" th:onclick="'javascript:updateObj(&quot;/bk/${CLASS_NAME_LINK}/update/' + ${symbol}{obj.id } + '&quot;);'" title="修改">修改</a></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-lg-4">
        <div class="row">
            <div class="col-lg-3">
                <a class="btn btn-default" href="#" onclick="createObj('/bk/mg/${CLASS_NAME_LINK}/add')">新增</a>
            </div>
        </div>
    </div>
    <div class="col-lg-8 text-right" style="padding-right: 15px;" th:replace="/bk/pagination::page">
    </div>
</div>
</html>