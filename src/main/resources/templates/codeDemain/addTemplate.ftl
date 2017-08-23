<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${symbol}{pageContext.request.contextPath}" />
<div class="container-fluid">
    <div class="row">
        <div class="col-sm-12" id="objContext">
            <form role="form" id="objSaveForm">
                    <#list adds as data>
                    <#if data.columnKey == "PRI" >
                        <input type="hidden" name="${data.column_Name}" value="${symbol}{obj.${data.column_Name} }">
                    <#else >
                    <div class="form-group">
                        <label>*${data.columnComment}:</label>
                        <input type="text" name="${data.column_Name}" title="${data.columnComment}" placeholder="${data.columnComment}"
                               class="form-control" notnull="true" value="${symbol}{obj.${data.column_Name} }">
                    </div>
                    </#if>
                    </#list>
                <button type="button" class="btn btn-lg btn-success btn-block" onclick="goSave('${symbol}{ctx}/bk/${CLASS_NAME_LINK}/create', ${symbol}('#objSaveForm'), 'objForm', 'editModal')">保  存</button>
            </form>
        </div>
    </div>
</div>