<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>请假系统</title>
</head>
<body>
    ${user.userName},欢迎您进入<br>
    ${formResult}
    ${takeOff.offStatus}

    <c:if test="${takeOff == null}">
        <a href="<c:out value="/offcheck/apply.html"/>">请假申请</a>
    </c:if>

    <c:if test="${takeOff.offStatus == 3}">
        <c:set var="currentTime" value="<%= new Date()%>"></c:set>
    <c:if test="${currentTime.time > takeOff.endDate.time}">
        <a href="<c:out value="/offcheck/apply.html"/>">请假申请</a>
    </c:if>
    </c:if>

    <c:if test="${takeOff!= null}">
        <c:if test="${takeOff.offStatus > 0 && takeOff.offStatus < 4}">
            <a href="<c:out value="/offcheck/apply/view.html"/>">
                <c:set var="currentTime" value="<%= new Date()%>"></c:set>
                <c:if test="${currentTime.time > takeOff.endDate.time}">
                    查看过期的请假单
                </c:if>
                <c:if test="${currentTime.time < takeOff.endDate.time}">
                    查看请假单
                </c:if>
            </a>
        </c:if>
    </c:if>

    <c:if test="${takeOff!= null && takeOff.offStatus == 0}">
        <a href="<c:out value="/offcheck/apply/update.html"/>">修改请假单</a>
    </c:if>

    <c:if test="${takeOff!= null && takeOff.offStatus ==4}">
    <a href="<c:out value="/offcheck/apply/notaccepted/update.html"/>">修改被驳回的请假单</a>
    </c:if>

    <c:if test="${againstLostUser.userType > 0}">
        <a href="<c:out value="/offcheck/approval.html"/>">审批请假条</a>
    </c:if>

    <a href="<c:out value="/offcheck/logout.html"/>">退出登录</a>
</body>
</html>