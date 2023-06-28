<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>차가와 - <decorator:title /></title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style type="text/css">
</style>
<script type="text/javascript">
	
</script>
<style>
.msgbtn {
  background-color : #4B89DC;
  width: 10%;
  margin: 10px;
  padding: 30px;
  text-align: center;
  text-transform: uppercase;
  transition: 0.5s;
  background-size: 100%;
  color: white;
  box-shadow: 0 0 20px #eee;
  border-radius: 10px;	
  position : fixed;
  bottom: 0;
  right: 0;
}
</style>
<decorator:head />
</head>
<body>
	<header>
		<nav class="navbar navbar-default" style="background-color: #4B89DC;">
			<div class="container">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse"
						data-target="#myNavbar">
						<span class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="/" style="padding: 6px;"><img style="width: 40px;" src="/upload/member/chagawa.jpg"></a> 
					<a class="navbar-brand" href="/" style="color: #EDF3FB; text-shadow: 1px 1px">차가와</a>
				</div>
				<div class="collapse navbar-collapse" id="myNavbar">
					<ul class="nav navbar-nav navbar-right">
						<c:if test="${login ne null && (login.gradeNo == 1 || login.gradeNo == 2)}">
							<li><a href="/carpool/now.do" style="color: #EDF3FB">이용중인 카풀</a></li>
						</c:if>
						<li><a href="/notice/list.do" style="color: #EDF3FB">공지사항</a></li>
						<li><a href="/carpool/list.do" style="color: #EDF3FB">카풀</a></li>
						<li><a href="/epilogue/list.do" style="color: #EDF3FB">이용후기</a></li>
						<c:if test="${login ne null }">
							<li><a href="/messageroom/list.do" style="color: #EDF3FB">메시지<span class="label label-danger">${messagecount}</span>
							</a>
							</li>							
						</c:if>
						<c:if
							test="${login ne null && (login.gradeNo == 1 || login.gradeNo == 2)}">
							<li><a href="/member/myPage.do?id=${login.id}" style="color: #EDF3FB">마이페이지</a></li>
							<li><a href="/member/logout.do" style="color: #EDF3FB">로그아웃</a></li>
						</c:if>
						<c:if test="${login ne null && login.gradeNo == 9}">
							<li><a href="/member/list.do" style="color: #EDF3FB">회원리스트</a></li>
							<li><a href="/point/list.do?id=${login.id }" style="color: #EDF3FB">수수료 수입</a></li>
							<li><a href="/member/logout.do" style="color: #EDF3FB">로그아웃</a></li>
						</c:if>
						<c:if test="${login == null}">
							<li><a href="/member/terms.do" style="color: #EDF3FB">회원가입</a></li>
							<li><a href="/member/login.do" style="color: #EDF3FB">로그인</a></li>
						</c:if>
					</ul>
				</div>
			</div>
		</nav>
	</header>
	<decorator:body />
	<footer id = "footer">
  <div class="wrapper">
    <c:if test="${login ne null && (login.gradeNo == 1 || login.gradeNo == 2)}">
        <a class ="msgbtn" href="/messageroom/write.do?par1=admin" style="color: #EDF3FB;">문의하기</a>
    </c:if>
  </div>
  </footer>
</body>

</html>