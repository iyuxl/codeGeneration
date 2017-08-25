<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<div class="row">
    <div class="col-sm-12">
        <div class="table-responsive">
            <table id="dataTables-example" class="table table-bordered table-hover table-striped">
                <thead>
                <tr>
                <#list lists as data>
                    <th>${data.columnComment}</th>
                </#list>
                    <th><a class="badge badge-success" href="#" onclick="createObj('/bk/mg/${CLASS_NAME_LINK}/add')">新增</a>
                    </th>
                </tr>
                </thead>
                <tbody>
                <tr th:each="obj : ${symbol}{objs.content}">
                <#list lists as data>
                    <td <#if data.data_Type == "Date"> th:text="${symbol}{#dates.format(obj.${data.column_Name}, 'yyyy年MM月dd日 HH:mm:ss E')}">
                    <#elseif data.data_Type == "String"> th:text="${symbol}{obj.${data.column_Name}}">
                    <#elseif data.columnKey == "PRI" > th:text="${symbol}{obj.${data.column_Name}}">
                    <#else > th:text="${symbol}{#numbers.formatDecimal(obj.${data.column_Name}, 1, 2)}">
                    </#if>
                    </td>
                </#list>
                    <td><a class="badge badge-warning" href="#" th:onclick="'javascript:updateObj(&quot;/bk/${CLASS_NAME_LINK}/update/' + ${symbol}{obj.id } + '&quot;);'" title="修改">修改</a></td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
<div class="row" style="background: #f5f5f5;">
    <div class="col-sm-4" style="margin-top: 13px;">
        <a class="btn btn-success btn-sm" href="#" onclick="createObj('/bk/mg/${CLASS_NAME_LINK}/add')" style="width:74px;">新增</a>
    </div>
    <div class="col-sm-8 text-right" style="padding-right: 15px;" th:insert="bk/pagination::page">
    </div>
</div>
</html>