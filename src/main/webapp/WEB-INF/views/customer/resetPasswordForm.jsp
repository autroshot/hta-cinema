<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>HTA CINEMA</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<link rel="stylesheet" href="/resources/css/common.css" />
	<link rel="stylesheet" href="/resources/css/customer/customerCommon.css" />
	<link rel="stylesheet" href="/resources/css/customer/resetPasswordForm.css" />
	<link rel="icon" href="/resources/images/favicon.ico" type="image/x-icon">
</head>
<body>
<%@include file="/WEB-INF/views/common/noticeModal.jsp"%>
	<div class="container">
		<div class="content-wrap mx-auto">
			<div class="row">
				<div class="col">
					<a class="nav-link my-5" href="/">
						<img id="img-logo" src="/resources/images/logo/logo-htacinema-purple.png">
					</a>
				</div>
			</div>
			<div class="row mb-4">
				<div class="col">
					<h3>비밀번호 재설정</h3>
				</div>
			</div>
			<div class="row">
				<div class="col px-0 mx-0">
					<ul class="ul-green">
						<li>보안인증이 완료되었습니다. 새로 사용하실 비밀번호를 입력해주세요.</li>
					</ul>
				</div>
			</div>
			<form id="form-resetPassword">
				<div class="row p-0 row-top">
					<div class="col-3 m-0 ps-3 py-3 col-label">
						<label>아이디</label>
					</div>
					<div class="col-9 align-self-center">
						<span>${CUSTOMER_ID }</span>
					</div>
				</div>
				<div class="row p-0 row-other">
					<div class="col-3 m-0 ps-3 py-3 col-label">
						<label for="input-newPassword">새 비밀번호</label>
					</div>
					<div class="col-9 align-self-center">
						<input type="password" class="form-control" id="input-newPassword" name="newPassword" 
						placeholder="영문, 숫자, 특수기호 중 2가지 이상 조합" maxlength="16" 
						data-bs-toggle="tooltip" data-bs-placement="top" data-bs-trigger="manual" 
						title="비밀번호 설정 시 사용가능한 특수문자는 ~ ! @ # $ % ^ & * + = - ? _ 입니다." />
					</div>
				</div>
				<div id="div-password-error" class="row p-0 row-other" hidden>
					<div class="col-3 m-0 ps-3 py-3 col-label"></div>
					<div class="col-9 align-self-center">
						<span class="error">비밀번호는 영문, 숫자, 특수기호 중 2가지 이상을 조합해야 하며 10자리 이상 16자리 이하만 가능합니다.</span>
					</div>
				</div>
			</form>
			<div class="row p-0 row-other">
				<div class="col-3 m-0 ps-3 py-3 col-label">
					<label for="input-check-newPassword">새 비밀번호 확인</label>
				</div>
				<div class="col-9 align-self-center">
					<input type="password" class="form-control" id="input-newPassword-check" 
					placeholder="영문, 숫자, 특수기호 중 2가지 이상 조합" maxlength="16" 
					data-bs-toggle="tooltip" data-bs-placement="top" data-bs-trigger="manual" 
					title="비밀번호 설정 시 사용가능한 특수문자는 ~ ! @ # $ % ^ & * + = - ? _ 입니다." />
				</div>
			</div>
			<div id="div-match-error" class="row p-0 row-other" hidden>
				<div class="col-3 m-0 ps-3 py-3 col-label"></div>
				<div class="col-9 align-self-center">
					<span class="error">비밀번호와 비밀번호 확인의 입력값이 일치하지 않습니다.</span>
				</div>
			</div>
			<div class="row mt-3 mb-4">
				<div class="col px-0 mx-0">
					<ul>
						<li>비밀번호는 영문, 숫자, 특수기호 중 2가지 이상을 조합해야 하며 10자리 이상 16자리 이하만 가능합니다.</li>
						<li>비밀번호 설정 시 사용가능한 특수문자는 ~ ! @ # $ % ^ & * + = - ? _ 입니다.</li>
					</ul>
				</div>
			</div>
			<div class="row">
				<div class="d-grid col-6 mx-auto">
					<button id="btn-resetPassword" type="button" class="btn btn-primary btn-lg" disabled>확인</button>
				</div>
			</div>
		</div>
	</div>
