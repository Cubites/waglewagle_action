<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="forms" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="Spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/resources/js/goods/regist.js"></script>
<script src="/resources/js/goods/registSubmit.js"></script>
<link rel="stylesheet" href="/resources/css/common/common.css">
<link rel="stylesheet" href="/resources/css/goods/regist.css" />
<title>Document</title>

</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div id="center">
		<div id="container">

			<div id="inputBoxContainer">
				<forms:form id="registForm" modelAttribute="goodsFormVO"
					method="post" enctype="multipart/form-data" action="/goods/regist">
					<div class="inputBox">
						<span class="inputlabel"><span class="pointer">*</span>상품
							이미지</span> <input id="inputFile" type="file" multiple accept="image/*">
						<input type="file" id="himage" name="images"
							style="display: none;"> <input type="hidden"
							id="goods_th_img" name="goods_th_img" /> <span
							id="fileLengthText">(0/5)</span>
						<div id="imageBox">
							<img id="selectImageBox" class="selectedImageBox"
								src="/resources/images/goods/imagebox.PNG" alt="">
						</div>
						<!-- 필드 에러 외 글로벌 오류 출력 -->
						<c:if test="${error != null && error.hasGlobalErrors()}">
							<c:forEach var="er" items="${error.getGlobalErrors()}">
								<span class="errorMessage">${er.getDefaultMessage()}</span>
							</c:forEach>
						</c:if>
					</div>

					<div class="inputBox">
						<span class="inputlabel"><span class="pointer">*</span>제목</span>
						<!--  <input id="goodsTitle" type="text" size="100">-->

						<forms:input path="goods_title" size="100" cssClass="goodsInput" />
						<forms:errors path="goods_title" cssClass="errorMessage" />
					</div>

					<div class="inputBox">
						<span class="inputlabel"><span class="pointer">*</span>설명</span>
						<textarea name="goods_comment" id="textBox"
							placeholder="&#13;&#10; -상품명 ( 브랜드 )&#13;&#10; -구매시기&#13;&#10; -사용기간&#13;&#10; -물건 상태&#13;&#10; *실제 촬용한 사진과 함께 상세 정보를 입력해주세요"></textarea>
					</div>
					<div class="inputBox">
						<span class="inputlabel"><span class="pointer">*</span>카테고리</span>
						<div id="selectCategory">
							<forms:select path="goods_category1" id="goodsCategory1"
								onchange="getLowerCategories();">
								<forms:option value="">1차 카테고리</forms:option>
								<forms:option value="1">패션/뷰티</forms:option>
								<forms:option value="11">전자기기</forms:option>
								<forms:option value="20">반려동물</forms:option>
								<forms:option value="24">도서/음악</forms:option>
								<forms:option value="26">생활가전</forms:option>
								<forms:option value="25">기타</forms:option>
							</forms:select>
							<forms:select path="goods_category2" id="goodsCategory2">
								<forms:option value="">2차 카테고리</forms:option>
								<div id="category2Ajax"></div>
							</forms:select>

						</div>
						<forms:errors path="goods_category1" cssClass="errorMessage" />
					</div>


					<div class="inputBox">
						<span class="inputlabel"><span class="pointer">*</span>시작가격</span>
						<!-- <input id="price" type="text" > -->
						<forms:input path="goods_start_price" id="price"
							cssClass="goodsInput" />
						<forms:errors path="goods_start_price" cssClass="errorMessage" />
					</div>


					<div class="inputBox">
						<span class="inputlabel"><span class="pointer">*</span>
							거래장소 <img id="clipImage" src="/resources/images/goods/clip.PNG">
						</span>
						<div id="addrBox">
							<forms:input path="goods_dong" id="addrDong" readonly="true"
								cssClass="goodsInput" />
							<forms:input path="goods_addr" id="fullJibun"
								cssStyle="display:none;" />
							<input id="addrSearchButton" type="button" value="주소조회"
								style="background-color: #777777;">
						</div>
						<forms:errors path="goods_addr" cssClass="errorMessage" />
					</div>


					<div class="inputBox">
						<span class="inputlabel"><span class="pointer">*</span>거래마감일</span>
						<input id="goodsDate" type="date" name="goods_exp"
							class="goodsInput"> <input type="hidden" name="goods_exp"
							id="goods_exph">
						<forms:errors path="goods_exp" cssClass="errorMessage" />
					</div>


				</forms:form>
			</div>
			<div id="submitbutton">
				<div id="submits" onclick="submits2()">
					<img src="/resources/images/goods/checkbutton.PNG" id="checkimg">
					<h3>경매시작</h3>
				</div>

			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>