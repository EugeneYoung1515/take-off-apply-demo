<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>请假单</title>
</head>
<body>
<script language="javascript" type="text/javascript" src="/offcheck/My97DatePicker/My97DatePicker/WdatePicker.js"></script>
    <form action="/offcheck/apply/form/submit.html" method="post">
        <table border="1px" width="100%">
            <tr>
                <td width="20%">用户名</td>
                <td width="80%">${user.userName}</td>
            </tr>
            <tr>
                <td width="20%">请假类型</td>
                <td width="80%">
                    <select name="offType">
                        <option>请选择</option>
                        <option value="1">年假</option>
                        <option value="2">事假</option>
                        <option value="3">病假</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td width="20%">请假时间段</td>
                <td width="80%">
                    开始时间：
                    <input class="Wdate" type="text" name="startDate" onClick="WdatePicker({el:this,dateFmt:'yyyy-MM-dd HH:mm'})">
                    结束时间:
                    <input class="Wdate" type="text" name="endDate" onClick="WdatePicker({el:this,dateFmt:'yyyy-MM-dd HH:mm'})">
                </td>
            </tr>
            <tr>
                <td width="20%">原因</td>
                <td width="80%"><textarea style="width:100%;height:100px"  name="offReason"></textarea></td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="hidden" name="userId" value="${user.userId}">
                    <input type="submit" value="保存">
                    <input type="reset" value="重置">
                </td>
            </tr>
        </table>
</form>
</body>
</html>