</body>
<script src="/resources/js/customer/regExp.js"></script>
<script src="/resources/js/customer/showErrorDiv.js"></script>
<script src="/resources/js/customer/showTooltip.js"></script>
<script src="/resources/js/customer/enableButton.js"></script>
<script src="/resources/js/customer/PasswordValidationWithSave.js"></script>
<script src="/resources/js/customer/PasswordValidation.js"></script>
<script src="/resources/js/customer/formToJson.js"></script>
<script>
$(function() {
	const newPasswordInput = $("#input-newPassword");
	const newPasswordCheckInput = $("#input-newPassword-check");
	const passwordErrorDiv = $("#div-password-error");
	const matchErrorDiv = $("#div-match-error");
	
	const resetPasswordButton = $("#btn-resetPassword");
	
	const newPasswordInputTooltip = new bootstrap.Tooltip(newPasswordInput);
	const newPasswordCheckInputTooltip = new bootstrap.Tooltip(newPasswordCheckInput);
	
	const noticeModal = new bootstrap.Modal(document.getElementById("modal-notice"), {
		keyboard: false
	});
	const noticeModalMessageSpan = document.getElementById("span-notice-message");
	
	const newPasswordValidationWithSave = new PasswordValidationWithSave(newPasswordInput, koreanReg, passwordReg);
	const newPasswordValidation = new PasswordValidation(newPasswordInput, englishReg, numberReg, specialReg);
	const newPasswordCheckValidationWithSave = new PasswordValidationWithSave(newPasswordCheckInput, koreanReg, passwordReg);
	
	// 비밀번호와 비밀번호 확인이 일치하면 true가 되는 falg다.
	let passwordValueMatchValidationFlag = false;
	
	// 모든 유효성 검사 flag가 true인지 확인한다.
	function isAllFlagTrue() {
		return newPasswordValidationWithSave.flag 
			&& newPasswordCheckValidationWithSave.flag
			&& newPasswordValidation.flag
			&& passwordValueMatchValidationFlag
	}
	
	// 비밀번호와 비밀번호 확인 input의 값이 일치하면 flag를 true로 변경한다.
	function passwordValueMatchValidation() {
		if (newPasswordInput.val() === newPasswordCheckInput.val()) {
			passwordValueMatchValidationFlag = true;
		} else {
			passwordValueMatchValidationFlag = false;
		}
	}
	
	// 비밀번호에 입력이 있을 때마다 실행되며 input 값에 대해 유효성 검사를 실시한다.
	newPasswordInput.on("input", function() {
		if (!newPasswordValidationWithSave.test()) {
			showTooltip(newPasswordInputTooltip);
		}
		newPasswordValidation.test();
		passwordValueMatchValidation();
		
		showErrorDiv(passwordErrorDiv, !newPasswordValidation.flag);
		showErrorDiv(matchErrorDiv, !passwordValueMatchValidationFlag);
		enableButton(resetPasswordButton, isAllFlagTrue());
	});
	// 비밀번호 확인에 입력이 있을 때마다 실행되며 input 값에 대해 유효성 검사를 실시한다.
	newPasswordCheckInput.keyup(function() {
		if (!newPasswordCheckValidationWithSave.test()) {
			showTooltip(newPasswordInputTooltip);
		}
		passwordValueMatchValidation();
		
		showErrorDiv(matchErrorDiv, !passwordValueMatchValidationFlag);
		enableButton(resetPasswordButton, isAllFlagTrue());
	});
	
	// 확인 버튼을 클릭했을 때 실행되며, ajax 통신을 통해 새 비밀번호를 서버로 보내고 처리 결과를 받아온다.
	// 처리 결과가 성공이면 알림 모달을 통해 결과를 알리고, 모달의 버튼들에 홈페이지로 redirect하는 이벤트를 등록하기 위해 클래스를 추가한다.
	// 처리 결과가 실패이면 알림 모달을 통해 에러 내용을 알려준다.
	$("#btn-resetPassword").click(function(event) {
		const jsonData = JSON.stringify(formToJson($("#form-resetPassword")));
		
		$.ajax({
			type: "post",
			url: "/customer/resetPassword",
			data: jsonData,
			contentType: "application/json",
			dataType: "json",
			success: function(response) {
				if (response.status) {
					noticeModalMessageSpan.innerHTML = response.items;
					$("#modal-notice button").addClass("btn-redirect-home");
				} else {
					noticeModalMessageSpan.innerHTML = response.error;
				}
				noticeModal.show();
			}
		});
	});
	
	// 알림 모달의 버튼들에 홈페이지로 redirect하는 이벤트를 등록한다.
	$("#modal-notice").on("click", ".btn-redirect-home", function(event) {
		location.replace("/");
	});
});
</script>
</html>