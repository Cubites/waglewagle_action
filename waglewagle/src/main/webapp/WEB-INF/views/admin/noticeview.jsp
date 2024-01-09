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
    <link rel="stylesheet" href="/resources/css/admin/noticeview.css"/>

	<script>
	
		//게시물 삭제
		function noticeDelete(){
			console.log(document.getElementById("notices_id").innerText);
		    if(confirm("선택한 공지를 정말로 삭제 하시겠습니까?")==true)  {
		    	const notices_id = document.getElementById("notices_id").innerText;
		    	location.href="/admin/noticedelete/${notices_id}";  	
		    }
		}
		//게시물 수정
		function noticesModify(){
			console.log(document.getElementById("notices_id").innerText);
			const notice_id = document.getElementById("notices_id").innerText;
			location.href="/admin/noticemodify/${notices_id}";
		}
		
		//사이드바 선택에 맞는 함수들..
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
            <img src="/resources/images/log.jpg" title="와글와글 로고"/ onclick="notice()">
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
            <h1>[ 공지사항 ]</h1><br/><br/>
            	<div class="noticeView">
					<div class="rightloc">
						<p style="font-size:15px" class="noticeinfo" id="notices_id">글번호: ${a.notices_id } &nbsp&nbsp 작성일: ${a.notices_date }</p>
					</div>
            	 
					<!-- 제목 -->
					<div class="leftloc"><p id="titletxt">제목</p></div>
					<div id="noticetitle">
						<input id="title" name="notices_title" value="${a.notices_title}">
					</div>
					<!-- 내용 -->
					<div class="leftloc"><p id="contenttxt">내용</p></div>
					<div id="noticecontent">
					<%-- <textarea><c:out value="${a.notices_content}" /></textarea> --%>
						<textarea style="resize: none;" id="noticecontent" name="notices_content">${a.notices_content}</textarea>
					</div>
            		
					<!-- 버튼들 -->
            		<div class="writebtn">
            			<!-- 공지 상세페이지 버튼들  -->
						<div id="notice_button">
							<input type="button" id="writebtn" value="목록" onclick="notice()">
							<input type="button" id="writebtn" value="수정" onclick="noticesModify()">
							<input type="button" id="writebtn" value="삭제" onclick="noticeDelete()">
		                 </div>
            		</div>
            	</div>
            </div>
        </div>
    </div>
</body> 
</html>