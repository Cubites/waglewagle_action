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
    <link rel="stylesheet" href="/resources/css/admin/noticemodify.css"/>

	<script>

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

		
  		function noticeModify(){
			console.log(document.getElementById("notices_id").innerText); //찍히나??
			if(confirm("수정완료?")) {
				$("#noticemodify").submit();
			}
		}		
 </script>
</head> 
<body>
	<div id="header">
        <div id="headerContainer">
            <br/>
            <img src="/resources/images/log.jpg" title="와글와글 로고 onclick="notice()"/>
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
            	<h1>[ 공지수정 ]</h1><br/><br/>
            	<div class="rightloc">
            		<p style="font-size:15px" class="noticeinfo" id="notices_id">글번호: ${a.notices_id } &nbsp&nbsp 작성일: ${a.notices_date }</p>
            	</div>
            	<form id="noticemodify" method="post" action="/admin/noticeModify">
            	<input type="hidden" name="notices_id" value="${notices_id}"/>
            	
                    <!-- 제목 -->
               		<div class="leftloc">
               			<p id="titletxt">제목</p>
               		</div>
                    <div id="noticetitle">
                        <input id="title" name="notices_title" value="${a.notices_title}">
                    </div>
                    
                    <!-- 내용 -->
                    <div class="leftloc">
                    	<p id="contenttxt">내용</p>
                    </div>
                    <div id="noticecontent">
                        <textarea style="resize: none;" id="content" name="notices_content">${a.notices_content}</textarea>
                    </div>


                    <!-- 수정페이지버튼 -->
                    <div id="noticebutton">
                    	<input type="button" id="writebtn" value="수정완료" onclick="noticeModify()">
                        <input type="button" id="writebtn" value="취소" onclick="notice()">
                    </div>
				</form>
            </div>
        </div>
    </div>
</body> 
</html>