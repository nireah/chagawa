<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대화방 리스트</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style type="text/css">


.dataRow:hover{
	background: #eee;
	cursor: pointer;
}


h1 {
  text-align: center;
  font-size: 36px;
  margin-bottom: 50px;
}


table {
  width: 800px;
  border-collapse: collapse;
  overflow: hidden;
  box-shadow: 0 0 20px rgba(0,0,0,0.1);
}

th{
	text-align: left;
	background: #4B89DC;
	color: #EDF3FB;
	}

</style>
<script type="text/javascript">

	$(function() {
		$(".dataRow").click(function() {
					let roomNo = $(this).find(".roomNo").text();
					let par1 = $(this).find(".par1").text();
					location = "/message/messagelog.do?roomNo=" + roomNo + "&par1=" + par1;
				});
			
	});
</script>
</head>
<body>
	<div class="container">
		<h1>대화방</h1>
		<input type="hidden" name="id" id="id" value="${login.id }">
		
		<table class="table">
			<thead>
				<tr>
					<th></th>
					<th style="text-align : left;">프로필</th>
					<th style="text-align : left;">아이디</th>
					<th style="text-align : left;">최근 메시지</th>
					<th>방 생성날짜</th>
					<th></th>
					
				</tr>
			</thead>  <colgroup> 
    	<col style="width: 1%;"/> 
        <col style="width: 15%;"/> 
        <col style="width: 15%;"/> 
        <col style="width: 50%;"/> 
        <col style="width: 19%;"/> 
    </colgroup> 
			<tbody>
				<c:forEach items="${list }" var="vo">
					<tr class="dataRow">
					<td class="roomNo" style="color: #ffffff">${vo.roomNo }</td>
						<c:if test="${login.id == vo.par1}">
							<td><img class="img img-circle" style="width: 30%"   src="${vo.profileImage}"></td>
							<td class="par1">${vo.par2 }</td>
						</c:if>
						
						<c:if test="${login.id != vo.par1}">
							<td><img class="img img-circle" style="width: 30%" src="${vo.profileImage}"></td>
							<td class="par1">${vo.par1 }</td>
						</c:if>
						<c:if test="${login.id == vo.par1 }">	
						<td style="text-align: left;">${vo.lmcontent }<span class="label label-danger">${vo.unreadcount1}</span></td>
						</c:if>
						<c:if test="${login.id != vo.par1 }">	
						<td style="text-align: left;">${vo.lmcontent }<span class="label label-danger">${vo.unreadcount2}</span></td>
						</c:if>
						<td>${vo.cDate }</td>
						<td><a href="leave.do?roomNo=${vo.roomNo}&par1=${vo.par1}" class="btn btn-default">나가기</a></td>
					</tr>
				<input type="hidden" name="roomNo" id="roomNo" value="${vo.roomNo }" >
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>