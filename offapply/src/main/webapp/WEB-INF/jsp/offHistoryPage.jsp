<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>查看请假单</title>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    %>

    <base href="<%=basePath%>">
    <link rel="stylesheet" href="layui/css/layui.css">
</head>
<body>
<table class="layui-hide" id="LAY_table_user" lay-filter="useruv"></table>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
</script>
<script type="text/html" id="barDemo1">
    {{#  if(d.firstCheckUserName){ }}
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail1">查看</a>
    {{#  } }}
</script>
<script type="text/html" id="barDemo2">
    {{#  if(d.secondCheckUserName){ }}
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail2">查看</a>
    {{#  } }}
</script>
<script type="text/html" id="barDemo3">
    {{#  if(d.thirdCheckUserName){ }}
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail3">查看</a>
    {{#  } }}
</script>
<script type="text/html" id="barDemo5">
    {{#  if(d.previousIsNotAcceptedOffId){ }}
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail4">查看被驳回的内容</a>
    {{#  } }}
</script>

<script src="layui/layui.js"></script>
<script>
    layui.use(['table','layer'], function(){
        var table = layui.table;
        var layer = layui.layer;
        var $ = layui.jquery;

        //方法级渲染
        table.render({
            elem: '#LAY_table_user'
            ,url: 'off/history/data.json'
            ,cols: [[
                {field:'offId', title: 'ID', width:60, sort: true, fixed: true}
                ,{field:'userName', title: '用户名', width:100}
                ,{field:'offTypeName', title: '类型', width:60}
                ,{field:'startDate', title: '开始时间', width:150}
                ,{field:'endDate', title: '结束时间', width:150}
                ,{field:'offReason', title: '原因', width:80, toolbar:"#barDemo"}
                ,{field:'applyDatetime', title: '申请日期', width:150}
                ,{field:'previous', title: '被驳回', width:150, toolbar:"#barDemo5"}
                //,{field:'firstCheckUserName', title: '一级审批', width:60}
                ,{field:'firstCheckUserOpinion', title: '一级审批意见', width:70, toolbar:"#barDemo1"}
                ,{field:'isAcceptedByFirstChinese', title: '同/驳', width:80}
                //,{field:'firstCheckDatetime', title: '一级审批时间', width:150}
                //,{field:'secondCheckUserName', title: '二级审批', width:60}
                ,{field:'secondCheckUserOpinion', title: '二级审批意见', width:70, toolbar:"#barDemo2"}
                ,{field:'isAcceptedBySecondChinese', title: '同/驳', width:80}
                //,{field:'secondCheckDatetime', title: '二级审批时间', width:150}
                //,{field:'thirdCheckUserName', title: '三级审批', width:60}
                ,{field:'thirdCheckUserOpinion', title: '三级审批意见', width:70, toolbar:"#barDemo3"}
                ,{field:'isAcceptedByThirdChinese', title: '同/驳', width:80}
                //,{field:'thirdCheckDatetime', title: '三级审批时间', width:150}
            ]]
            ,id: 'testReload'
            ,page: true
            ,height: 600
        });

         //监听工具条
        table.on('tool(useruv)', function(obj){
            var data = obj.data;
            if(obj.event === 'detail'){
                look(data,4);
            } else if(obj.event === 'detail1'){
                look(data,1);
            } else if(obj.event === 'detail2'){
                look(data,2);
            }else if(obj.event === 'detail3'){
                look(data,3);
            }else if(obj.event === 'detail4'){
                var url = "apply/view/notaccepted?id="+data.previousIsNotAcceptedOffId;
                window.open(url);
            }else if(obj.event === 'check'){
                layer.open({
                    type: 2,
                    area: ['1100px', '700px'],
                    fixed: false, //不固定
                    maxmin: true,
                    content: '<c:out value="approval4.html?offId="/>'+data.offId,
                    cancel: function(index, layero){
                        location.reload();
                        return false;
                    }
                });
            }
        });


        function  look(data,which) {
            $.ajax({
                url: "approval3.json",
                type: "POST",
                data:{"offId":data.offId,"which":which},
                dataType: "json",
                success: function(data){
                    if(data.status==1){
                        layer.msg(data.opinion);
                    }else{
                        layer.msg("查看失败");
                    }
                }

            });
        }


    });
</script>
</body>
</html>