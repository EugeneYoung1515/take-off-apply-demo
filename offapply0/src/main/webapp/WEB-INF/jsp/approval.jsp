<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>请假审批</title>
</head>
<body>
<form action="/offcheck/approval/result.html" method="post">
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
        <c:if test="${takeOff.isAcceptedBySecond == 1}">
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
        <c:if test="${takeOff.isAcceptedByThird == 3}">
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
            <td width="20%">审批意见</td>
            <td width="80%">
                <textarea style="width:100%;height:100px"  name="checkUserOpinion"></textarea>
            </td>
        </tr>
        <td width="20%">同意/驳回</td>
        <td width="80%">
            <input type="radio" name="checked" value="1" />同意
            <input type="radio" name="checked" value="0" />驳回
        </td>
        <tr>
            <td colspan="2">
                <input type="hidden" name="userType" value="${user.userType}">
                <input type="hidden" name="checkUserId" value="${user.userId}">
                <input type="hidden" name="offId" value="${takeOff.offId}">
                <input type="submit" value="保存">
                <input type="reset" value="重置">
            </td>
        </tr>
    </table>
</form>
</body>
</html>
