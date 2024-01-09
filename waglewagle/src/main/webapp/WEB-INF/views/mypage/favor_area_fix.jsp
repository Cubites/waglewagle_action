<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="/resources/css/mypage/favor_area_fix.css">
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		// 관심지역 제거
		function deleteArea(e) {
			e.target.parentNode.parentNode.removeChild(e.target.parentNode);
			if(!document.getElementById("addArea")){
				let temp = document.createElement("div");
				temp.setAttribute("id", "addArea");
				temp.setAttribute("onclick", "addArea()");
				temp.innerHTML = "+";
				document.getElementById("flbItems").appendChild(temp);
			}
		}
		// 관심지역 추가
		function addArea() {
			if(document.getElementsByClassName("favorArea").length >= 3){ // 현재 관심지역이 3개 이상인 경우
				alert("관심지역은 3개까지만 등록할 수 있습니다.")
			} else {
				new daum.Postcode({
					oncomplete: function(data) {
						let dongVal = "";
						let fullAddr = "";
						if(data.bname1){
							dongVal = data.bname1;
						} else {
							dongVal = data.bname;
						}
						let dong = data.jibunAddress.lastIndexOf("동 ");
						let eup = data.jibunAddress.lastIndexOf("읍 ");
						if(dong != -1){
							fullAddr = data.jibunAddress.substr(0, dong + 1);
						} else if(eup != -1){
							fullAddr = data.jibunAddress.substr(0, eup + 1);
						}
	
						document.getElementById("addArea").remove();
	
						let temp = document.createElement("div");
						temp.setAttribute("class", "favorArea");
						temp.setAttribute("onclick", "deleteArea(event)");
						temp.innerHTML = `
							<div>${'${dongVal}'}</div>
							<img src="/resources/images/close_icon.png">
							<input type="hidden" value="${'${fullAddr}'}">
						`;
						document.getElementById("flbItems").appendChild(temp);
						
						if(document.getElementsByClassName("favorArea").length < 3){
							let temp2 = document.createElement("div");
							temp2.setAttribute("id", "addArea");
							temp2.setAttribute("onclick", "addArea()");
							temp2.innerHTML = "+";
							document.getElementById("flbItems").appendChild(temp2);
						}
					}
				}).open();
			}
		}
		// 관심지역 저장
		function saveAreas() {
			let areas = [];
			let areasStr = "";
			let temp = document.getElementsByClassName("favorArea")
			for(let i=0; i < temp.length; i++){
				areas.push(temp[i].querySelector("input").value);
				areasStr += areas[i] + ",";
			};
			
			areasStr = areasStr.slice(0, areasStr.lastIndexOf(","));
			
			$.ajax({
		        url: "/update/favor_areas",
		        type: 'post',
				contentType: 'application/json',
		        data: JSON.stringify({
					addr: areasStr
				}),
		        success: function(data) {
					if(data){
						alert("관심지역이 저장되었습니다.");
					} else {
						alert("관심지역 저장이 되지 않았습니다. 잠시 후에 다시 시도해주세요.");
					}
				}
			});
		}
	</script>
</head>
<body>
	<div id="favorFixContainer">
		<div id="favorListBox">
			<div id="flbTitle">현재 관심지역</div>
			<div id="flbItems">
				<!-- 관심지역 반복 -->
				<!-- 저장된 관심지역이 최대 갯수(3개)인 경우 -->
				<c:if test="${favor_areas_count >= 3}">
					<c:forEach var="item" items="${favor_areas}">
						<c:set var="addrStrs" value="${fn:split(item, ' ')}"/>
						<div class="favorArea">
							<div>${addrStrs[fn:length(addrStrs)-1]}</div>
							<img src="/resources/images/close_icon.png" onclick="deleteArea(event)">
							<input type="hidden" value="${item}">
						</div>
					</c:forEach>
				</c:if>
				<!-- /저장된 관심지역이 최대 갯수(3개)인 경우 -->
				<!-- 저장된 관심지역이 최대 갯수(3개)가 아닌 경우 -->
				<c:if test="${favor_areas_count < 3}">
					<c:if test="${favor_areas_count > 0}">
						<c:forEach var="item" items="${favor_areas}">
							<c:set var="addrStrs" value="${fn:split(item, ' ')}"/>
							<div class="favorArea">
								<div>${addrStrs[fn:length(addrStrs)-1]}</div>
								<img src="/resources/images/close_icon.png" onclick="deleteArea(event)">
								<input type="hidden" value="${item}">
							</div>
						</c:forEach>
					</c:if>
					<div id="addArea" onclick="addArea()">
						+
					</div>
				</c:if>
				<!-- /저장된 관심지역이 최대 갯수(3개)가 아닌 경우 -->
				<!-- /관심 지역 반복 -->
			</div>
		</div>
		
		<div id="saveButton" onclick="saveAreas()">관심지역 저장</div>
		
	</div>
</body>
</html>