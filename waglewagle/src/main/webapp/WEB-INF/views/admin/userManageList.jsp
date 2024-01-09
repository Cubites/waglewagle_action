<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <link rel="stylesheet" href="/resources/css/admin/usersManageList.css"/>
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
		
 		function userStatus(users_status,users_id){ //어떤 상품에 대한 상태 변환할건지...
        $.ajax({
            url:"/admin/usersStatus",
            type:"post",
            contentType:"application/json",
            data:JSON.stringify({
                /* data:값 => 이렇게 넣는것보다 아래처럼 적는게 더 좋음!! */
                users_id : users_id,
                users_status : users_status
            }),
            success:function(data){
                //jquery toggle기능 사용
                //1단계 모두 지워
                $('#button0'+users_id).removeClass('hiddenClass');
                $('#button1'+users_id).removeClass('hiddenClass');
                $('#button2'+users_id).removeClass('hiddenClass');
                //2단계 다 넣어
                $('#button0'+users_id).addClass('hiddenClass');
                $('#button1'+users_id).addClass('hiddenClass');
                $('#button2'+users_id).addClass('hiddenClass');
                //3단계 내가 보일 버튼만 toggle
                $(('#button'+users_status)+users_id).toggleClass('hiddenClass');
            }
        });
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
                <div id="notice" onclick="notice()"><a href=""></a>공지</div>
                <div id="qna" onclick="qna()">문의</div>
                <div id="showdata" onclick="stats()">통계</div>
                <div id="adminuser" onclick="user()">회원관리</div>
                <div id="admingoods" onclick="goods()">상품관리</div>
                <div id="adminmaster" onclick="admin()">관리자 계정</div>
                <div id="chagepwd" onclick="password()">비밀번호 변경</div>
            </div>
            <div id="main-box">
            
            	  <!-- 회원 검색 -->
            	  <div id="plus"> 회원검색 &nbsp;
                    <form method="get" name="searchForm" id="searchForm" action="/admin/userManageList">
                        <input type="text" id="sUsers" name="searchWord" value="${UsersVO.searchWord}" placeholder="회원 이름 검색"> &nbsp;&nbsp;
                        <input type="submit" id="searchbtn" value="검색" title="검색">
                    </form>
                </div>

                 
                <!-- 회원 리스트 -->
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
                                <th>닉네임</th>
                                <th>이름</th>
                                <th>신고수</th>
                                <th>정지여부</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty list }">
                                <tr>
                                    <td colspan="5">가입한 회원이 없습니다..</td>
                                </tr>
                            </c:if>
                        
                            <c:forEach items="${list}" var="UsersVO">
                                <tr>
                                    <!-- 번호 -->
                                    <td>${UsersVO.users_id}</td>
                                    <!-- 닉네임 -->
                                    <td>${UsersVO.users_nick}</td>
                                    <!-- 이름 -->
                                    <td>${UsersVO.users_name}</td>
                                    <!-- 신고수 -->
                                    <td>${UsersVO.cnt}</td>
                                    <!-- 정지여부 -->
                                    <td>
                                        <button onclick="userStatus(1,${UsersVO.users_id})" id="button0${UsersVO.users_id}" class="${UsersVO.users_status !=0 ? 'hiddenClass':''}">접근가능</button>
                                        <button onclick="userStatus(2,${UsersVO.users_id})" id="button1${UsersVO.users_id}" class="${UsersVO.users_status !=1 ? 'hiddenClass':''}">접근금지</button>
                                        <button onclick="userStatus(0,${UsersVO.users_id})" id="button2${UsersVO.users_id}" class="${UsersVO.users_status !=2 ? 'hiddenClass':''}">탈퇴회원</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <div id="pp">
                    	  <ul class="paging">
                            <li class="pg">
                            <c:if test="${prev}">
                              <a href="/admin/userManageList?page=${startPage-1}&searchWord=${usersVO.searchWord}">이전</a>
                            </c:if>
                            </li>
                    	
                    	      <c:forEach var="p" begin="${startPage}" end="${endPage}">
                                <c:if test="${p == cnt.page}">
                                <li><a href='#;' class='current'>${p}</a></li>
                                </c:if>
                                <c:if test="${p != page}">
                                <li><a href="/admin/userManageList?page=${p}&searchWord=${usersVO.searchWord}">${p}</a></li>
                                </c:if>
                            </c:forEach>

                            <li class="pg">
                            <c:if test="${next}">
                            <a href="/admin/userManageList?page=${endPage+1}&searchWord=${usersVO.searchWord}">다음</a>
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