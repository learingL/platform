<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<ul>
    <c:forEach items="${members}" var="member" >
        <li>
            <div class="li-img"><img src="${member.headPortrait == null?'/images/portrait.jpg':member.headPortrait}"></div>
            <div class="adviser-list-info">
                <div class="adviser-list-content">
                    <p><span>${member.name}</span>
                        <c:if test="${member.adviserType == 1}">贷款顾问</c:if>
                        <c:if test="${member.adviserType == 2}">金融顾问</c:if>
                        <c:if test="${member.adviserType == 3}">法律顾问</c:if>
                        <img src="images/qq/qq.gif"></p>
                    <p>${member.companyName}&nbsp;
                        <c:if test="${member.level == 1}">金牌顾问</c:if>
                        &nbsp;执行${member.workAge}年</p>
                    <p>个人简介：${member.description}</p>
                </div>
            </div>
            <div class="adviser-list-href"><a href="/adviser/detail/${member.id}.html">访问主页</a></div>
            <div class="clear"></div>
        </li>
    </c:forEach>
    <c:if test="${empty members}">
        <li>
            <div class="adviser-list-content">
                <p>没有搜索到您所需要的顾问信息！</p>
            </div>
        </li>
    </c:if>
</ul>


   <input type="hidden" id="totalPages" value="${paging.totalPages}"/>
   <input type="hidden" id="currentPage" value="${paging.currentPage}"/>
