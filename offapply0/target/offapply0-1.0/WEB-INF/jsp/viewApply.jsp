<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>查看请假单</title>
</head>
<body>
<table border="1px" width="100%">
    <tr>
        <td width="20%">用户名</td>
        <td width="80%">${applyUser.userName}</td>
    </tr>
    <tr>
        <td width="20%">请假类型</td>
        <td width="80%">
            <c:if test="${takeOff.offType == 1}">
                年假
            </c:if>
            <c:if test="${takeOff.offType == 2}">
                事假
            </c:if>
            <c:if test="${takeOff.offType == 3}">
                病假
            </c:if>
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
            <fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${takeOff.startDate}"/>
            结束时间:
            <fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${takeOff.endDate}"/>
        </td>
    </tr>
    <tr>
        <td width="20%">原因</td>
        <td width="80%">
            ${takeOff.offReason}
        </td>
    </tr>
    <c:if test="${takeOff.isAcceptedByFirst == 1}">
        <tr>
            <td width="20%">一级审批人</td>
            <td width="80%">
                    ${againstLostFirstUser.userName}
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
    <c:if test="${takeOff.isAcceptedBySecond == 1}">
        <tr>
            <td width="20%">二级审批人</td>
            <td width="80%">
                    ${againstLostSecondUser.userName}
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
    <c:if test="${takeOff.isAcceptedByThird == 1}">
        <tr>
            <td width="20%">三级审批人</td>
            <td width="80%">
                    ${againstLostThirdUser.userName}
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
</table>
</body>
</html>
