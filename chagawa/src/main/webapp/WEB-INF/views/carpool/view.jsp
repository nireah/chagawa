<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3593b4fa1bdf0517be47b4b4399cb5ac"></script>
<script type="text/javascript">
	$(function() {

		var container = document.getElementById('map'); // 지도를 표시할 div 
		
		//시작, 도착지점의 좌표
		var startLatlng = new kakao.maps.LatLng(${vo.startLat}, ${vo.startLng});
		var arriveLatlng = new kakao.maps.LatLng(${vo.arriveLat}, ${vo.arriveLng});
	    

		var options = {
			center : startLatlng, // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};

		// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
		var map = new kakao.maps.Map(container, options);

		// 마커 이미지의 이미지 주소입니다
		var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";

		// 마커 이미지의 이미지 크기 입니다
		var imageSize = new kakao.maps.Size(24, 35);
		// 마커 이미지를 생성합니다    
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

		//마커 생성
		var startMarker = new kakao.maps.Marker({
			map : map,
			position : startLatlng,
			title : '출발',
			image : markerImage
		});
		var arriveMarker = new kakao.maps.Marker({
			map : map,
			position : arriveLatlng,
			title : '도착',
			image : markerImage
		});
		
		// 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
		var bounds = new kakao.maps.LatLngBounds();    
		bounds.extend(startLatlng);
		bounds.extend(arriveLatlng);
		map.setBounds(bounds);
		
		
		if ("${param.exist }") { //동승신청 시 이용중인 카풀이 있으면 돌아옴
			alert("이미 이용 중인 카풀이 존재합니다.");
		}
		$("#applyBtn").click(function() {
			if (parseInt("${vo.price}") > parseInt("${point}")) {
				alert("보유 포인트가 부족합니다. 마이페이지에서 포인트를 충전해 주세요.");
				return false;
			}
		});
	});
</script>
<style type="text/css">
.leftBox {
	width: 50%;
	height: 600px;
	margin: 5px;
	float: left;
}

#map {
	margin: 15px 0px 15px 0px;
}

.psg {
	width: 40%;
	height: 100%;
	margin: 5px;
	padding-left: 15px;
	float: left;
	border-left: 2px solid #95B7E7;
}

.title {
	font-size: x-large;
	font-weight: bold;
	margin-bottom: 15px;
}

.driverInfo {
	margin-top: 15px;
	margin-bottom: 15px;
}

.driverInfoDetail {
	padding-top: 15px;
}

.psgTitle {
	float: left;
	padding-top: 18px;
}

.psgApp, .psgFix {
	margin: 5px 5px 5px 10px;
}

.region {
	font-size: larger;
}

.afterApply {
	clear: both;
	padding-top: 30px;
}

.afterBtn {
	margin-right: 5%;
	margin-top: -5px;
}

.psgInfo {
	clear: left;
}

.circle {
	float: left;
	background-color: #ECF2FA;
	border-radius: 50%;
	width: 70px;
	height: 70px;
	margin: 5px;
}

.circle h4 {
	text-align: center;
	padding-top: 15px;
}

.eachPsg {
	clear: both;
}

