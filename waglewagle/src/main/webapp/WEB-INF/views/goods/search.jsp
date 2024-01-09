<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 검색</title>
<link rel="stylesheet" href="/resources/css/common/common.css">
<link rel="stylesheet" href="/resources/css/goods/search.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>



</head>

<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<%@ include file="/WEB-INF/views/common/quickmenu.jsp"%>
	<div id="center">
		<div id="container">
			<div id="searchBar">
				<!-- 토글 -->
				<select id="category1">
					<option value="-">1차 카테고리</option>
					<option value="1">패션 / 뷰티</option>
					<option value="11">전자기기</option>
					<option value="20">반려동물</option>
					<option value="26">생활 / 가전</option>
					<option value="24">도서 / 음악</option>
					<option value="25">기타</option>
				</select> <select id="category2">
					<option value="">2차 카테고리</option>
				</select> <input type="hidden" id="category1_value"
					value="${category1_value}" />

				<!--  -->

				<div id="searchBox">
					<img id="searchIcon" alt="search"
						src="/resources/images/search.png"> <input
						id="searchWordByBar" type="text" value="${search_word }"
						placeholder="상품명 혹은 거래 제목을 입력해주세요.">
				</div>
			</div>

			<div id="result_div">
				<c:if test="${not empty page.category_id }">
					<c:if test="${page.category_id eq 2 }">
						<div class="result">'여성의류'</div>
					</c:if>
					<c:if test="${page.category_id eq 3 }">
						<div class="result">'남성의류'</div>
					</c:if>
					<c:if test="${page.category_id eq 4 }">
						<div class="result">'코트'</div>
					</c:if>
					<c:if test="${page.category_id eq 5 }">
						<div class="result">'어린이'</div>
					</c:if>
					<c:if test="${page.category_id eq 6 }">
						<div class="result">'신발'</div>
					</c:if>
					<c:if test="${page.category_id eq 7 }">
						<div class="result">'가방/지갑'</div>
					</c:if>
					<c:if test="${page.category_id eq 8 }">
						<div class="result">'시계'</div>
					</c:if>
					<c:if test="${page.category_id eq 9 }">
						<div class="result">'주얼리'</div>
					</c:if>
					<c:if test="${page.category_id eq 10 }">
						<div class="result">'미용'</div>
					</c:if>

					<c:if test="${page.category_id eq 12 }">
						<div class="result">'노트북'</div>
					</c:if>
					<c:if test="${page.category_id eq 13 }">
						<div class="result">'데스크탑'</div>
					</c:if>
					<c:if test="${page.category_id eq 14 }">
						<div class="result">'웨어러블'</div>
					</c:if>
					<c:if test="${page.category_id eq 15 }">
						<div class="result">'휴대폰'</div>
					</c:if>
					<c:if test="${page.category_id eq 16 }">
						<div class="result">'태블릿'</div>
					</c:if>
					<c:if test="${page.category_id eq 17 }">
						<div class="result">'컴퓨터 주변기기'</div>
					</c:if>
					<c:if test="${page.category_id eq 18 }">
						<div class="result">'카메라'</div>
					</c:if>
					<c:if test="${page.category_id eq 19 }">
						<div class="result">'콘솔 게임기'</div>
					</c:if>

					<c:if test="${page.category_id eq 21 }">
						<div class="result">'소모품'</div>
					</c:if>
					<c:if test="${page.category_id eq 22 }">
						<div class="result">'옷'</div>
					</c:if>
					<c:if test="${page.category_id eq 23 }">
						<div class="result">'장난감'</div>
					</c:if>
				</c:if>

				<c:if
					test="${not empty page.category_id && not empty page.search_word}">
					<div class="result">>></div>
				</c:if>

				<c:if test="${not empty  page.search_word}">
					<div class="result">'${page.search_word }'</div>
				</c:if>
				
				<c:if test="${not empty  page.search_word || not empty page.category_id}">
					<div id="result_comment">에 대한 검색 결과 입니다.</div>
				</c:if>
		
			</div>

			<div id="sort_div">
				<div id="recent">최신등록순</div>
				|
				<div id="lower">낮은가격순</div>
				|
				<div id="higher">높은가격순</div>
			</div>

			<div id="list_div">

				<!-- 장원 -->
				<c:if test="${empty page.goodsList}">
					<h2>검색 결과가 없습니다.</h2>
				</c:if>
				<c:forEach var="item" items="${page.goodsList}">
					<div class="item">
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
								<input type="hidden" value="${item.goods_id }"
									class="goodsIdVal">
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	<script type="text/javascript">
	
		// category1_value를 전역 변수로 선언
	    var category1_value = $("#category1").val();
	    var searchText = "";
	    
	    // 선택한 정렬 기준 색 바꾸기
    	const urlParams = new URL(location.href).searchParams;
	    if (urlParams.get('sorting_type') !== null) {
	    	document.getElementById(urlParams.get('sorting_type')).style.color = 'red';
	    }
		
		// 검색어까지 입력했을 때만 검색되기
		$("#searchWordByBar").keyup(function (event) {  
	        if (event.keyCode === 13) {
	        	searchText = event.target.value.toLowerCase();
	        	var category2_value = $("#category2").val();
	    	    console.log(category2_value, searchText);
	    	    if (searchText === "") {
	    	    	alert("검색어를 입력해주세요.")
	    	    } else {
		         	location.href = "/goods/search?category_id=" + category2_value + "&search_word=" + searchText;	         		
	         	}
	        }
	    }); 
		
		// 정렬하기
		$("#sort_div").click(function (event) {
			
			const urlParams = new URL(location.href).searchParams;
			var sorting_type = event.target.id;
			let ca = urlParams.get('category_id');
			if (sorting_type !== "sort_div") {
				if (ca === null) {
					location.href = "/goods/search?search_word=" + searchWord + "&sorting_type=" + sorting_type;	
				} else {
					location.href = "/goods/search?category_id=" + urlParams.get('category_id') + "&search_word=" + searchWord + "&sorting_type=" + sorting_type;				
				}
			}
		})
		
		// 초기화 시에도 실행되도록 함수 호출
	    updateCategory2Options($("#category1").val());

	    $("#category1").change(function () {
	        category1_value = $(this).val();
	        $("#category1_value").val(category1_value);

	        // category1_value에 따라서 category2의 상태(disabled 여부)를 설정
	        updateCategory2Options(category1_value);
	    });

	    function updateCategory2Options(category1_value) {
	        var category2 = $("#category2");

	        // category2의 모든 옵션을 제거
	        category2.empty();

	        // category1_value에 따라서 동적으로 옵션 추가
	        switch (category1_value) {
	            case "1":
	                category2.append('<option value="2">여성의류</option>');
	                category2.append('<option value="3">남성의류</option>');
	                category2.append('<option value="4">코트</option>');
	                category2.append('<option value="5">어린이</option>');
	                category2.append('<option value="6">신발</option>');
	                category2.append('<option value="7">가방 / 지갑</option>');
	                category2.append('<option value="8">시계</option>');
	                category2.append('<option value="9">주얼리</option>');
	                category2.append('<option value="10">미용</option>');
	                break;
	            case "11":
	                category2.append('<option value="12">노트북</option>');
	                category2.append('<option value="13">데스크탑</option>');
	                category2.append('<option value="14">웨어러블</option>');
	                category2.append('<option value="15">휴대폰</option>');
	                category2.append('<option value="16">태블릿</option>');
	                category2.append('<option value="17">컴퓨터 주변기기</option>');
	                category2.append('<option value="18">카메라</option>');
	                category2.append('<option value="19">콘솔 게임기</option>');
	                break;
	            case "20":
	                category2.append('<option value="21">소모품</option>');
	                category2.append('<option value="22">옷</option>');
	                category2.append('<option value="23">장난감</option>');
	                break;
	            default:
	                category2.append('<option value="">2차 카테고리</option>');
	                break;
	        }

	        // category2의 상태(disabled 여부)를 설정
	        if (category1_value === "-" || category1_value === "24" || category1_value === "25" || category1_value === "26") {
	            category2.prop("disabled", true);
	        } else {
	            category2.prop("disabled", false);
	        }
	    }
	    
	    // 남은 시간 뜨고 각 상품 페이지로 이동하기
	    $(function(){
			$(".productExpArea").each(function(){
				var fullExp = $(this).find(".originExp").text().trim();
				var result = fullExp.substring(0,11);
				$(this).find(".productExp").text(result);
			});
    	   $(".item").mouseover(function(){
    	      let now = new Date();
    	      //console.log(now);
    	      let expDateValue = $(this).find(".popProduct").find(".avgPrice_expDateArea").find(".avg_expValue").find(".productExpArea").find(".originExp").text();
  			  let expDate = new Date(Date.parse(expDateValue));
  			  //console.log(expDate);
  			  let leftTime = expDate - now;
    	      
    	      const days = Math.floor(leftTime/(1000*60*60*24));
    	        const hours = ("0"+Math.floor(leftTime %(1000*60*60*24)/(1000*60*60))).slice(-2);

    	      
    	      $(".leftTimeVal").text(days+"일 "+hours+"시간");
    	      $(this).find('.popProduct').find(".leftTime").css("display", "flex");
    	      
    	   })
    	   $(".item").mouseout(function(){
    	      $(this).find('.popProduct').find(".leftTime").css("display", "none");
    	   })
    	   
    	})
    	   
    	$(function(){
    	   $(".toDetailPage").click(function(){
    	      var goods_id = $(this).find('input').val();
    	      location.href='/goods/'+goods_id;
    	      
    	   })
    	})
	
	</script>
	<script type="text/javascript">

		let page="${page.page}";
		let totalPage = "${page.totalPage}";
		let category_id = "${page.category_id}";
		let searchWord = "${page.search_word}";

		 $(function(){
			
			 $(".productExpArea").each(function(){
				
		         var fullExp = $(this).find(".originExp").text().trim();
		         //var result = fullExp.substring(0,5);
		         var result = fullExp.split("T");
		         
		         $(this).find(".productExp").text(result[0]);
		   
		      });
	 
	 let scrollPoint;
	 window.addEventListener("scroll",(event) => {
		 
		 	let scroll = $(window).scrollTop();
		 	let documentHeight = $(document).height();
		 	let windowHeight = $(window).height();
			
			
		 	let checkNum = scroll-(documentHeight-windowHeight);
		 	if(checkNum <1 && checkNum > -1 && page < totalPage){
		 		scrollPoint = documentHeight-windowHeight;
		 		addPage(scrollPoint);
		 	}
		 	
		 	//로드한다음 위에 스크롤 위치로 보내면 될듯?
				
	 });
 })
 //장원 스크롤이 끝에 닿으면 다음 데이터 얻어오기
 function addPage(point){
	 
	 let search22 = searchWord2();
	 searchWord = search22 === null ? searchWord:search22;
	 
	 let categorySelected = selectedCategory();
	 category_id = categorySelected === null ? category_id:categorySelected;
	
	 page = Number(page)+1;
	 
	 const urlParams = new URL(location.href).searchParams;
	 let ca = urlParams.get('sorting_type');
	
	 
	 $.ajax({
		 
		 url:"/goods/searchScroll",
		 type:"post",
		 dataType:"json",
		 data:{
			 "pageNum":page+"", 
			 "search_word":searchWord, 
			 "category_id":category_id,
			 "sorting_type":ca},
		contentType:"application/x-www-form-urlencoded;charset=utf-8;",
		 success: function(data){
			 
			 //데이터 출력 후 
			 showGoods(data);
			 //스크롤 위치
		 },
		 error:function(xhr){
			 console.log(xhr);
		 }
		 
	 });
	 
 }
 // 장원 카테고리 선택 결과 반영
 function selectedCategory(){
	 let ca1 = $("#category1 option:selected").val();
	 let ca2 = $("#category2 option:selected").val();
	 let resultVal ="";
	 
	
	 if(ca2 === ""){
		 resultVal = ca1;
	 }else{
		 resultVal = ca2;
	 }
	 
	 if(resultVal === null || resultVal === "" || resultVal ==="-"){
		 return null;
	 }
	 
	 return resultVal;
 }

 function searchWord2(){
	 let search2 = $("#searchWordByBar").val();
	 if(search2 === null || search2 === ""){
		 return null;
	 }
	 return  search2;
	 
 } 
 //장원 동적 list추가
 function showGoods(data){
	 
	 let goodsList = data.goodsList;
	  let html = ""
	  let list_div = document.querySelector("#list_div");
	  goodsList.forEach(element => {

	    html = "<div class='popProduct'>" +
	      "<div class='productImg'>" +
	      "<img src='/upload/" + element.goods_th_img + "'>" +
	      "</div>" +
	      "<div class='productTitle'>" + element.goods_title + "</div>" +
	      "<div class='avgPrice_expDateArea'>" +
	      "<div class='avg_expTitle'>" +
	      "<div class='avgPriceTitle'>평균 입찰가</div>" +
	      "<div class='expTitle'>입찰 마감일</div>" +
	      "</div>" +
	      "<div class='avg_expValue'>"+
	      "<div class='productAvgPrice'>"+element.goods_avg_price+"원</div>"+
	      "<div class='productExpArea'>"+
	      "<div class='productExp'>"+dateToString(element.goods_exp)+"</div>"+
	      "<div class='originExp hide'>"+dateToString(element.goods_exp)+"</div>"+
	      "</div>"+
	      "</div>"+
	      "</div>" +
	      "<div class='leftTime toDetailPage'>" +
	      "<div class='leftTimeVal'></div>" +
	      "<input type='hidden' value='" + element.good_id + "' class='goodsIdVal'>" +
	      "</div>" +
	      "</div>";

	    	let div = document.createElement("div");
	   			 div.className = "item";
	   			 div.innerHTML = html;
	   			 list_div.append(div);
	  });
	 	//마우스 올리면 경매 남은 시간 나오는 이벤트 다시 걸기
	    addMouseEvent();
	   
	 
 }
 
 function addMouseEvent(){
	 //이벤트 중복 방지를 위해 기존 이벤트 삭제
	 $(".item").off("mouseover");
	 $(".item").off("mouseout");
	 
	 //마우스 올리면 시간 나오는 이벤트 다시 걸기
	 $(".item").mouseover(function(){
         let now = new Date();
         //console.log(now);
         let expDateValue = $(this).find(".popProduct").find(".avgPrice_expDateArea").find(".avg_expValue").find(".productExpArea").find(".originExp").text();
         let expDate = new Date(Date.parse(expDateValue));
         //console.log(expDate);
         let leftTime = expDate - now;
         
         const days = Math.floor(leftTime/(1000*60*60*24));
           const hours = ("0"+Math.floor(leftTime %(1000*60*60*24)/(1000*60*60))).slice(-2);

         
         $(".leftTimeVal").text(days+"일 "+hours+"시간");
         $(this).find('.popProduct').find(".leftTime").css("display", "flex");
         
      })
      $(".item").mouseout(function(){
         $(this).find('.popProduct').find(".leftTime").css("display", "none");
      })
	 
 }
 
 function dateToString(dateTime) {
	 	
	 
	  //return text;
	   // return dateTime[0] + "-" + dateTime[1] > 10 ?  dateTime[1]: "0" +dateTime[1] + "-" + dateTime[2];
	   return dateTime[0] +"-"+dateTime[1]+"-"+dateTime[2];
	  }
 	
 



</script>
</body>
</html>