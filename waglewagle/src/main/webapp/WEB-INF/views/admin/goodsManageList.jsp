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
    <link rel="stylesheet" href="/resources/css/admin/goodsManageList.css"/>
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

 		function goods_status(goods_access,goods_id){
 			/* console.log(goods_id);  */
			$.ajax({
				url:"/admin/goodsStatus",
				type:"post",
				contentType:"application/json",
				data:JSON.stringify({
					goods_access: goods_access,
					goods_id: goods_id
				}),
				success:function(data){
					$('#button0'+goods_id).toggleClass('hiddenClass');
					$('#button1'+goods_id).toggleClass('hiddenClass');
				}
			})
		} 
 		
 		console.log("${list.totalPage}","${list.endPage}","${list.startPage}");
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

                <div id="plus"> 상품검색 &nbsp;
                <form method="get" name="searchForm" id="searchForm" action="/admin/goodsManageList">
                	<input type="text" id="sGoods" name="searchWord" value="${goodsVO.searchWord}" placeholder="상품명 검색"> &nbsp;&nbsp;
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
                                <th>상품명</th>
                                <th>회원명</th>
                                <th>신고수</th>
                                <th>접근여부</th>
                            </tr>
                        </thead>
             
                        
                        <tbody>
                        
                        
                        <c:if test="${empty list }">
                        	<tr>
                        		<td>가입한 회원이 없습니다..</td>
                        	</tr>
                        </c:if>
                        
                        <c:forEach items="${list.list}" var="item">
                        	<tr>
                        		<!-- 번호 -->
                        		<td>${item.goods_id}</td>
                        		<!-- 상품명 -->
                        		<td>${item.goods_title}</td>
                        		<!-- 회원명 -->
                        		<td>${item.users_id}</td>
                        		<!-- 신고수 -->
                        		<td>${item.goodsReport_cnt}</td>
                        		<!-- 접근여부 -->
								<td>
									<button onclick="goods_status(1,${item.goods_id})" id="button0${item.goods_id}" class="${item.goods_access == true ? 'hiddenClass' : '' }">접근가능</button>
									<button onclick="goods_status(0,${item.goods_id})" id="button1${item.goods_id}" class="${item.goods_access == false ? 'hiddenClass' : '' }">접근금지</button>
								</td>     		
                        	</tr>
                        </c:forEach>
                        </tbody>
                    </table>
                      <div id="pp">
                    	<ul class="paging">
                    	<li class="pg">
                    	<c:if test="${list.prev}">
                    		<a href="/admin/goodsManageList?page=${list.startPage-1}&searchWord=${list.searchWord}">이전</a>
                    	</c:if></li>
                    		
                    	<c:forEach var="p" begin="${list.startPage}" end="${list.endPage}">
                            <c:if test="${p != list.page}">
                            <li><a href="/admin/goodsManageList?page=${p}&searchWord=${list.searchWord}">${p}</a></li>
                            </c:if>
                        </c:forEach>

						<li class="pg">
						<c:if test="${list.next}">
                    		<a href="/admin/goodsManageList?page=${list.endPage+1}&searchWord=${list.searchWord}">다음</a>
                    	</c:if></li>
                    </ul>
                   </div>
            </div>
            </div>
        </div>
    </div>
</body> 
</html>