.photo {
	float: left;
	border-radius: 50%;
	width: 70px;
	height: 70px;
	margin: 5px;
	padding: 0px;
}
</style>
</head>
<body>
	<div class="container">
		<h1>
			<b>동승자를 모집하고 있어요</b>
		</h1>
		<div class="leftBox">
			<div class="info">
				<div class="title">${vo.no}번차-운행정보</div>
				[${vo.startRegion }] <span class="region"><b>${vo.startAddress }</b></span>
				<span class="glyphicon glyphicon-arrow-right"></span>
				[${vo.arriveRegion }] <span class="region"><b>${vo.arriveAddress }</b></span>
				<br> ${vo.startTimePre } 출발 - ${vo.arriveTimePre } 도착 <br>

				<div id="map" style="width: 100%; height: 250px;"></div>




				<div class="driver">
					<div class="driverInfo">
						<div class="photo">
							<img class="img-circle" style="width: 70px;"
								src="${vo.profileImage }">
						</div>
						<div class="driverInfoDetail">
							드라이버 <b>${vo.nickname }</b><br> ${vo.driveCount }회 운행 | 평균별점
							${vo.starAvg } (${vo.starCount }회 참여)
						</div>
					</div>
					<div class="well"
						style="clear: both; margin-top: 15px; width: 60%;">
						<b>드라이버 메시지</b><br> ▶ ${vo.memo }
					</div>
					<b>차랑정보</b> ${vo.carModel } ${vo.carNo }<br> <b>동승료</b>
					${vo.price } 포인트
				</div>
				<hr>
			</div>
		</div>
		<div class="psg">
			<div class="apply">
				<c:if test="${login ne null }">
					<c:if test="${isPsg != 1 }">

						<form id="apply" action="apply.do" method="post">
							<div class="title">같이 타고 싶으신가요?</div>
							<input type="hidden" name="cpNo" value="${vo.no }"> [보유:
							${point } 포인트]<br> <label for="msg">※ 확정 후 모집이 마감되면
								취소할 수 없어요</label><input name="msg" class="form-control"
								style="width: 80%; float: left;"
								placeholder="신청 메시지를 입력하세요(ex. 같이 타요~)">
							<button id="applyBtn" class="btn btn-default pull-right">동승신청</button>
						</form>
					</c:if>
					<c:if test="${isPsg == 1 }">
						<div class="title">이 차에 동승을 신청했어요</div>
							아래 명단에서 확정여부를 확인하세요.
							<form action="cancelapply.do?cpNo=${vo.no}" method="post">
							<button class="btn btn-default pull-right afterBtn" style="margin-top:-25px;">신청취소</button>
						</form>
					</c:if>
					<div class="afterApply">
						<b>드라이버에게 문의할 내용이 있나요?</b> <a
							class="btn btn-primary pull-right afterBtn"
							href="/messageroom/write.do?par1=${vo.id }">메시지 보내기</a>
					</div>
				</c:if>
				<c:if test="${login == null }">
					<div>이 차에 함께 타고 싶다면 로그인하세요</div>
				</c:if>
				<hr>
			</div>
			<div class="psgApp">
				<div class="circle">
					<h4>${vo.psgAppCount }</h4>
				</div>
				<div class="title psgTitle">
					<b> 동승신청자</b>
				</div>
				<div class="psgInfo">

					<c:forEach items="${psgAppList }" var="pavo">
						<div class="eachPsg">
							<div class="photo">
								<img class="img-circle" style="width: 70px;"
									src="${pavo.profileImage }">
							</div>
							<div class="eachInfo">
								<b>${pavo.nickname }</b><br> 동승횟수 ${pavo.psgCount }회 | 평균별점
								${pavo.starAvg } (${pavo.starCount }명 참여) <br> ▶ ${pavo.msg }
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
			<hr>
			<div class="psgFix">
				<div class="circle">
					<h4>${vo.psgFixCount }/${vo.seats }</h4>
				</div>
				<div class="title psgTitle">
					<b> 동승확정자</b>
				</div>
				<div class="psgInfo">

					<p>
						<br> 동승확정자 : ${vo.psgFixCount} / ${vo.seats } <br>
						<c:forEach items="${psgFixList }" var="pfvo">
							<div class="eachPsg">
								<div class="photo">
									<img class="img-circle" style="width: 70px;"
										src="${pfvo.profileImage }">
								</div>
								<div class="eachInfo">
									<b>${pfvo.nickname }</b><br> 동승횟수 ${pfvo.psgCount }회 |
									평균별점 ${pfvo.starAvg } (${pfvo.starCount }명 참여) <br> ▶
									${pfvo.msg }
								</div>
							</div>
						</c:forEach>
					</p>
				</div>
			</div>
		</div>

	</div>
</body>
</html>