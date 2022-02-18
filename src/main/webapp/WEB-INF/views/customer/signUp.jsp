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
	<link rel="stylesheet" href="/resources/css/customer/signUp.css" />
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
			<div class="row mb-2">
				<div class="col p-0">
					<span>회원정보를 입력해주세요.</span>
				</div>
			</div>
			<form id="form-signUp">
				<div class="row p-0 row-top">
					<div class="col-3 m-0 ps-3 py-3 col-label">
						<label for="input-id">아이디</label>
					</div>
					<div class="col-6 align-self-center">
						<input type="text" class="form-control" id="input-id" name="id" placeholder="영문, 숫자 조합(8~12자)" maxlength="12" />
					</div>
					<div class="col-3 align-self-center">
						<button id="btn-check-id-duplicate" type="button" class="btn btn-primary" disabled>중복확인</button>
					</div>
				</div>
				<div id="div-id-error" class="row p-0 row-other" hidden>
					<div class="col-3 m-0 ps-3 py-3 col-label"></div>
					<div class="col-9 align-self-center">
						<span class="error">아이디는 영문, 숫자가 모두 포함되어야 하며 8자리 이상 12자리 이하만 가능합니다.</span>
					</div>
				</div>
				<div class="row p-0 row-other">
					<div class="col-3 m-0 ps-3 py-3 col-label">
						<label for="input-password">비밀번호</label>
					</div>
					<div class="col-9 align-self-center">
						<input type="password" class="form-control" id="input-password" name="password" 
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
				<div class="row p-0 row-other">
					<div class="col-3 m-0 ps-3 py-3 col-label">
						<label for="input-password-check">비밀번호 확인</label>
					</div>
					<div class="col-9 align-self-center">
						<input type="password" class="form-control" id="input-password-check" 
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
				<div class="row p-0 row-other">
					<div class="col-3 m-0 ps-3 py-3 col-label">
						<label for="input-name">이름</label>
					</div>
					<div class="col-9 align-self-center">
						<input type="text" id="input-name" class="form-control" name="name" placeholder="이름" maxlength="17" />
					</div>
				</div>
				<div class="row p-0 row-other">
					<div class="col-3 m-0 ps-3 py-3 col-label">
						<label for="input-birthDate">생년월일</label>
					</div>
					<div class="col-9 align-self-center">
						<input type="date" id="input-birthDate" class="form-control" name="birthDate" />
					</div>
				</div>
				<div class="row p-0 row-other">
					<div class="col-3 m-0 ps-3 py-3 col-label">
						<label for="input-phoneNumber">휴대폰 번호</label>
					</div>
					<div class="col-9 align-self-center">
						<input type="text" class="form-control" id="input-phoneNumber" name="phoneNumber" placeholder="'-' 없이 입력" maxlength="11" />
					</div>
				</div>
				<div id="div-phoneNumber-error" class="row p-0 row-other" hidden>
					<div class="col-3 m-0 ps-3 py-3 col-label"></div>
					<div class="col-9 align-self-center">
						<span class="error">잘못된 휴대폰 번호 형식입니다.</span>
					</div>
				</div>
				<div class="row p-0 row-other">
					<div class="col-3 m-0 ps-3 py-3 col-label">
						<label for="input-email">이메일 주소</label>
					</div>
					<div class="col-9 align-self-center">
						<input type="text" class="form-control" id="input-email" name="email" placeholder="이메일 주소를 입력해주세요." maxlength="330" />
					</div>
				</div>
				<div id="div-email-error" class="row p-0 row-other" hidden>
					<div class="col-3 m-0 ps-3 py-3 col-label"></div>
					<div class="col-9 align-self-center">
						<span class="error">잘못된 이메일 형식입니다.</span>
					</div>
				</div>
				<!-- 
				<div class="row p-0 mb-4 row-other">
					<div class="col-3 m-0 ps-3 py-3 col-label">
						<label>나만의<br>메가박스</label>
					</div>
					<div class="col-6 align-self-center">
						<span>자주 방문하는 메가박스를 등록해 주세요!</span>
					</div>
					<div class="col-3 align-self-center">
						<button id="btn-set" type="button" class="btn btn-primary" disabled>설정</button>
					</div>
				</div>
				 -->
				<div class="row mt-4">
					<div class="d-grid col-6 mx-auto">
						<button id="btn-signUp" type="button" class="btn btn-primary btn-lg" disabled>회원가입</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
