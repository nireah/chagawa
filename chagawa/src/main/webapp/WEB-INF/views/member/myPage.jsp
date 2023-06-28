<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내정보보기</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
$(function() {
	if("${param.wrong}") alert("비밀번호가 일치하지 않습니다.");
	if("${param.age}") alert("만 18세 미만은 운전면허를 취득할 수 없으므로 운전자 등급 전환이 불가합니다.");
	
	$("#leaveBtn").click(function() {
		$("#leaveDiv").slideDown();
		return false;
	});
	
	$("#cancelLeaveBtn").click(function() {
		$("#leaveDiv").slideUp();
	});

	$("#changePw").click(function() {
		window.open("changePw.sub?id="+$("#id").val(), "changePw", "width= 1000, height= 300, top= 200, left= 450");
	});
	
// 	$("#joinDriver").click(function() {
// 		window.open("joinDriver.sub?id="+$("#id").val(), "joinDriver", "width= 1000, height= 400, top= 200, left= 250");
// 	});
	
	$("#updateImageBtn").click(function() {
		$("#updateImageDiv").slideDown();
	});
	$("#defaultImageBtn").click(function() {
		$("#defaultImageDiv").slideDown();
	});
	$("#cancelBtn").click(function() {
		$("#updateImageDiv").slideUp();
	});
	$("#cancel2Btn").click(function() {
		$("#defaultImageDiv").slideUp();
	});
});
</script>

<style>
	#leaveDiv{
		display: none;
	}
	#updateImageDiv{
		display: none;
	}
	#defaultImageDiv{
		display: none;
	}
	th{
		width: 200px;
		text-align: center;
 		background: #4B89DC;
 		opacity: 0.9;
		color: #EDF3FB;
	}
	h2{
		color: #4B89DC;
		font-weight: bold;
		text-align: center;
	}
	.table > td{
		padding: 15px;
	}
	#imageName{
		color: white;
	}
</style>

</head>
<body>
<div class="container">
	<input id="id" value="${vo.id}" type="hidden">
	<div class="col-md-12">
		<h2 style="text-align: center;">내 정보 보기</h2>
		<br>
	</div>
	<div class="row">
		<div class="col-md-8">
			<table class="table">
				<tbody>
					<tr>
						<th style="vertical-align: middle;">프로필 사진</th>
						<td style="padding: 10px 40px;">
							<div class="row">
								<div class="col-md-5" style="text-align: center;">
									<img class="img img-circle" id="img" name="img" style="width: 80%;" src="${vo.profileImage}">
								</div>
								<div class="col-md-7">
									<p id="imageName">${vo.profileImage}</p>
								</div>
							</div>
							<div style="margin: 10px 0 0 0;">
								<button class="btn btn-info btn-xs" id="updateImageBtn">이미지 수정</button>
								<button class="btn btn-info btn-xs" id="defaultImageBtn">기본이미지로 변경</button>
							</div>
							<div id="updateImageDiv" class="well well-sm">
								<form action="updateImage.do" id="updateImageForm" method="post" enctype="multipart/form-data">
									<input type="hidden" name="id" value="${vo.id}">
									<input type="hidden" name="deleteFile" value="${vo.profileImage}">
									<div class="form-group form-inline">
										<label for="profileImage">이미지 선택:</label>
										<input class="form-control" name="profileImage" id="profileImage" type="file">
									</div>
									<button class="btn btn-default btn-sm">바꾸기</button>
									<button class="btn btn-default btn-sm" type="button" id="cancelBtn">취소</button>
								</form>
							</div>
							<div id="defaultImageDiv" class="well well-sm">
								<form action="updateImage.do" id="defaultImageForm" method="post" enctype="multipart/form-data">
									<input type="hidden" name="id" value="${vo.id}">
									<input type="hidden" name="deleteFile" value="${vo.profileImage}">
									<input type="hidden" name="profileImage" value="chagawa.jpg">
									<button class="btn btn-default btn-sm">바꾸기</button>
									<button class="btn btn-default btn-sm" type="button" id="cancel2Btn">취소</button>
								</form>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="col-md-4 well pull-right" style="height: 150px">
			<p>나의 포인트</p>
			<p>${vo.myPoint}</p>
			<br>
			<a href="/point/list.do?id=${vo.id}" class="btn btn-warning pull-right">포인트</a>
			<a href="/carpool/mylist.do?id=${vo.id}" class="btn btn-primary pull-right" style="margin-right:5px;">카풀 이용내역</a>
		</div>
	</div>
	<div>
		<table class="table">
			<tbody>
				<tr>
					<th>아이디</th>
					<td style="padding: 8px 40px;">${vo.id}</td>
				</tr>
				<tr>
					<th>닉네임</th>
					<td style="padding: 8px 40px;">${vo.nickname}</td>
				</tr>
				<tr>
					<th>이름</th>
					<td style="padding: 8px 40px;">${vo.name}</td>
				</tr>
				<tr>
					<th>성별</th>
					<td style="padding: 8px 40px;">${vo.gender}</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td style="padding: 8px 40px;">${vo.birth}</td>
				</tr>
				<tr>
					<th>연락처</th>
					<td style="padding: 8px 40px;">${vo.tel}</td>
				</tr>
				<tr>
					<th>계좌</th>
					<td style="padding: 8px 40px;">${vo.account}(${vo.bank})</td>
				</tr>
				<tr>
					<th>등급</th>
					<c:if test="${vo.gradeNo != 1}">
						<td style="padding: 8px 40px;">${vo.gradeName}</td>
					</c:if>
					<c:if test="${vo.gradeNo == 1}">
						<td style="padding: 8px 40px;">${vo.gradeName}
<!-- 						<button id="joinDriver" class="btn btn-info btn-sm">등급전환</button></td> -->
						<a href="joinDriver.do?id=${vo.id}" id="joinDriver" class="btn btn-info btn-sm">등급전환</a></td>
					</c:if>
				</tr>
				<tr>
					<th>가입일</th>
					<td style="padding: 8px 40px;">${vo.regDate}</td>
				</tr>
			</tbody>
		</table>
	
		<c:if test="${vo.gradeNo == 2}">
			<table class="table">
				<tbody>
					<tr>
						<th>차종</th>
						<td style="padding: 8px 40px;">${vo.carModel}</td>
					</tr>
					<tr>
						<th>차량번호</th>
						<td style="padding: 8px 40px;">${vo.carNo}</td>
					</tr>
					<tr>
						<th>면허번호</th>
						<td style="padding: 8px 40px;">${vo.licenseNo}</td>
					</tr>
				</tbody>
			</table>
		</c:if>
	</div>
	
	<div class="col-md-6" style="margin: 0 0 20px 0;">
		<div>
			<button id="changePw" class="btn btn-default">비밀번호 변경</button>
			<a href="update.do?id=${vo.id}" class="btn btn-default">내정보수정</a>
			<a href="leave.do" id="leaveBtn" class="btn btn-default">탈퇴</a>
			<div id="leaveDiv" class="well well-sm">
				<form action="leave.do" method="post" class="form-inline">
					<input type="hidden" name="id" value="${vo.id}">
					<label for="pw">비밀번호 확인:</label>
					<input type="password" id="pw" name="pw" class="form-control">
					<button id="submitLeaveBtn" class="btn btn-default btn-sm">탈퇴</button>
					<button type="button" id="cancelLeaveBtn" class="btn btn-default btn-sm">취소</button>
				</form>
			</div>
		</div>
	</div>
		
</div>
</body>
</html>