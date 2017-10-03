<!DOCTYPE html>
<#assign ctx = request.contextPath>
<html>
    <head>
        <title>代码生成</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- 引入 Bootstrap -->
        <link href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

        <!-- HTML5 Shim 和 Respond.js 用于让 IE8 支持 HTML5元素和媒体查询 -->
        <!-- 注意： 如果通过 file://  引入 Respond.js 文件，则该文件无法起效果 -->
        <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
        <![endif]-->
        <link href="${ctx}/jquery-loadmask-0.4/jquery.loadmask.css" rel="stylesheet" type="text/css" />

    </head>
    <body>
    <div class="container">
        <h1>Hello, world! 代码生成啦啦啦</h1>
        <div class="row">
            <p>
                输入需要生成的表名/数据库名
            </p>
            <div class="col-md-4">
                <div class="row">
                    <form class="form-inline" role="form" id="objForm">
                        <div class="form-group">
                            <input type="text" class="form-control" id="tableName" name="tableName" placeholder="table_name">
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control" id="tableSchema" name="tableSchema" placeholder="table_schema">
                        </div>

                        <button type="button" class="btn btn-default" id="search_btn"
                                onclick="goObjs()">查询</button>
                    </form>
                </div>
            </div>
            <div class="col-md-8">
                <form class="form-inline" role="form" id="listForm">
                    <input type="hidden" name="tableSchema" id="list_tableSchema">
                    <input type="hidden" name="tableName" id="list_tableName">

                    <div class="row">
                    <div class="form-group">
                        <input type="text" class="form-control" id="className" name="className" placeholder="类名">
                    </div><div class="form-group">
                        <input type="text" class="form-control" id="menuName" name="menuName" placeholder="菜单名">
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control" id="packageName" name="packageName" placeholder="packageName">
                    </div>
                        <div class="form-group">
                            <input type="text" class="form-control" id="mk" name="mk" placeholder="模块">
                        </div>
                    <div class="form-group">
                        <input type="checkbox" class="ttt" name="service" value="false"/>生成service
                    </div>
                    <div class="form-group">
                        <input type="checkbox" class="ttt" name="controller" value="false"/>生成controller
                    </div>
                        <div class="form-group">
                            <input type="checkbox" class="ttt" name="lf" value="false"/>目标thymeleaf
                        </div>
                    <button type="button" class="btn btn-default" id="search_btn"
                            onclick="goGeneration('${ctx}/code/save', $('#listForm'))">生成</button>
                </div>
                <div class="row" id="listResult">
                   <table class="table">
                       <caption>字段明细</caption>
                       <thead>
                       <tr>
                           <th>产品</th>
                           <th>付款日期</th>
                           <th>状态</th></tr>
                       </thead>
                       <tbody>
                       <tr class="active">
                           <td>产品1</td>
                           <td>23/11/2013</td>
                           <td>待发货</td></tr>
                       <tr class="success">
                           <td>产品2</td>
                           <td>10/11/2013</td>
                           <td>发货中</td></tr>
                       <tr class="warning">
                           <td>产品3</td>
                           <td>20/10/2013</td>
                           <td>待确认</td></tr>
                       <tr class="danger">
                           <td>产品4</td>
                           <td>20/10/2013</td>
                           <td>已退货</td></tr>
                       </tbody>
                   </table>
               </div>
                </form>
            </div>
        </div>
    </div>
    <div class="modal fade" id="messageModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">信息提示</h4>
                </div>
                <div class="modal-body" id="messageContext">
                    <p>努力加载中&hellip;</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->


    <div class="modal fade" id="editModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">信息提示</h4>
                </div>
                <div class="modal-body" id="editContext">
                    <p>努力加载中&hellip;</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

    <div class="modal fade" id="errorModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">信息提示</h4>
                </div>
                <div class="modal-body">
                    <div class="alert alert-warning" id="errorContext" role="alert">...</div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="${ctx}/js/sys.js"></script>
    <script src="${ctx}/jquery-loadmask-0.4/jquery.loadmask.min.js"></script>
    <script>
        $(document).ready(function(){
            $("#tableSchema").keydown(function(event) {
                if (event.keyCode == 13) {
                    goObjs();
                }
            });
            $(".ttt").click(function(event) {
                if ($(this).val() == true) {
                    $(this).val("false");
                } else {
                    $(this).val("true");
                }
            });
        });

        function goObjs() {
            $("#list_tableName").val($("#objForm input[id='tableName']").val());
            $("#list_tableSchema").val($("#objForm input[id='tableSchema']").val());
            var param = $("#objForm").serialize();
            showWait();
            $("#listResult").load("${ctx}/code/list", param, function() {
                closeWait();
            });
        }
        
        function goGeneration(url, form) {
            showWait();
            $.ajax({
                url : url,
                data : $(form).serialize(),
                dataType : 'json',
                type : 'post',
                success : function(data, textStatus) {
                    if (data.flag) {
                        alert("代码生成成功！");
                    } else {
                        if(data.msg != "")
                            errorModal(data.msg);
                        else
                            errorModal("系统卖力响应，但是发生意外。。。");
                    }
                },
                error : function(errors, textStatus) {
                    if ("timeout" == textStatus) {
                        errorModal("系统请求超时，请联系管理员！");
                    } else {
                        errorModal("系统发生未知异常！");
                    }
                },
                complete : function(XMLHttpRequest, textStatus) {
                    closeWait();
                }
            });
        }
    </script>
    </body>
</html>