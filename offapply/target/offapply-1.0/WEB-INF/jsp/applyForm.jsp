<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>请假单</title>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    %>

    <base href="<%=basePath%>">
    <link rel="stylesheet" href="layui/css/layui.css">
    <style type="text/css">
        .layui-laydate-content>.layui-laydate-list {
                padding-bottom: 0px;
                overflow: hidden;
            }
            .layui-laydate-content>.layui-laydate-list>li{
                width:50%
            }
 
            .merge-box .scrollbox .merge-list {
                padding-bottom: 5px;
            }
 
</style>
</head>
<body>
 <form class="layui-form" action="apply/form/submit.html" method="post">
    <div class="layui-form-item">
                <label class="layui-form-label">用户名</label>
                <div class="layui-input-inline">
                    <input type="text" name="userName" value="${user.userName}" class="layui-input" readonly="readonly">
                </div>
            </div>
  <div class="layui-form-item" pane="">
    <label class="layui-form-label">请假类型</label>
    <div class="layui-input-block">
      <input type="radio" name="offType" value="1" title="年假" checked="">
      <input type="radio" name="offType" value="2" title="事假">
      <input type="radio" name="offType" value="3" title="病假">
    </div>
  </div>
          <div class="layui-form-item">
            <div class="layui-inline">
              <label class="layui-form-label">开始时间</label>
              <div class="layui-input-inline">
                <input type="text" name="startDate" class="layui-input" id="startDate" readonly>
              </div>
            </div>
            <div class="layui-inline">
              <label class="layui-form-label">结束时间</label>
              <div class="layui-input-inline">
                <input type="text" name="endDate" class="layui-input" id="endDate" readonly>
              </div>
            </div>
          </div>
  <div class="layui-form-item layui-form-text">
    <label class="layui-form-label">请假原因</label>
    <div class="layui-input-block">
      <textarea name="offReason" placeholder="请输入请假原因" class="layui-textarea"></textarea>
    </div>
  </div>
     <div class="layui-form-item">
         <div class="layui-input-inline">
             <input type="hidden" name="userId" value="${user.userId}" autocomplete="off" class="layui-input"/>
         </div>
     </div>
     <div class="layui-form-item">
         <div class="layui-input-block">
             <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
             <button type="reset" class="layui-btn layui-btn-primary">重置</button>
         </div>
     </div>
</form>
<script src="layui/layui.js"></script>
<script type="text/javascript">
  layui.use(['form', 'layedit', 'laydate',"jquery"], function(){
          var form = layui.form
          ,layer = layui.layer
          ,$ = layui.jquery
          ,laydate = layui.laydate;
          var nowTime = new Date().valueOf();

        //日期
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
</body>
</html>
