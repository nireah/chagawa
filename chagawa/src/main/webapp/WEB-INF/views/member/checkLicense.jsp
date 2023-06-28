<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>면허번호 중복확인</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script type="text/javascript" src="/js/regEx.js"></script>

<script type="text/javascript">
$(function() {
	$("#useBtn").click(function() {
		$("#licenseNo_1", parent.opener.document).val($("#licenseNo1").val());
		$("#licenseNo_2", parent.opener.document).val($("#licenseNo2").val());
		$("#licenseNo_3", parent.opener.document).val($("#licenseNo3").val());
		$("#licenseNo_4", parent.opener.document).val($("#licenseNo4").val());
		window.close();
	});
	
	$("#checkBtn").click(function() {
		if (!checkData(reg_licenseNo_2, $("#licenseNo_1"), reg_licenseNo_error_msg, 1)) return false;
		if (!checkData(reg_licenseNo_2, $("#licenseNo_2"), reg_licenseNo_error_msg, 1)) return false;
		if (!checkData(reg_licenseNo_6, $("#licenseNo_3"), reg_licenseNo_error_msg, 1)) return false;
		if (!checkData(reg_licenseNo_2, $("#licenseNo_4"), reg_licenseNo_error_msg, 1)) return false;
		location = "checkLicense.sub?licenseNo_1="+$("#licenseNo_1").val()+"&licenseNo_2="+$("#licenseNo_2").val()+"&licenseNo_3="+$("#licenseNo_3").val()+"&licenseNo_4="+$("#licenseNo_4").val();
	});
});
</script>

<style type="text/css">
#u, #un{
	width: 50%;
	margin: 30px auto;
	text-align: center;
}
#licenseNo3, #licenseNo_3{
	width: 150px;
}
#useBtn, #checkBtn{
	margin: 0 0 0 10px;
}
</style>

</head>
<body>
<div class="container">
	<c:if test="${type==2}">
		<div>
			<div class="alert alert-info" id="u">사용가능한 면허번호 입니다.</div>
			<div class="form-inline" style="text-align: center">
				<label for="licenseNo1">면허번호:</label>
				<input class="form-control" name="licenseNo1" id="licenseNo1" readonly="readonly" value="${param.licenseNo_1}" style="width: 50px;"> -
				<input class="form-control" name="licenseNo2" id="licenseNo2" readonly="readonly" value="${param.licenseNo_2}" style="width: 50px;"> -
				<input class="form-control" name="licenseNo3" id="licenseNo3" readonly="readonly" value="${param.licenseNo_3}"> -
				<input class="form-control" name="licenseNo4" id="licenseNo4" readonly="readonly" value="${param.licenseNo_4}" style="width: 50px;">
				<button class="btn btn-info btn-sm" id="useBtn">사용하기</button>
			</div>
		</div>
	</c:if>
	
	<c:if test="${type==1}">
		<div>
			<div class="alert alert-danger" id="un">이미 사용중인 면허번호입니다.<br>다른 면허번호를 입력해 주세요.</div>
			<div class="form-inline" style="text-align: center">
				<label for="licenseNo_1">면허번호:</label>
				<input class="form-control" name="licenseNo_1" id="licenseNo_1" value="${param.licenseNo_1}" style="width: 50px;"> -
				<input class="form-control" name="licenseNo_2" id="licenseNo_2" value="${param.licenseNo_2}" style="width: 50px;"> -
				<input class="form-control" name="licenseNo_3" id="licenseNo_3" value="${param.licenseNo_3}"> -
				<input class="form-control" name="licenseNo_4" id="licenseNo_4" value="${param.licenseNo_4}" style="width: 50px;">
				<button class="btn btn-success btn-sm" id="checkBtn">중복확인</button>
			</div>
		</div>
	</c:if>
</div>
</body>
</html>