<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<div class="row">
    <div class="col-sm-12">
<#--
        <div class="table-responsive">
-->
            <table id="dataTables-example" class="table table-bordered table-hover table-striped">
                <thead>
                <tr>
                <#list lists as data>
                    <th>${data.columnComment}</th>
                </#list>
                    <th>
                        <a th:replace="bk/button::goEditGreen(@{/bk/mg/${CLASS_NAME_LINK}/add}, '新增${MENUNAME}')"/>
                    </th>
                </tr>
                </thead>
                <tbody>
                <tr th:each="obj : ${symbol}{objs.content}">
                <#list lists as data>
                    <td <#if data.data_Type == "Date">
                            th:text="${symbol}{#dates.format(obj.${data.column_Name}, 'yyyy年MM月dd日 HH:mm:ss E')}">
                    <#elseif data.data_Type == "String"> th:text="${symbol}{obj.${data.column_Name}}">
                    <#elseif data.columnKey == "PRI" > th:text="${symbol}{obj.${data.column_Name}}">
                    <#else > th:text="${symbol}{#numbers.formatDecimal(obj.${data.column_Name}, 1, 2)}">
                    </#if>
                    </td>
                </#list>
                    <td>
                        <a th:replace="bk/button::goEditYellow(@{/bk/${CLASS_NAME_LINK}/update/} + ${symbol}{obj.id }, '修改${MENUNAME}')"/>
                        <a th:replace="bk/button::goDel(@{/bk/${CLASS_NAME_LINK}/delete/} + ${symbol}{obj.id }, 'objForm', ${symbol}{@sys.getDel()})"/>
                    </td>
                </tr>
                </tbody>
            </table>
<#--
        </div>
-->
    </div>
</div>
<div id="bbar" class="row pagination-row ">
    <div class="col-sm-4 pagination-button">
        <a th:replace="bk/button::goEditGreen2(@{/bk/mg/${CLASS_NAME_LINK}/add}, '新增${MENUNAME}')"/>
    </div>
    <div class="col-sm-8 text-right pagination-right" th:insert="bk/pagination::page"/>
</div>
</html>