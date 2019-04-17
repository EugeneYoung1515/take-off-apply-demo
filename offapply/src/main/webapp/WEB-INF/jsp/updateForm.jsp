<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改请假单</title>
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

<c:if test="${changeUrl != null}">
<form class="layui-form" action="/offcheck${changeUrl}.html" method="post">
</c:if>
    <c:if test="${changeUrl == null}">
    <form class="layui-form" action="apply/update/submit.html" method="post">
    </c:if>
       <div class="layui-form-item">
                <label class="layui-form-label">用户名</label>
                <div class="layui-input-inline">
                    <input type="text" name="userName" value="${user.userName}" class="layui-input" readonly="readonly">
                </div>
            </div>
  <div class="layui-form-item" pane="">
    <label class="layui-form-label">请假类型</label>
    <div class="layui-input-block">
            <c:if test="${takeOff.offType == 1}">
      <input type="radio" name="offType" value="1" title="年假" checked="">
      <input type="radio" name="offType" value="2" title="事假">
      <input type="radio" name="offType" value="3" title="病假">
            </c:if>
            <c:if test="${takeOff.offType == 2}">
      <input type="radio" name="offType" value="1" title="年假" >
      <input type="radio" name="offType" value="2" title="事假" checked="">
      <input type="radio" name="offType" value="3" title="病假">
            </c:if>
            <c:if test="${takeOff.offType == 3}">
      <input type="radio" name="offType" value="1" title="年假" >
      <input type="radio" name="offType" value="2" title="事假" >
      <input type="radio" name="offType" value="3" title="病假" checked="">
           </c:if>
    </div>
  </div>
         <div class="layui-form-item">
                <label class="layui-form-label">申请时间</label>
                <div class="layui-input-inline">
                    <input type="text" name="userName" value="<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${takeOff.applyDatetime}"/>" class="layui-input" readonly="readonly">
                </div>
            </div>
          <div class="layui-form-item">
            <div class="layui-inline">
              <label class="layui-form-label">开始时间</label>
              <div class="layui-input-inline">
                <input type="text" name="startDate" value="<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${takeOff.startDate}"/>" class="layui-input" id="startDate" >
              </div>
            </div>
            <div class="layui-inline">
              <label class="layui-form-label">结束时间</label>
              <div class="layui-input-inline">
                <input type="text" name="endDate" value="<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${takeOff.endDate}"/>" class="layui-input" id="endDate" >
              </div>
            </div>
          </div>
  <div class="layui-form-item layui-form-text">
    <label class="layui-form-label">请假原因</label>
    <div class="layui-input-block">
      <textarea name="offReason" placeholder="请输入请假原因" class="layui-textarea">${takeOff.offReason}</textarea>
    </div>
  </div>
     <div class="layui-form-item">
         <div class="layui-input-inline">
             <input type="hidden" name="offStatus" value="${takeOff.offStatus}" autocomplete="off" class="layui-input"/>
         </div>
     </div>
        <div class="layui-form-item">
            <div class="layui-input-inline">
                <input type="hidden" name="offId" value="${takeOff.offId}" autocomplete="off" class="layui-input"/>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-inline">
                <input type="hidden" name="userId" value="${applyUser.userId}" autocomplete="off" class="layui-input"/>
            </div>
        </div>
        <div class="layui-form-item">
         <div class="layui-input-block">
             <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
             <button type="reset" class="layui-btn layui-btn-primary">重置</button>
         </div>
     </div>
</form>
</body>
<script src="layui/layui.js"></script>
<script>
    layui.use(['table','layer', 'form', 'laydate','jquery'], function(){
        var table = layui.table;
        var layer = layui.layer;
        var $ = layui.jquery;
        var laydate = layui.laydate;

        //方法级渲染
        table.render({
            elem: '#LAY_table_user'
            ,url: 'apply/view2.json'
            ,cols: [[
                {field:'offId', title: 'ID', width:60, sort: true, fixed: true}
                ,{field:'userName', title: '用户名', width:100}
                ,{field:'offTypeName', title: '类型', width:60}
                ,{field:'startDate', title: '开始时间', width:150}
                ,{field:'endDate', title: '结束时间', width:150}
                ,{field:'offReason', title: '原因', width:80, toolbar:"#barDemo"}
                ,{field:'applyDatetime', title: '申请日期', width:150}
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
            //,page: true
            ,height: 300
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
            }
            else if(obj.event === 'check'){
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

                var start = laydate.render({ 
                elem: '#startDate',
                min:nowTime,
                type: 'datetime',
                done:function(value,date){
                  if($.trim(value) == ''){
                       var curDate = new Date();
                       date = {'date': curDate.getDate(), 'month': curDate.getMonth()+1, 'year': curDate.getFullYear(), 'hours': curDate.getHours(), 'minutes': curDate.getMinutes(), 'seconds': curDate.getSeconds()};
                   }
                    endMax = end.config.max;
                    end.config.min = date;
                    end.config.min.month = date.month -1;
                }
            });
         var end = laydate.render({
               elem: '#endDate',
               min : nowTime,
               type: 'datetime',
               done:function(value,date){
                   if($.trim(value) == ''){
                       //var curDate = new Date();
                       //date = {'date': curDate.getDate(), 'month': curDate.getMonth()+1, 'year': curDate.getFullYear(), 'hours': curDate.getHours(), 'minutes': curDate.getMinutes(), 'seconds': curDate.getSeconds()};

                       date = {'date': 31, 'month': 12, 'year': 2099, 'hours': 0, 'minutes': 0, 'seconds': 0};
                   }
                   start.config.max = date;
                   start.config.max.month = date.month -1;
               }
            });

    });
</script>
</html>
