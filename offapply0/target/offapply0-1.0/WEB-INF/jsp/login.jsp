<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
	<head>
		<title>用户登录</title>
	</head>
	<body>
		<c:if test="${!empty error}">
	        <font color="red">${error}</font>
		</c:if>        
		<form action="logincheck.html" method="post">
			用户名：
			<input type="text" name="userName">
			<br>
			密 码：
			<input type="password" name="password">
			<br>
			<input type="submit" value="登录" />
			<input type="reset" value="重置" />
		</form>
	</body>
</html>
