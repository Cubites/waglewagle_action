<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>와글와글</title>
	<link rel="stylesheet" href="/resources/css/common/common.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
	<link rel="stylesheet" href="/resources/css/mainpage/mainpage.css">
	<script src="https://code.jquery.com/jquery-latest.min.js"></script>
	<script src="/resources/js/mainpage/mainpage.js"></script>
	
	<!-- Swiper JS -->
  	<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<%@ include file="/WEB-INF/views/common/quickmenu.jsp" %>
	<div id="center">
		<div id="container">
			<!-- 배너 -->
			<div id="bannerArea">
				<div id="banner">
					<!-- swiper -->
          <div class="swiper banner mySwiper">
            <div class="swiper-wrapper">
              <div class="swiper-slide">
                <img src="/resources/images/banner_01.png" >
              </div>
              <div class="swiper-slide">
                <img src="/resources/images/banner_02.png" >
              </div>
              <div class="swiper-slide">
                <img src="/resources/images/banner_03.png" >
              </div>
              <div class="swiper-slide">
                <img src="/resources/images/banner_04.png" >
              </div>
              <div class="swiper-slide">
                <img src="/resources/images/banner_05.png" >
              </div>					
            </div>
            <div class="swiper-button-next"></div>
            <div class="swiper-button-prev"></div>
          </div>
				</div>
			</div>
			
			<!-- 실시간 인기 상품 -->
			<div id="popularProductsArea">
				<div id="popularTitle">
					실시간 인기 상품
				</div>
				<!-- swiper -->
				<div class="swiper mySwiper notBanner">
					<div class="swiper-wrapper hoverEl relative popular">
						<c:if test="${empty popular_list }">
							<div class="noItems">
								<div class="noItemValue">조건에 맞는 상품이 없습니다.</div>
							</div>
						</c:if>
						<c:forEach var="item" items="${popular_list }">
							  <div class="swiper-slide popSlideEl">
                    <div class="popProduct">
                        <div class="productImg">
                          <img src="/upload/${item.goods_th_img }">
                        </div>
                        <div class="productTitle">${item.goods_title }</div>
                        <div class="avgPrice_expDateArea">
                          <div class="avg_expTitle">
                            <div class="avgPriceTitle">평균 입찰가</div>
                            <div class="expTitle">입찰 마감일</div>
                          </div>
                          <div class="avg_expValue">
                            <div class="productAvgPrice">${item.goods_avg_price }원</div>
                            <div class="productExpArea">
                              <div class="productExp"></div> 
                              <div class="originExp hide">${item.goods_exp }</div>
                            </div>
                          </div>
                        </div>
                        <div class="productAddrArea">
                          <div id="locImg"><img src="/resources/images/loc.png"></div>
                          <div class="productAddr">
                            ${item.goods_address }
                          </div>
                        </div>
                        <div class="leftTime toDetailPage">
                            <div class="leftTimeVal"></div>
                            <input type="hidden" value="${item.goods_id }" class="goodsIdVal">
                        </div>
                      </div>      
							    </div>
              </c:forEach> 
					</div>
					<div class="swiper-button-next"></div>
					<div class="swiper-button-prev"></div>
				</div>
			</div>
			
			<!-- 신규 등록 물품 -->
			<div id="newRegProductsArea">
				<div id="newRegProductsTitle">
					신규 등록 물품
				</div>
				<!-- swiper -->
				<div class="swiper mySwiper notBanner">
					<div class="swiper-wrapper hoverEl">
						<c:if test="${empty new_list }">
							<div class="noItems">
								<div class="noItemValue">조건에 맞는 상품이 없습니다.</div>
							</div>
						</c:if>
						<c:forEach var="item" items="${new_list }">
							<div class="swiper-slide smallEl">
			                     <div class="popProduct">
			                        <div class="productImg">
			                           <img src="/upload/${item.goods_th_img }">
			                        </div>
			                        <div class="productTitle">${item.goods_title }</div>
		                        	<div class="avgPrice_expDateArea">
			                        	<div class="avg_expTitle">
			                        		<div class="avgPriceTitle">평균 입찰가</div>
				                        	<div class="expTitle">입찰 마감일</div>
				                        </div>
				                        <div class="avg_expValue">
				                        	<div class="productAvgPrice">${item.goods_avg_price }원</div>
					                        <div class="productExpArea">
					                        	<div class="productExp"></div> 
						                        <div class="originExp hide">${item.goods_exp }</div>
					                        </div>
				                        </div>
			                        </div>
				                    <div class="leftTime toDetailPage">
			                        	<div class="leftTimeVal"></div>
			                        	<input type="hidden" value="${item.goods_id }" class="goodsIdVal">
				                   	</div>
			                     </div>      
							</div>
		                 </c:forEach> 
					</div>
					<div class="swiper-button-next"></div>
					<div class="swiper-button-prev"></div>
				</div>
			</div>

			<!-- 내 주변 상품 -->
			<div id="nearProductsArea">
				<div id="nearProdHeader">
					<div id="nearProductsTitle">
						관심 지역 상품
					</div>
					<div id="location">
						<c:if test="${dong_list != null}">
							
							<div id="locNameArea">
								<c:forEach var="dong" items="${dong_list }">
									<div id="locImg"><img src="/resources/images/loc.png"></div>
									<div class="locName">
										${dong }
										 
									</div>
								</c:forEach>	
							</div>
						</c:if>
					</div>
				</div>
				<!-- swiper -->
				<div class="swiper mySwiper notBanner">
					<div class="swiper-wrapper hoverEl">
						<c:if test="${empty near_list }">
							<div class="noItems">
								<div class="noItemValue">조건에 맞는 상품이 없습니다.</div>
							</div>
						</c:if>
						<c:forEach var="item" items="${near_list }">
							<div class="swiper-slide dongSlideEl">
	                     		<div class="popProduct">
                        			<div class="productImg">
			                           <img src="/upload/${item.goods_th_img }">
			                        </div>
			                        <div class="productTitle">${item.goods_title }</div>
		                        	<div class="avgPrice_expDateArea">
			                        	<div class="avg_expTitle">
			                        		<div class="avgPriceTitle">평균 입찰가</div>
				                        	<div class="expTitle">입찰 마감일</div>
				                        </div>
				                        <div class="avg_expValue">
				                        	<div class="productAvgPrice">${item.goods_avg_price }원</div>
					                        <div class="productExpArea">
					                        	<div class="productExp"></div> 
						                        <div class="originExp hide">${item.goods_exp }</div>
				                        	</div>
				                        </div>
			                        </div>
			                        <div class="leftTime toDetailPage">
			                        	<div class="leftTimeVal"></div>
			                        	<input type="hidden" value="${item.goods_id }" class="goodsIdVal">
			                   	 	</div>
	                     		</div>      
							</div>
                 		</c:forEach> 
					</div>
					<div class="swiper-button-next"></div>
					<div class="swiper-button-prev"></div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>