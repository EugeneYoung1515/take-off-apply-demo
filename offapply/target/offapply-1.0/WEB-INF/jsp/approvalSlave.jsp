<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>请假审批</title>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    %>

    <base href="<%=basePath%>">
    <link rel="stylesheet" href="layui/css/layui.css">
</head>
<body>
 <form class="layui-form" action="approval/result.html" method="post">
    <div class="layui-form-item layui-form-text">
    <label class="layui-form-label">审批意见</label>
    <div class="layui-input-block">
      <textarea name="checkUserOpinion" placeholder="请输入审批意见" class="layui-textarea"></textarea>
    </div>
  </div>
  <div class="layui-form-item" pane="">
    <label class="layui-form-label">同意/驳回</label>
    <div class="layui-input-block">
      <input type="radio" name="checked" value="1" title="同意" checked="">
      <input type="radio" name="checked" value="0" title="驳回">
    </div>
  </div>
     <div class="layui-form-item">
         <div class="layui-input-inline">
             <input type="hidden" name="offId" value="${takeOff.offId}" autocomplete="off" class="layui-input"/>
         </div>
     </div>
         <div class="layui-form-item">
         <div class="layui-input-inline">
             <input type="hidden" name="userType" value="${user.userType}" autocomplete="off" class="layui-input"/>
         </div>
     </div>
     <div class="layui-form-item">
         <div class="layui-input-inline">
             <input type="hidden" name="checkUserId" value="${user.userId}" autocomplete="off" class="layui-input"/>
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
 <script>
     layui.use('form', function(){
         var form = layui.form;

     });
 </script>
</body>
</html>
