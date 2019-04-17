<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>请假系统</title>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    %>

    <base href="<%=basePath%>">
    <link rel="stylesheet" href="layui/css/layui.css">
</head>
<body>
    ${user.userName},欢迎您进入<br>
    ${formResult}

    <c:if test="${takeOff == null}">
        <button id="btn1" class="layui-btn layui-btn-warm">请假申请</button>
    </c:if>

    <c:if test="${takeOff.offStatus == 3}">
        <c:set var="currentTime" value="<%= new Date()%>"></c:set>
    <c:if test="${currentTime.time > takeOff.endDate.time}">
        <a href="<c:out value="apply.html"/>">
        <button id="btn2" class="layui-btn layui-btn-warm">请假申请</button>
    </a>
    </c:if>
    </c:if>

    <c:if test="${takeOff!= null}">
        <c:if test="${takeOff.offStatus > 0 && takeOff.offStatus < 4}">
                <c:set var="currentTime" value="<%= new Date()%>"></c:set>
                <c:if test="${currentTime.time > takeOff.endDate.time}">
                    <button id="btn3" class="layui-btn">查看过期的请假单</button>
                </c:if>
                <c:if test="${currentTime.time < takeOff.endDate.time}">
                    <button id="btn4"class="layui-btn">查看请假单</button>
                </c:if>
        </c:if>
    </c:if>

    <c:if test="${takeOff!= null && takeOff.offStatus == 0}">
            <button id="btn5" class="layui-btn layui-btn-normal">修改请假单</button>
    </c:if>

    <c:if test="${takeOff!= null && takeOff.offStatus ==4}">
            <button id="btn6" class="layui-btn layui-btn-normal">修改被驳回的请假单</button>
    </c:if>

    <c:if test="${againstLostUser.userType > 0}">
        <button id="btn7" class="layui-btn"><i class="layui-icon">&#xe665;</i> 审批请假单</button>
    </c:if>

    <a href="<c:out value="logout.html"/>" class="layui-btn layui-btn-primary">退出登录</a>
        
        <script src="layui/layui.js"></script>
            <script>
            layui.use('layer', function(){
                var $ = layui.jquery, layer = layui.layer;
                $(document).on('click','#btn1',function(){
                layer.open({
  type: 2,
  area: ['1000px', '600px'],
  fixed: false, //不固定
  maxmin: true,
  content: '<c:out value="apply.html"/>',
                    cancel: function(index, layero){
                        location.reload();
                        return false;
                    }
});
                });
                $(document).on('click','#btn2',function(){
                layer.open({
  type: 2,
  area: ['1000px', '600px'],
  fixed: false, //不固定
  maxmin: true,
  content: '<c:out value="apply.html"/>',
                    cancel: function(index, layero){
                        location.reload();
                        return false;
                    }

                });
                });
                $(document).on('click','#btn3',function(){
                layer.open({
  type: 2,
  area: ['1000px', '600px'],
  fixed: false, //不固定
  maxmin: true,
  content: '<c:out value="apply/view.html"/>',
                    cancel: function(index, layero){
                        location.reload();
                        return false;
                    },
                    btn: ['切换到简单视图'],
                    yes: function(index, layero){
                        layer.close(index);
                        layer.open({
                            type: 2,
                            area: ['1000px', '600px'],
                            fixed: false, //不固定
                            maxmin: true,
                            content: '<c:out value="apply/viewsimple.html"/>',
                            cancel: function(index2, layero){
                                location.reload();
                                return false;
                            }
                        });
                    }
                });
                });
                $(document).on('click','#btn4',function(){
                layer.open({
  type: 2,
  area: ['1000px', '600px'],
  fixed: false, //不固定
  maxmin: true,
  content: '<c:out value="apply/view.html"/>',
                    cancel: function(index, layero){
                        location.reload();
                        return false;
                    },
                    btn: ['切换到简单视图'],
                    yes: function(index, layero){
                        layer.close(index);
                        layer.open({
                            type: 2,
                            area: ['1000px', '600px'],
                            fixed: false, //不固定
                            maxmin: true,
                            content: '<c:out value="apply/viewsimple.html"/>',
                            cancel: function(index2, layero){
                                location.reload();
                                return false;
                            }
                        });
                    }
                });
                });
                $(document).on('click','#btn5',function(){
                layer.open({
  type: 2,
  area: ['1000px', '600px'],
  fixed: false, //不固定
  maxmin: true,
  content: '<c:out value="apply/update.html"/>',
                    cancel: function(index, layero){
                        location.reload();
                        return false;
                    },
                    btn: ['切换到简单视图'],
                    yes: function(index, layero){
                        layer.close(index);
                        layer.open({
                            type: 2,
                            area: ['1000px', '600px'],
                            fixed: false, //不固定
                            maxmin: true,
                            content: '<c:out value="apply/update.html?mode=simple"/>',
                            cancel: function(index2, layero){
                                location.reload();
                                return false;
                            }
                        });
                    }
                });
                });
                $(document).on('click','#btn6',function(){
                layer.open({
  type: 2,
  area: ['1000px', '600px'],
  fixed: false, //不固定
  maxmin: true,
  content: '<c:out value="apply/notaccepted/update.html"/>',
                    cancel: function(index, layero){
                        location.reload();
                        return false;
                    },
                    btn: ['切换到简单视图'],
                    yes: function(index, layero){
                        layer.close(index);
                        layer.open({
                            type: 2,
                            area: ['1000px', '600px'],
                            fixed: false, //不固定
                            maxmin: true,
                            content: '<c:out value="apply/notaccepted/update.html?mode=simple"/>',
                            cancel: function(index2, layero){
                                location.reload();
                                return false;
                            }
                        });
                    }
                });
                });
                $(document).on('click','#btn7',function(){
                var index = layer.open({
  type: 2,
  area: ['1000px', '600px'],
  fixed: false, //不固定
  maxmin: true,
  content: '<c:out value="approval.html"/>',
                    cancel: function(index, layero){
                        location.reload();
                        return false;
                    },
                    btn: ['切换到简单视图'],
                    yes: function(index, layero){
                        layer.close(index);
                        var index2 = layer.open({
                            type: 2,
                            area: ['1000px', '600px'],
                            fixed: false, //不固定
                            maxmin: true,
                            content: '<c:out value="approvalsimple.html"/>',
                            cancel: function(index3, layero){
                                location.reload();
                                return false;
                            }
                        });
                        layer.full(index2);
                    }
});
                    layer.full(index);
                });
            });
        </script>
</body>
</html>