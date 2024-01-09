<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Sample</title>
	<link rel="stylesheet" href="/resources/css/common/common.css">
	<link rel="stylesheet" href="/resources/css/board/noticeview.css">
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script>
	function notice(){
		 location.href = "/board/noticelist";
	}
	</script>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<%@ include file="/WEB-INF/views/common/quickmenu.jsp" %>
	<div id="center">
		<div id="container">
			
			<div id="viewpage" >
			
			<!-- 여기부분 작성함 -->
				<div id="main-box">
            	<div class="noticeView">
            	   <div class="rightloc"><p style="font-size:15px" class="noticeinfo" id="notices_id">작성일: ${a.notices_date }</p></div>
            	 
            	   <!-- 제목 -->
            	   <div class="nview">
	            	   <div class="f">공지 제목</div>&nbsp
	                   <div id="noticetitle" class="s">
	                       <input id="title" name="notices_title" value="${a.notices_title}">
	                   </div>
                   </div>
                   
                   <!-- 내용 -->
                   <div class="nview">
                   		<div class="f">공지 내용</div>&nbsp
                   		<div>
		                   <div id="noticecontent">
		                   <textarea style="resize: none;" id="noticecontent" name="notices_content">${a.notices_content}</textarea>
		                   </div>
		                               		<!-- 버튼 -->
            		<div class="writebtn">
						<div id="notice_button">
							<input type="button" id="writebtn" value="목록" onclick="notice()">
		                 </div>
            		</div>
		                   
	                   </div>
                   </div>

            	</div>
            </div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>