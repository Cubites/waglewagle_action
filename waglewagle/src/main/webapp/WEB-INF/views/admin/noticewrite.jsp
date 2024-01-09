<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head> 
    <meta charset="utf-8">
    <title></title>
    <META name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
    <link rel="stylesheet" href="/resources/css/admin/noticewrite.css"/>

	<script>
	
	const registerForm = async() => {
	    let title = document.querySelector('#title');
	    let content = document.querySelector('#content');

	    //필수값 등록시 값 입력 여부 확인
	    if(title.value === ''){
	        alert('제목을 입력하세요!!!');
	        title.focus();
	        return false;
	    }
	    if(content.value === ''){
	        alert('내용을 입력하세요!!!');
	        content.focus();
	        return false;
	    }
		
	    document.WriteForm.action = '/admin/noticewrite';
	    document.WriteForm.submit();

	}
	
	    function notice(){
			 location.href = "/admin/noticelist";
		}
		function qna(){
			 location.href = "/admin/qnalist";
		}
		function stats(){
			 location.href = "/admin/stats";
		}
		function user(){
			 location.href = "/admin/userManageList";
		}
		function goods(){
			 location.href = "/admin/goodsManageList";
		}
		function admin(){
			 location.href = "/admin/adminmanage";
		}
		function password(){
			 location.href = "/admin/changePwd";
		}
	</script>
</head> 
<body>
	<div id="header">
        <div id="headerContainer">
            <br/>
            <img src="/resources/images/log.jpg" title="와글와글 로고" onclick="notice()"/>
        </div>
    </div>

    <div id="center">
        <div id="container">
            <div id="side-box">
                <div id="notice" onclick="notice()">공지</div>
                <div id="qna" onclick="qna()">문의</div>
                <div id="showdata" onclick="stats()">통계</div>
                <div id="adminuser" onclick="user()">회원관리</div>
                <div id="admingoods" onclick="goods()">상품관리</div>
                <div id="adminmaster" onclick="admin()">관리자 계정</div>
                <div id="chagepwd" onclick="password()">비밀번호 변경</div>
            </div>
            
            
            <div id="main-box">
            <h1>[ 공지사항 ]</h1><br/>
          		  <form name="WriteForm"  method="post">
                    <!-- 제목 -->
                    <div class="leftloc"><p id="titletxt">제목</p></div>
                    <div id="noticetitle">
                        <input id="title" name="notices_title" placeholder="공지 제목을 작성하세요.">
                    </div>
                    <!-- 내용 --> 
                   <div class="leftloc"><p id="contenttxt">내용</p></div>
                    <div id="noticecontent">
                        <textarea id="content" name="notices_content" placeholder="공지내용 작성 규칙에 맞춰 작성할 것"></textarea>
                    </div>
                    <!-- 공지업로드 버튼 -->
                    <div id="noticebutton">
                        <input type="button" id="writebtn" value="공지작성" onclick="registerForm()">
                        <input type="button" id="writebtn" value="공지목록" onclick="notice()">
                    </div>
                </form>
			      </div>
        </div>
    </div>
</body> 
</html>