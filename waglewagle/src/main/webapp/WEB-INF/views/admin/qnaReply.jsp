<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<table>
	<tbody>
		<c:if test="${empty qnareply.list}">
              등록된 글이 없습니다.
		</c:if>
		
		<c:if test=${!empty qnareply.list }">
			<c:forEach var="vo" items="${qnareply.list }">
				<tr>
					<td>${a.qnas_reply}</td>
				</tr>
			</c:forEach>
		</c:if>
	</tbody>
</table>

<div id="main-box">
	<div class="noticeView">       		
		<div class="rightloc">
			<p style="font-size:15px" class="noticeinfo" id="qnas_id">글번호: ${a.qnas_id } &nbsp&nbsp 작성일: ${a.qnas_date }</p>
		</div>
	   	<!-- 작성자 -->
       	<div id="noticetitle">
           	<!-- <p id="titletxt">제목</p> -->
           	${a.users_id}
       	</div>
	   	<!-- 제목 -->
       	<div id="noticetitle">
          	<!--  <p id="titletxt">제목</p> -->
           	${a.qnas_title}
       	</div>
       	<!-- 내용 -->
       	<div id="noticecontent">
           	<!-- <p id="contenttxt">내용</p> -->
           	${a.qnas_content}
       	</div>
                
   		<!-- 버튼들 -->
   		<div class="writebtn">
   			<!-- 공지 상세페이지 버튼들  -->
			<div id="notice_button">
				<input type="button" id="writebtn" value="목록" onclick="qna()">
				<input type="button" id="writebtn" value="답글" onclick="qnaReply()">
				<!-- <input type="button" id="writebtn" value="수정" onclick="noticesModify()"> -->
				<input type="button" id="writebtn" value="삭제" onclick="qnaDelete()">
            </div>
		</div>
 	</div>
</div>

