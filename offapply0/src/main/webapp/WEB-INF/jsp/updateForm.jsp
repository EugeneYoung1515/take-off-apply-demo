<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改请假单</title>
</head>
<body>
<script language="javascript" type="text/javascript" src="My97DatePicker/My97DatePicker/WdatePicker.js"></script>
<c:if test="${changeUrl != null}">
<form action="${changeUrl}.html" method="post">
</c:if>
    <c:if test="${changeUrl == null}">
    <form action="/offcheck/apply/update/submit.html" method="post">
    </c:if>
<table border="1px" width="100%">
    <tr>
        <td width="20%">用户名</td>
        <td width="80%">${applyUser.userName}</td>
    </tr>
    <tr>
        <td width="20%">请假类型</td>
        <td width="80%">
            <select name="offType">
            <c:if test="${takeOff.offType == 1}">
                <option value="1">年假</option>
                <option value="2">事假</option>
                <option value="3">病假</option>
            </c:if>
            <c:if test="${takeOff.offType == 2}">
                <option value="2">事假</option>
                <option value="1">年假</option>
                <option value="3">病假</option>
            </c:if>
            <c:if test="${takeOff.offType == 3}">
                <option value="3">病假</option>
                <option value="1">年假</option>
                <option value="2">事假</option>
            </c:if>
            </select>
        </td>
    </tr>
    <tr>
        <td width="20%">申请时间</td>
        <td width="80%">
            <fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${takeOff.applyDatetime}"/>
        </td>
    </tr>
    <tr>
        <td width="20%">请假时间段</td>
        <td width="80%">
            开始时间：
            <input class="Wdate" type="text" name="startDate" value="<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${takeOff.startDate}"/>" onClick="WdatePicker({el:this,dateFmt:'yyyy-MM-dd HH:mm'})">
            结束时间:
            <input class="Wdate" type="text" name="endDate" value="<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${takeOff.endDate}"/>" onClick="WdatePicker({el:this,dateFmt:'yyyy-MM-dd HH:mm'})">
        </td>
    </tr>
    <tr>
        <td width="20%">原因</td>
        <td width="80%">
            <textarea style="width:100%;height:100px" name="offReason">${takeOff.offReason}</textarea>
        </td>
    </tr>
    <c:if test="${takeOff.isAcceptedByFirst != null}">
        <tr>
            <td width="20%">一级审批人</td>
            <td width="80%">
                    ${firstUser.userName}
            </td>
        </tr>
        <tr>
            <td width="20%">意见</td>
            <td width="80%">
                    ${takeOff.firstCheckUserOpinion}
            </td>
        </tr>
        <tr>
            <td width="20%">同意／驳回</td>
            <td width="80%">
                <c:if test="${takeOff.isAcceptedByFirst == 1}">
                    同意
                </c:if>
                <c:if test="${takeOff.isAcceptedByFirst == 0}">
                    驳回
                </c:if>
            </td>
        </tr>
        <tr>
            <td width="20%">审批时间</td>
            <td width="80%">
                <fmt:formatDate value="${takeOff.firstCheckDatetime}" pattern="yyyy-MM-dd HH:mm"/>
            </td>
        </tr>
    </c:if>
    <c:if test="${takeOff.isAcceptedBySecond != null}">
        <tr>
            <td width="20%">二级审批人</td>
            <td width="80%">
                    ${secondUser.userName}
            </td>
        </tr>
        <tr>
            <td width="20%">意见</td>
            <td width="80%">
                    ${takeOff.secondCheckUserOpinion}
            </td>
        </tr>
        <tr>
            <td width="20%">同意／驳回</td>
            <td width="80%">
                <c:if test="${takeOff.isAcceptedBySecond == 1}">
                    同意
                </c:if>
                <c:if test="${takeOff.isAcceptedBySecond == 0}">
                    驳回
                </c:if>
            </td>
        </tr>
        <tr>
            <td width="20%">审批时间</td>
            <td width="80%">
                <fmt:formatDate value="${takeOff.secondCheckDatetime}" pattern="yyyy-MM-dd HH:mm"/>
            </td>
        </tr>
    </c:if>
    <c:if test="${takeOff.isAcceptedByThird != null}">
        <tr>
            <td width="20%">三级审批人</td>
            <td width="80%">
                    ${thirdUser.userName}
            </td>
        </tr>
        <tr>
            <td width="20%">意见</td>
            <td width="80%">
                    ${takeOff.thirdCheckUserOpinion}
            </td>
        </tr>
        <tr>
            <td width="20%">同意／驳回</td>
            <td width="80%">
                <c:if test="${takeOff.isAcceptedByThird == 1}">
                    同意
                </c:if>
                <c:if test="${takeOff.isAcceptedByThird == 0}">
                    驳回
                </c:if>
            </td>
        </tr>
        <tr>
            <td width="20%">审批时间</td>
            <td width="80%">
                <fmt:formatDate value="${takeOff.thirdCheckDatetime}" pattern="yyyy-MM-dd HH:mm"/>
            </td>
        </tr>
    </c:if>
    <tr>
        <td colspan="2">
            <input type="hidden" name="offStatus" value="${takeOff.offStatus}">
            <input type="hidden" name="offId" value="${takeOff.offId}">
            <input type="hidden" name="userId" value="${applyUser.userId}">
            <input type="submit" value="保存">
            <input type="reset" value="重置">
        </td>
    </tr>
</table>
</form>
</body>
</html>
