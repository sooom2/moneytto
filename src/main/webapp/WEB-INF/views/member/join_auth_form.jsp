<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="resources/css/main.css" rel="stylesheet">
<link href="resources/css/common.css" rel="stylesheet">
<link href="resources/css/inc.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member.css">
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script type="text/javascript" src="resources/js/main.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
  
$(function() {
	// 인증번호 확인.
	let mailStatus = false;
	
	// 이메일 인증
// 	$('#mail-Check-Btn').click(function() {
// 		const email = $('#join-id').val() // 이메일 주소값 얻어오기
// 		const checkInput = $('.mail-check-input') // 인증번호 입력하는곳
		
// 		$.ajax({
// 			type : 'get',
// 			url : 'mailCheck?email=' + email,
// 			success : function(data) {
// 				console.log("data : " +  data);
// 				checkInput.attr('disabled',false);
// 				code = data;
// 				alert('인증번호가 전송되었습니다.')
// 			}			
// 		})
// 	});
	
// 	//인증번호 비교 
// 	$('.mail-check-input').blur(function () {
// 		const inputCode = $(this).val();
// 		const resultMsg = $('#mail-check-warn');
		
// 		if(inputCode == code){
// 			resultMsg.html('인증번호가 일치합니다.');
// 			resultMsg.css('color','green');
// 			$('#mail-Check-Btn').attr('disabled',true);
// 			$('#join-id').attr('readonly',true);
// 			$('#join-id').attr('onFocus', 'this.initialSelect = this.selectedIndex');
// 	        $('#join-id').attr('onChange', 'this.selectedIndex = this.initialSelect');
// 	        mailStatus = true;
// 		}else{
// 			resultMsg.html('인증번호가 불일치 합니다. 다시 확인해주세요.');
// 			resultMsg.css('color','red');
// 		}
// 	});
	
	$("#btn-join").on("click", function() {
// 		if(!mailStatus) {
// 			alert("이메일 인증을 확인해주시기 바랍니다.");
// 			return false;
// 		} else {
			location.href="joinform?email=" + $('#join-id').val();
// 			return true;
// 		}
		
	});
});


</script>
</head>
<body>
	<jsp:include page="../nav.jsp" />
	<div id="container">
		<div id="content">
			<div class="section group section-member" id="joinSection">
				<div class="title">회원가입</div>
				<div class="wrap-member-box wrap-join-box">
					<ul class="join-indicator">
						<li class="selected">이메일 입력(소셜 가입)</li>
						<li>회원정보 입력</li>
						<li>가입 완료</li>
						<li>가입 완료</li>
					</ul>
					<form name="form-join" id="form-join" method="post" action="#">
						<div class="wrap-inside">
							<div class="join-email-desc" style="margin-top: 60px;">
								<span>이메일 주소로 가입</span>
							</div>
							<div class="join-email" >
								<div>
									<label class="label-email" for="email" style="margin-bottom: 10px;"> 아이디(이메일)
									<input	type="email" id="join-id" name="memberId" placeholder="이메일 주소를 입력해주세요.">
									</label>
								</div>
								<div>
									<label class="form-control mail-check-input">
									<button type="button" class="btn-rsv" id="mail-Check-Btn" style="margin-right: 24px;">본인인증</button>
									<input class="mail-check-input" placeholder="인증번호 6자리를 입력해주세요!" disabled="disabled" maxlength="6"><br>
									<span id="mail-check-warn"></span>
									</label>
								</div>
							</div>
						</div>
						<br>
						<a href="#" id="btn-join" class="btn-join">가입하기</a> 
						<input type="hidden" id="userFrom" name="userFrom" value="4">
						<input type="hidden" id="socialId" name="socialId" value="">
						<input type="hidden" id="name" name="name" value="">
						<input type="hidden" id="token" name="token" value=""> 
						<input type="hidden" id="isPayment" name="isPayment" value="0">
					</form>
				</div>
			</div>
			<form id="form-kakao-login" method="post" action="kakaoJoin">
   			<input type="hidden" name="email"/>
   			<input type="hidden" name="accessToken"/>
   		</form>
		</div>
	</div>
<jsp:include page="../footer.jsp" />
</body>
</html>