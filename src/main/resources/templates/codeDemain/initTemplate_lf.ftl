<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<div class="breadcrumbs">
    <ul th:replace="bk/ul::breadcrumb('主页面', '**管理', '${MENUNAME}管理')"/>
    <div class="page-content">
        <div class="row">
            <div class="col-sm-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <form th:action="@{/bk/${CLASS_NAME_LINK}/list}" id="objForm" onsubmit="return false;">
                            <div class="form-group">
                                <div class="row">
                                <#list inits as data>
                                    <#if data.data_Type == "Date">
                                        <div class="col-xs-3 col-md-3" style="margin-top:4px;">
                                            <input type="text" name="search_GT_${data.column_Name}" id="x"
                                                   placeholder="${data.columnComment}" title="${data.columnComment}"
                                                   onClick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true,readOnly:true})"
                                                   class="form-control"  placeholder="请输入${data.columnComment}"
                                                   th:value="${data.symbol}{param.search_GT_${data.column_Name}}"/>
                                        </div>
                                    <#else>
                                        <div class="col-xs-3 col-md-3" style="margin-top:4px;">
                                            <input type="text" name="search_LIKE_${data.column_Name}"
                                                   id="search_EQ_${data.column_Name}"
                                                   class="form-control"  placeholder="请输入${data.columnComment}"
                                                   th:value="${data.symbol}{param.search_EQ_${data.column_Name}}"/>
                                        </div>
                                    </#if>
                                </#list>
                                    <button th:replace="bk/button::search('search_btn', 'objForm')"/>
                                    <button th:replace="bk/button::clear('objForm')"/>
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
<script th:replace="bk/js::initSearch('search_btn', 'objForm')"/>
</html>