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
    <link rel="stylesheet" href="/resources/css/admin/qnalist.css"/>
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

    </script>
</head> 
<body>
	<div id="header">
        <div id="headerContainer">
            <br/>
            <img src="/resources/images/log.jpg" title="와글와글 로고 "/ onclick="notice()">
        </div>
    </div>

    <div id="center">
        <div id="container">
            <div id="side-box">
                <div id="notice" onclick="notice()"><a href=""></a>공지</div>
                <div id="qna" onclick="qna()">문의</div>
                <div id="showdata" onclick="stats()">통계</div>
                <div id="adminuser" onclick="user()">회원관리</div>
                <div id="admingoods" onclick="goods()">상품관리</div>
                <div id="adminmaster" onclick="admin()">관리자 계정</div>
                <div id="chagepwd" onclick="password()">비밀번호 변경</div>
            </div>
            <div id="main-box">
                <div id="plus"> 문의검색 &nbsp;
                    <form method="get" name="searchForm" id="searchForm" action="/admin/qnalist">
                        <input type="text" id="sQnas" name="searchWord" value="${qnasVO.searchWord}"  title="검색어입력하세요." placeholder="검색할 제목을 입력하세요.">&nbsp;&nbsp;
                        <input type="submit" id="searchbtn" value="검색" title="검색">
                    </form>
                </div>

                <!-- qna리스트 -->
                <div class="noticelist">	
					          <table class="nlist">
						            <colgroup>
                            <col width="80px" />
                            <col width="*" />
                            <col width="100px" />
                            <col width="100px" />
                            <col width="100px" />
                        </colgroup>

                        <thead>
                            <tr>
                                <th>번호</th>
                                <th>제목</th>
                                <th>작성자</th>
                                <th>작성일</th>
                                <th>답변여부</th>
                            </tr>
                        </thead>
                        
                        <tbody>
	                          <c:if test="${empty map.list }">
	                        	    <tr>
	                        		      <td colspan="5">등록된 공지가 없습니다.</td>
	                        	    </tr>
	                          </c:if>
	                        
                            <c:forEach items="${map.list}" var="QnasVO">
                                <tr>
                                    <!-- 번호 -->
                                    <td>${QnasVO.qnas_id }</td>
                                    <!-- 제목 -->
                                    <td><a href="qnalist/${QnasVO.qnas_id}">${QnasVO.qnas_title}</a></td>
                                    <!-- 작성자 -->
                                    <td>${QnasVO.users_id}</td>
                                    <!-- 작성일 -->
                                    <td>${QnasVO.qnas_date}</td>
                                    <!-- 답변여부 -->
                                    <td>
                                      <c:if test="${empty QnasVO.qnas_reply}">
                                        <div id="no">미답변</div>
                                      </c:if>
                                      <c:if test="${!empty QnasVO.qnas_reply}">
                                        <div id="yes">답변완료</div>
                                      </c:if>
                                    </td>
                                </tr>
	                          </c:forEach>
                        </tbody>
                    </table>
					          <div id="pp">
                    	  <ul class="paging">
                            <li class="pg">
                            <c:if test="${map.prev}">
                              <a href="/admin/qnalist?page=${map.startPage-1}&searchWord=${qnasVO.searchWord}">이전</a>
                            </c:if>
                            </li>
                            <c:forEach var="p" begin="${map.startPage}" end="${map.endPage}">
                                <c:if test="${p == NoticesVO.page}">
                                <li><a href='#;' class='current'>${p}</a></li>
                                </c:if>
                                <c:if test="${p != QnasVO.page}">
                                <li><a href="/admin/qnalist?page=${p}&searchWord=${qnasVO.searchWord}">${p}</a></li>
                                </c:if>
                            </c:forEach>

                            <li class="pg">
                            <c:if test="${map.next}">
                                <a href="/admin/qnalist?page=${map.endPage+1}&searchWord=${qnasVO.searchWord}">다음</a>
                            </c:if>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body> 
</html>