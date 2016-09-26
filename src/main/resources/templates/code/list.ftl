<table class="table">
    <caption>${table}字段明细</caption>
    <thead>
    <tr>
        <th colspan="3">操作</th>
        <th>columnName</th>
        <th>dataType</th>
        <th>columnType</th>
        <th>columnComment</th>
        <th>columnKey</th>
        <th>characterMaximumLength</th>
    </tr>
    </thead>
    <tbody>
    <#list objs as obj>
    <tr>
        <td>
            <input type="hidden" name="lists[${obj_index}].columnName" value="${obj.columnName}"/>
            <input type="checkbox" class="ttt" name="lists[${obj_index}].condition" value="false"/>条件
            </td><td>
            <input type="checkbox" class="ttt"  name="lists[${obj_index}].list" value="false"/>列表
         </td><td>   <input type="checkbox" class="ttt"  name="lists[${obj_index}].add" value="false"/>添加

        </td>
        <td>${obj.columnName}</td>
        <td>${obj.dataType}</td>
        <td>${obj.columnType}</td>
        <td>${obj.columnComment}</td>
        <td>${obj.columnKey}</td>
        <td>${obj.characterMaximumLength}</td>
    </tr>
    </#list>
    </tbody>
</table>
<script>
    $(document).ready(function(){
        $(".ttt").click(function(event) {
            if ($(this).val() == true) {
                $(this).val("false");
            } else {
                $(this).val("true");
            }
        });
    });
 </script>