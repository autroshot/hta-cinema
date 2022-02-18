<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="modal fade" id="modal-login-form" data-bs-backdrop="static" tabindex="-1" aria-labelledby="loginFormModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="loginFormModalLabel">로그인</h5>
				<button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form id="form-login">
					<input type="text" class="form-control" name="id" placeholder="아이디" maxlength="12" />
					<input type="password" class="form-control mt-3" name="password" placeholder="비밀번호" maxlength="12" />
				</form>
					<div class="form-check mt-3">
						<input class="form-check-input" type="checkbox" value="" id="form-check-saveId" name="saveId">
						<label class="form-check-label" for="form-check-saveId">
							아이디 저장
						</label>
					</div>
					<div class="d-grid">
						<button id="btn-login" type="button" class="btn btn-primary btn-lg mt-3" disabled>로그인</button>
					</div>
				<button id="btn-call-login-error" data-bs-target="#modal-login-error" data-bs-toggle="modal" hidden></button>
				<div class="container-a mt-3">
					<a class="link-secondary" href="/customer/findIdPassword">ID/PW 찾기</a>
					<span class="divide-a-tag mx-3"></span>
					<a class="link-secondary" href="/customer/signUp">회원가입</a>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="modal-login-error" data-bs-backdrop="static" tabindex="-1" aria-labelledby="loginErrorModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-sm modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="loginErrorModalLabel">알림</h5>
				<button type="button" class="btn-close btn-close-white btn-ok" data-bs-target="#modal-login-form" data-bs-toggle="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<span id="span-login-error-message"></span>
				<div class="d-flex justify-content-center mt-3">
					<button class="btn btn-primary btn-ok" data-bs-target="#modal-login-form" data-bs-toggle="modal">확인</button>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="/resources/js/customer/formToJson.js"></script>
<script type="text/javascript">
	$(function() {
		const idInput = $("[name='id']");
		const passwordInput = $("[name='password']");
		
		const loginButton = $("#btn-login");
		
		// 출처: https://ktko.tistory.com/entry/Cookie를-이용하여-아이디-저장하기 [KTKO 개발 블로그와 여행 일기]
		let userInputId = getCookie("userInputId");
		let setCookieYN = getCookie("setCookieYN");
		
		if(setCookieYN == 'Y') {
	        $("#form-check-saveId").prop("checked", true);
	    } else {
	        $("#form-check-saveId").prop("checked", false);
	    }
		
		idInput.val(userInputId);

		//쿠키값 설장하기
		function setCookie(cookieName, value, exdays){
		    var exdate = new Date();
		    exdate.setDate(exdate.getDate() + exdays);
		    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + 
		    exdate.toGMTString());
		    document.cookie = cookieName + "=" + cookieValue;
		}

		//쿠키값 삭제하기
		function deleteCookie(cookieName){
		    var expireDate = new Date();
		    expireDate.setDate(expireDate.getDate() - 1);
		    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
		}

		//쿠키값 가져오기
		function getCookie(cookie_name) {
		    var x, y;
		    var val = document.cookie.split(';');
		    
		    for (var i = 0; i < val.length; i++) {
		        x = val[i].substr(0, val[i].indexOf('='));
		        y = val[i].substr(val[i].indexOf('=') + 1);
		        x = x.replace(/^\s+|\s+$/g, ''); // 앞과 뒤의 공백 제거하기
		        
		        if (x == cookie_name) {
		          return unescape(y); // unescape로 디코딩 후 값 리턴
		        }
		    }
		}
		///////////////////////////////////////////////////////////////////////////////////////////
		
		// 아이디 저장 체크박스를 확인한다.
		// 체크되어 있다면 쿠키에 아이디와 쿠키설정여부를 저장한다.
		// 체크되어 있지 않다면 쿠키에서 아이디와 쿠키설정여부를 삭제한다.
		function checkSaveIdChecked() {
			if ($("#form-check-saveId").prop("checked")) {
				let userInputId = idInput.val();
				
				setCookie("userInputId", userInputId, 3); 
	            setCookie("setCookieYN", "Y", 3);
			} else {
				deleteCookie("userInputId");
	            deleteCookie("setCookieYN");
			}
		}
		
		// id와 password 입력폼이 비어있는지 확인하고, 하나라도 비어있으면 로그인 버튼을 비활성화한다.
		function checkInputValueEmpty() {
			if ((idInput.val() === "") || (passwordInput.val() === "")) {
				$("#btn-login").prop("disabled", true);
			} else {
				$("#btn-login").prop("disabled", false);
			}
		}
		
		// 아이디와 비밀번호 input에서 키보드 입력이 있을 때마다 checkInputValueEmpty() 함수를 실행한다.
		idInput.keyup(function(event) {
			checkInputValueEmpty();
		});
		passwordInput.keyup(function(event) {
			checkInputValueEmpty();
		});
		
		// 아이디 input에서 엔터키를 누르면 비밀번호 input으로 포커스가 이동한다.
		idInput.keyup(function(event) {
			if (event.keyCode === 13) {
				passwordInput.focus();
			}
		});
		// 비밀번호 input에서 엔터키를 눌렀고 로그인 버튼이 활성화 상태라면, 로그인 버튼이 클릭되는 이벤트가 발생한다.
		passwordInput.keyup(function(event) {
			if (event.keyCode === 13 && !loginButton.prop("disabled")) {
				$("#btn-login").trigger("click");
			}
		});
		
		// 로그인 버튼을 클릭했을 때 실행되며, ajax 통신을 통해 서버에 아이디와 비밀번호를 전송하고 서버에서 로그인 처리 결과를 받아온다.
		loginButton.click(function(event) {
			const jsonData = JSON.stringify(formToJson($("#form-login")));
			
			$.ajax({
				type: "POST",
				url: "/customer/login",
				data: jsonData,
				contentType: "application/json",
				dataType: "json",
				success: function(response) {
					if (response.status) {
						checkSaveIdChecked();
						
						window.location.reload();
					} else {
						document.getElementById("span-login-error-message").innerHTML = response.error;

						$("#btn-call-login-error").trigger("click");
					}
				}
			});
		});
		
		// 로그인 에러 모달의 확인이나 닫기 버튼을 클릭했을 때 실행되며, 아이디/비밀번호 input의 값을 초기화하고 로그인 버튼을 비활성화한다.
		$(".btn-ok").click(function(event) {
			idInput.val("");
			passwordInput.val("");
			$("#btn-login").prop("disabled", true);
		});
	});
</script>