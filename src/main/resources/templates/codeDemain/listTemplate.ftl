<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${symbol}{pageContext.request.contextPath}" />
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
                <c:forEach items="${symbol}{objs.content}" var="obj">
                    <tr>
                        <#list lists as data>
                        <td>
                            <#if data.data_Type == "Date">
                                <fmt:formatDate value="${symbol}{obj.${data.column_Name} }"
                                                pattern="yyyy年MM月dd日 HH:mm:ss E" />
                            <#elseif data.data_Type == "String">
                                ${symbol}{obj.${data.column_Name} }
                            <#elseif data.columnKey == "PRI" >
                                ${symbol}{obj.${data.column_Name} }
                            <#else >
                                <fmt:formatNumber value="${symbol}{obj.${data.column_Name} }" pattern="￥,#00.00元" />
                            </#if>
                        </td>
                        </#list>
                        <td><a class="btn btn-default" href="#" onclick="updateObj('${symbol}/bk/${CLASS_NAME_LINK}/update/${symbol}{obj.id }')" title="修改">修改</a></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-lg-4">
        <div class="row">
            <div class="col-lg-3">
                <a class="btn btn-default" href="#" onclick="createObj('${symbol}{ctx}/bk/mg/${CLASS_NAME_LINK}/add')">新增</a>
            </div>
        </div>
    </div>
    <div class="col-lg-8 text-right" style="padding-right: 15px;">
        <tags:pagination page="${symbol}{objs}" paginationSize="9" />
    </div>
</div>