function idchk(){
   var id_length = document.getElementById("idchk1").value.length;
   var ch=document.getElementById("idchk1").value;
   if(id_length<4 || id_length>20){
	   document.getElementById("la_chk").innerHTML="4~20자의 영문자와 숫자만 사용 가능합니다."
		   for(var i=0; i<id_length; i++){
			   
			   var ch=document.getElementById("idchk1").value.charAt(i);
			   if((ch>="65"&& ch<="Z") || (ch>="a"&& ch<="z") || (ch>="0"&& ch<="9")){   
			   }else {document.getElementById("la_chk").innerHTML="5~20자의 영문자와 숫자만 사용 가능합니다.";}
		   }
   }else{
	   $.ajax({
			method : 'POST',
			url : '/TK/isid',
			headers : {
				'Content-Type' : 'application/json',
				'X-HTTP-Method-Override' : 'POST'
			},
			dataType : 'text',
			data : JSON.stringify({
				userid : ch
			}),
			success:function(result){
				if(result=='0'){
					document.getElementById("la_chk").innerHTML="이미 사용중인 아이디입니다."
					
				}else if(result=='1'){
					document.getElementById("la_chk").innerHTML=""
				}
			}
		})
   }
} 

function pwchk(){
   var pw_length = document.getElementById("pwchk1").value.length;
   if(pw_length<8 || pw_length>16){
     document.getElementById("la_pwchk").innerHTML="8~16자 영문자, 숫자, 특수문자만 사용 가능합니다."
   }else{
      document.getElementById("la_pwchk").innerHTML=""
    }
}

function pwchk2(){
   var pw_length = document.getElementById("pwchk1").value;
   var pw_length2 = document.getElementById("pwchk12").value;
   if(pw_length == pw_length2){
     document.getElementById("la_pwchk2").innerHTML=""
   }else{document.getElementById("la_pwchk2").innerHTML="비밀번호가 다릅니다."}
}

function email_chk(){		
	var email = document.getElementById("email").value;
	var exptext = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/; 
	if(exptext.test(email)==false){			
		document.getElementById("la_chk4").innerHTML = "이메일 주소를 다시 확인해주세요."
	}else{
		document.getElementById("la_chk4").innerHTML ="";
	}
}

function phone_chk(){		
	var phone = document.getElementById("phone").value;
	var exptext = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;
	if(exptext.test(phone)==false){			
		document.getElementById("phone_chk").innerHTML = "휴대폰번호를 다시 확인해주세요."
	}else{
		document.getElementById("phone_chk").innerHTML ="";
	}
}
