<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org" xmlns:layout="http://www.ultraq.net.nz/web/thymeleaf/layout"
      layout:decorate="${symbol}{mainContent}">
<body>
<div layout:fragment="content">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
                <div class="card ">
                    <div class="card-header card-header-rose card-header-text">
                        <div class="card-text">
                            <h4 class="card-title">${MENUNAME}维护</h4>
                        </div>
                    </div>
                    <div class="card-body ">
                        <form class="form-horizontal" role="form" id="objSaveForm" method="post"
                              th:action="@{/bk/${CLASS_NAME_LINK}/create}"
                              onsubmit="return false;">
                        <#list adds as data>
                            <#if data.columnKey == "PRI" >
                                <input type="hidden" name="${data.column_Name}"
                                       th:value="*{obj != null}? *{obj.${data.column_Name}} : ''"/>
                            <#else >
                                <div class="row">
                                    <label class="col-sm-2 col-form-label"><#if data.isNullable == "NO">
                                        *</#if>${data.columnComment}</label>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <input type="text" name="${data.column_Name}"
                                                   title="${data.columnComment}"
                                                   placeholder="${data.columnComment}"
                                                   th:value="*{obj != null}? *{obj.${data.column_Name}} : ''"
                                                   class="form-control"
                                                   notnull="<#if data.isNullable == "NO">true<#else >false</#if>"
                                                   comment="${data.columnComment}"/>
                                        </div>
                                    </div>
                                </div>
                            </#if>
                        </#list>
                        </form>
                    </div>
                    <div class="card-footer ml-auto mr-auto">
                        <div class="row" id="objSaveFormRow">
                            <div class="col-md-6" th:insert="bk/button::save (@{/bk/${CLASS_NAME_LINK}/create})"/>
                            <div class="col-md-6" th:insert="bk/button::goBack (@{/bk/${CLASS_NAME_LINK}/list})"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script th:replace="bk/js::initSave('objSaveFormButton', 'objSaveForm')"/>
</div>
</body>
</html>