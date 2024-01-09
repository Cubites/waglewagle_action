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
    <link rel="stylesheet" href="/resources/css/admin/adminlist.css"/>
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
		function adminjoin(){
			location.href="/admin/join";
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
                <div id="plus"> 관리자 검색 &nbsp;
                	<input type="text" size="20" id="findAdminWord" placeholder="관리자 이름 검색">  &nbsp;&nbsp;
                	<button id="findAdminButton" >검색</button>
                </div>
                
                <!-- 관리자 추가 버튼  -->
				<div>
					<input type="button" id="writebtn" value="관리자추가" onclick="adminjoin()">
                </div>
                 
                 <!-- 회원 리스트 -->
                <div class="noticelist">	
                    <table class="nlist">
                        <colgroup>
                            <col width="120px" />
                            <col width="120px" />
                            <col width="120px" />
                            <col width="120px" />
                        </colgroup>
                        <thead>
                            <tr>
                                <th>번호</th>
                                <th>이름</th>
                                <th>관리등급</th>
                                <th>삭제하기</th>
                            </tr>
                        </thead>
                        <tbody>                        
                        	<c:if test="${ListData == null }">
	                            <tr>
	                                <td class="nonotice" colspan="4">등록된 관리자가 없습니다.</td>
	                            </tr>
                            </c:if>
                            <!-- 관리자 계정 목록 반복 -->
    						<c:forEach var="item" items="${ListData}">
	    						<tr>
	                                <td>${item.admins_id }</td>
	                                <td>${item.admins_name }</td>
	                                <td id="adminRole">
	                                	<c:if test = "${item.admins_role == 0}">
	                                		최고 관리자
	                                	</c:if>
	                                	<c:if test = "${item.admins_role == 1}">
	                                		부 관리자
	                                	</c:if>
	                                	<c:if test = "${item.admins_role == 2}">
	                                		일반 관리자
	                                	</c:if>
                                	</td>
	                                <td>
	                                	<c:if test="${item.admins_id != 1}">
	                                		<button onclick="deleteAdmin(${item.admins_id})">삭제하기</button>
	                                	</c:if>
                                	</td>
								</tr>
    						</c:forEach>
                            <!-- /관리자 계정 목록 반복 -->
                        </tbody>
                    </table>
            	</div>
            	 <!-- /회원 리스트 -->
            	 <!-- pagination -->
				<div id="pp">
					<ul>
						<c:if test="${pageNum10 != 0}">
							<li><a href="/admin/adminmanage?searchWord=${searchWord != null ? searchWord : ''}&page=${pageNum10}&scroll=0">&#60;</a></li>
						</c:if>
						
						<c:forEach var="num" begin="${pageNum10 + 1}" end="${(pageNumMax - pageNum10) < 10 ? pageNumMax : pageNum10 + 10}" step="1">
							<c:if test="${pageNum1 == num}">
								<li class="nowPage">
									<a href="/admin/adminmanage?searchWord=${searchWord != null ? searchWord : ''}&page=${num}&scroll=0">${num}</a>
								</li>
							</c:if>
							<c:if test="${pageNum1 != num}">
								<li>
									<a href="/admin/adminmanage?searchWord=${searchWord != null ? searchWord : ''}&page=${num}&scroll=0">${num}</a>
								</li>
							</c:if>
						</c:forEach>
						
						<c:if test="${(pageNumMax - pageNum10) > 10}">
							<li><a href="/admin/adminmanage?searchWord=${searchWord != null ? searchWord : ''}&page=${pageNum10 + 11}&scroll=0">&#62;</a></li>
						</c:if>
					</ul>
				</div>
				<!-- /pagination -->
            </div>
        </div>
    </div>
    <script>
    
    	// 관리자 계정 삭제
    	function deleteAdmin(admins_id){
    	    if(confirm("정말로 해당 관리자 계정을 삭제하시겠습니까?")){
    			$.ajax({
    			    url: "/admin/delete/admin_account",
    			    type: "post",
    			    contentType: "application/json",
    			    data: JSON.stringify({
    					admins_id: admins_id    				
    			    }),
    			    success: function(data){
						if(data){
						    alert("정상적으로 삭제되었습니다.");
						    location.href = "/admin/adminmanage";
						} else {
						    alert("삭제 권한이 없거나, 오류가 발생했습니다. \n 최고관리자로 로그인하셨다면 잠시후 다시 시도해주세요.")
						}
    			    }
    			});
    	    }
    	}
    	
    	// 관리자 계정 검색
    	$("#findAdminButton").click(function(){
			location.href = "/admin/adminmanage?searchWord=" + $("#findAdminWord").val();
    	});
    </script>
</body> 
</html>