<script src="/resources/js/customer/regExp.js"></script>
<script src="/resources/js/customer/showErrorDiv.js"></script>
<script src="/resources/js/customer/showTopRowErrorDiv.js"></script>
<script src="/resources/js/customer/showTooltip.js"></script>
<script src="/resources/js/customer/enableButton.js"></script>
<script src="/resources/js/customer/Validation.js"></script>
<script src="/resources/js/customer/ValidationWithSave.js"></script>
<script src="/resources/js/customer/IdValidation.js"></script>
<script src="/resources/js/customer/PasswordValidation.js"></script>
<script src="/resources/js/customer/PasswordValidationWithSave.js"></script>
<script>
$(function() {
	const idInput = $("#input-id");
	const passwordInput = $("#input-password");
	const passwordCheckInput = $("#input-password-check");
	const nameInput = $("#input-name");
	const birthDateInput = $("#input-birthDate");
	const phoneNumberInput = $("#input-phoneNumber");
	const emailInput = $("#input-email");
	
	const idErrorDiv = $("#div-id-error");
	const passwordErrorDiv = $("#div-password-error");
	const matchErrorDiv = $("#div-match-error");
	const phoneNumberErrorDiv = $("#div-phoneNumber-error");
	const emailErrorDiv = $("#div-email-error");
	
	const checkIdDuplicateButton = $("#btn-check-id-duplicate");
	const signUpButton = $("#btn-signUp");
	
	const noticeModal = new bootstrap.Modal(document.getElementById("modal-notice"), {
		keyboard: false
	});
	const noticeModalSpan = document.getElementById("span-notice-message");
	$("#modal-dialog").addClass("modal-sm");
	
	const passwordInputTooltip = new bootstrap.Tooltip(passwordInput);
	const passwordCheckInputTooltip = new bootstrap.Tooltip(passwordCheckInput);
	
	const idValidationWithSave = new ValidationWithSave(idInput, idReg);
	const idValidation = new IdValidation(idInput, englishReg, numberReg);
	const passwordValidationWithSave = new PasswordValidationWithSave(passwordInput, koreanReg, passwordReg);
	const passwordValidation = new PasswordValidation(passwordInput, englishReg, numberReg, specialReg);
	const passwordCheckValidationWithSave = new PasswordValidationWithSave(passwordCheckInput, koreanReg, passwordReg);
	const nameValidationWithSave = new ValidationWithSave(nameInput, nameReg);
	const phoneNumberValidationWithSave = new ValidationWithSave(phoneNumberInput, onlyNumberReg);
	const phoneNumberValidation = new Validation(phoneNumberInput, phoneNumberReg);
	const emailValidation = new Validation(emailInput, emailReg);
	
	// 아이디 중복확인을 통과하면 true가 되는 flag다.
	let idDuplicateValidationFlag = false;
	// 비밀번호와 비밀번호 확인이 일치하면 true가 되는 falg다.
	let passwordValueMatchValidationFlag = false;
	
	// 모든 유효성 검사 flag가 true이고 input 값이 비어있지 않은지를 확인한다.
	function isAllFlagTrue() {
		return idValidation.flag && idDuplicateValidationFlag
			&& passwordValidation.flag && passwordValueMatchValidationFlag
			&& nameValidationWithSave.flag
			&& birthDateInput.val() !== ""
			&& phoneNumberValidation.flag
			&& emailValidation.flag
	}
	
	// 비밀번호와 비밀번호 확인 input의 값이 일치하면 flag를 true로 변경한다.
	function passwordValueMatchValidation() {
		if (passwordInput.val() === passwordCheckInput.val()) {
			passwordValueMatchValidationFlag = true;
		} else {
			passwordValueMatchValidationFlag = false;
		}
	}
	
	// 아이디에 키보드 입력이 있을 때마다 실행된다.
	// input 값에 대해 유효성 검사를 실시하고 결과에 따라 "중복확인" 버튼을 활성화/비활성화한다.
	idInput.on("input", function() {
		idDuplicateValidationFlag = false;
		
		idValidationWithSave.test();
		idValidation.test();
		
		showTopRowErrorDiv(idErrorDiv, !idValidation.flag);
		enableButton(checkIdDuplicateButton, idValidation.flag);
		enableButton(signUpButton, isAllFlagTrue());
	});
	
	// "중복확인" 버튼을 클릭했을 때 실행되며, ajax 통신을 통해 서버로 아이디를 보내고 아이디 중복 여부를 받아온다.
	checkIdDuplicateButton.click(function() {
		const id = idInput.val();
		
		$.ajax({
			type: "post",
			url: "/customer/checkIdDuplicate",
			data: {id: id},
			dataType: "json",
			success: function(response) {
				if (response.status) {
					let {items:{isIdDuplicate, message}} = response;
					
					console.log("isIdDuplicate: " + isIdDuplicate);
					console.log("message: " + message);
					idDuplicateValidationFlag = !isIdDuplicate;
					noticeModalSpan.innerHTML = message;
					
					enableButton(signUpButton, isAllFlagTrue());
				} else {
					noticeModalSpan.innerHTML = "통신 실패";
				}
				noticeModal.show();
			}
		});
	});
	
	// 비밀번호와 비밀번호 확인에 키보드 입력이 있을 때마다 실행된다.
	// input 값에 대해 유효성 검사를 실시하고 결과에 따라 "회원가입" 버튼을 활성화/비활성화한다.
	passwordInput.on("input", function() {
		if (!passwordValidationWithSave.test()) {
			showTooltip(passwordInputTooltip);
		}
		passwordValidation.test();
		passwordValueMatchValidation();
		
		showErrorDiv(passwordErrorDiv, !passwordValidation.flag);
		showErrorDiv(matchErrorDiv, !passwordValueMatchValidationFlag);
		enableButton(signUpButton, isAllFlagTrue());
	});
	passwordCheckInput.on("input", function() {
		if (!passwordCheckValidationWithSave.test()) {
			showTooltip(passwordCheckInputTooltip);
		}
		passwordValueMatchValidation();
		
		showErrorDiv(matchErrorDiv, !passwordValueMatchValidationFlag);
		enableButton(signUpButton, isAllFlagTrue());
	});
	
	// 이름에 키보드 입력이 있을 때마다 실행되며, input 값에 대해 유효성 검사를 실시한다.
	nameInput.on("input", function() {
		nameValidationWithSave.test();
		
		enableButton(signUpButton, isAllFlagTrue());
	});
	
	birthDateInput.change(function() {
		enableButton(signUpButton, isAllFlagTrue());
	});
	
	// 핸드폰 번호에 키보드 입력이 있을 때마다 실행되며, input 값에 대해 유효성 검사를 실시한다.
	phoneNumberInput.on("input", function() {
		phoneNumberValidationWithSave.test();
		phoneNumberValidation.test();
		
		showErrorDiv(phoneNumberErrorDiv, !phoneNumberValidation.flag);
		enableButton(signUpButton, isAllFlagTrue());
	});
	
	// 이메일에 키보드 입력이 있을 때마다 실행되며, input 값에 대해 유효성 검사를 실시한다.
	emailInput.on("input", function() {
		emailValidation.test();
		
		showErrorDiv(emailErrorDiv, !emailValidation.flag);
		enableButton(signUpButton, isAllFlagTrue());
	});
	
	// "회원가입" 버튼을 클릭하면 실행되며, ajax 통신을 통해 서버에 form의 값들을 보내고 처리 결과를 받아와서 알림 모달에 표시한다.
	signUpButton.click(function() {
		const jsonData = JSON.stringify({
			"id": idInput.val(),
			"password": passwordInput.val(),
			"name": nameInput.val(),
			"birthDate": birthDateInput.val(),
			"phoneNumber": phoneNumberInput.val(),
			"email": emailInput.val()
			});
		
		$.ajax({
			type: "POST",
			url: "/customer/signUp",
			data: jsonData,
			contentType: "application/json",
			dataType: "json",
			success: function(response) {
				if (response.status) {
					noticeModalSpan.innerHTML = response.items;
					$("#modal-notice button").addClass("btn-redirect-home");
				} else {
					noticeModalSpan.innerHTML = response.error;
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