<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ attribute name="pageObject" required="true"
	type="com.webjjang.util.PageObject"%>
<%@ attribute name="listURI" required="true" type="java.lang.String"%>
<%@ attribute name="query" required="false" type="java.lang.String"%>

<%
request.setAttribute("noLinkColor", "#999");
%>

<ul class="pagination">
	<li data-page=1><c:if test="${pageObject.page > 1 }">
			<!-- 맨 첫페이지로 이동 -->
			<a
				href="${listURI }?page=1&perPageNum=${pageObject.perPageNum}&key=${pageObject.key}&word=${pageObject.word}${query}">
				<i class="glyphicon glyphicon-fast-backward"></i>
			</a>
		</c:if> <c:if test="${pageObject.page == 1 }">
			<a href="" onclick="return false" ${noMove } ${tooltip }> <i
				class="glyphicon glyphicon-fast-backward"
				style="color: ${noLinkColor};"></i>
			</a>
		</c:if></li>


	<li data-page=${pageObject.startPage -1 }><c:if
			test="${pageObject.startPage > 1 }">
			<a
				href="${listURI }?page=${pageObject.startPage - 1 }&perPageNum=${pageObject.perPageNum}&key=${pageObject.key}&word=${pageObject.word}${query}">
				<i class="glyphicon glyphicon-step-backward"></i>
			</a>
		</c:if> <c:if test="${pageObject.startPage == 1 }">
			<a href="" onclick="return false" ${noMove } ${tooltip }> <i
				class="glyphicon glyphicon-step-backward"
				style="color: ${noLinkColor};"></i>
			</a>
		</c:if></li>
	<c:forEach begin="${pageObject.startPage }"
		end="${pageObject.endPage }" var="cnt">
		<li ${(pageObject.page == cnt)?"class=\"active\"":"" }
			data-page=${cnt }>
			<!-- 페이지와 cnt가 같으면 링크가 없음 --> <c:if test="${pageObject.page == cnt }">
				<a href="" onclick="return false" ${noMove } ${tooltip }>${cnt}</a>
			</c:if> <!-- 페이지와 cnt가 같지 않으면 링크가 있음 --> <c:if
				test="${pageObject.page != cnt }">
				<a
					href="${listURI }?page=${cnt }&perPageNum=${pageObject.perPageNum}&key=${pageObject.key}&word=${pageObject.word}${query}">${cnt}</a>
			</c:if>
		</li>
	</c:forEach>
	<c:if test="${pageObject.endPage < pageObject.totalPage }">
		<li data-page=${pageObject.endPage + 1 }><a
			href="${listURI }?page=${pageObject.endPage + 1 }&perPageNum=${pageObject.perPageNum}&key=${pageObject.key}&word=${pageObject.word}${query}">
				<i class="glyphicon glyphicon-step-forward"></i>
		</a></li>
	</c:if>
	<c:if test="${pageObject.endPage == pageObject.totalPage }">
		<li data-page=${pageObject.endPage + 1 }><a href=""
			onclick="return false" ${noMove } ${tooltip }> <i
				class="glyphicon glyphicon-step-forward"
				style="color: ${noLinkColor};"></i>
		</a></li>
	</c:if>
	<c:if test="${pageObject.page < pageObject.totalPage }">
		<li data-page=${pageObject.totalPage }><a
			href="${listURI }?page=${pageObject.totalPage }&perPageNum=${pageObject.perPageNum}&key=${pageObject.key}&word=${pageObject.word}${query}">
				<i class="glyphicon glyphicon-fast-forward"></i>
		</a></li>
	</c:if>
	<c:if test="${pageObject.page == pageObject.totalPage }">
		<li data-page=${pageObject.totalPage }><a href=""
			onclick="return false" ${noMove } ${tooltip }> <i
				class="glyphicon glyphicon-fast-forward"
				style="color: ${noLinkColor};"></i>
		</a></li>
	</c:if>
</ul>

<script>
	$(document).ready(function() {
		$('[data-toggle="tooltip"]').tooltip();
		$(".pagination").mouseover(function() {
			//   		$(".tooltip > *:last").css({"background-color": "red", "border": "1px dotted #444"});   
		});
	});
</script>