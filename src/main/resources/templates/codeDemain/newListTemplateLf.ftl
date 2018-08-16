<!DOCTYPE html>

<html xmlns:th="http://www.thymeleaf.org" xmlns:layout="http://www.ultraq.net.nz/web/thymeleaf/layout"
      layout:decorate="${symbol}{mainContent}">
<body>
<div layout:fragment="content">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body">
                        <div class="toolbar">
                            <form th:action="@{/bk/${CLASS_NAME_LINK}/list}" id="objForm" class="form-horizontal">
                                <div class="row">
                                <#list inits as data>
                                    <#if data.data_Type == "Date">
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <label class="bmd-label-floating"
                                                       for="search_GT_${data.column_Name}">${data.columnComment}</label>
                                                <input type="text" name="search_GT_${data.column_Name}"
                                                       id="search_GT_${data.column_Name}"
                                                       title="${data.columnComment}"
                                                       class="form-control datetimepicker" rel="tooltip"
                                                       placeholder="请输入${data.columnComment}"
                                                       th:value="${data.symbol}{param.search_GT_${data.column_Name}}"/>
                                            </div>
                                        </div>
                                    <#else>
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <label class="bmd-label-floating"
                                                       for="search_EQ_${data.column_Name}">${data.columnComment}</label>
                                                <input type="text" name="search_EQ_${data.column_Name}"
                                                       id="search_EQ_${data.column_Name}"
                                                       class="form-control"
                                                       placeholder="请输入${data.columnComment}"
                                                       th:value="${data.symbol}{param.search_EQ_${data.column_Name}}"/>
                                            </div>
                                        </div>
                                    </#if>
                                </#list>
                                </div>
                                <div class="row">
                                    <div class="col-md-5">
                                        <button th:replace="bk/button::search('search_btn', 'objForm')"/>
                                        <button th:replace="bk/button::clear('objForm')"/>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <div class="material-datatables">
                            <table id="datatables" class="table table-striped table-no-bordered table-hover"
                                   cellspacing="0" width="100%" style="width:100%">
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
                                <tfoot>
                                <tr>
                                <#list lists as data>
                                    <th>${data.columnComment}</th>
                                </#list>
                                    <th>
                                        <a th:replace="bk/button::goEditGreen(@{/bk/mg/${CLASS_NAME_LINK}/add}, '新增${MENUNAME}')"/>
                                    </th>
                                </tr>
                                </tfoot>

                                <tbody>
                                <!--/*/ <th:block th:if="${symbol}{objs != null}"> /*/-->
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
                                    <td class="td-actions text-left">
                                        <a th:replace="bk/button::goEdit(@{/bk/${CLASS_NAME_LINK}/update/} + ${symbol}{obj.id }, '修改${MENUNAME}')"/>
                                        <a th:replace="bk/button::goDelIcons(@{/bk/${CLASS_NAME_LINK}/delete/} + ${symbol}{obj.id }, 'objForm', ${symbol}{@sys.getDel()})"/>
                                    </td>
                                </tr>
                                <!--/*/ </th:block> /*/-->

                                <!--/*/ <th:block th:if="${symbol}{objs == null}"> /*/-->
                                <div th:replace="bk/pagination::firstContent"></div>
                                <!--/*/ </th:block> /*/-->
                                </tbody>
                            </table>
                            <div class="dataTables_wrapper dt-bootstrap4">
                                <script th:replace="bk/pagination::page('datatables')"></script>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script th:replace="bk/js::initSearch('search_btn', 'objForm')"/>
</div>
</body>
</html>