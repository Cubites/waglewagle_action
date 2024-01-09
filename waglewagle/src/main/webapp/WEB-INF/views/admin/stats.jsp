<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head> 
    <meta charset="utf-8">
    <title></title>
    <META name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
    <script src="https://d3js.org/d3.v7.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
    <link rel="stylesheet" href="/resources/css/admin/qnalist.css"/>
	<link rel="stylesheet" href="/resources/css/admin/stats.css"/>
	<script>
	
		const search = () => {
			const keyword = document.querySelector('#keyword');
			document.location.href='/admin/qnalist?page=1&keyword=' + keyword.value;
		}
		
		const press = () => {
			if(event.keyCode == 13) search();
		}
		
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
            <img src="/resources/images/log.jpg" title="와글와글 로고"/ onclick="notice()">
        </div>
    </div>

    <div id="center">
        <div id="container">
            <div id="side-box">
                <div id="notice" onclick="notice()">공지</div>
                <div id="qna" onclick="qna()">문의</div>
                <div id="showdata" onclick="stats()">통계</div>
                <div id="adminuser" onclick="user()">회원관리</div>
                <div id="admingoods" onclick="goods()">상품관리</div>
                <div id="adminmaster" onclick="admin()">관리자 계정</div>
                <div id="chagepwd" onclick="password()">비밀번호 변경</div>
            </div>
            <div id="main-box">
				<div id="statsTop">
					<div class="chartMenuButton" id="statsTotalButton" style="background-color: #fff">전체</div>
					<div class="chartMenuButton" id="statsCategoryButton">카테고리</div>
					<div class="chartMenuButton" id="statsTimeButton">시간대</div>
					<div class="chartMenuButton" id="statsGenderButton">성별</div>
				</div>
				<div id="statsBottom">
					<div class="chartBox" id="categoryBox">
						<div class="title">카테고리</div>
						<div class="chartArea chart1"></div>
						<div class="chartArea chart2"></div>
						<div class="chartArea chart3"></div>
						<div class="chartArea chart4"></div>
						<div class="chartArea chart5"></div>
					</div>
                    <div class="chartBox" id="dateBox">
						<div class="title">시간대</div>
						<div class="chartArea chart11"></div>
					</div>
					<div class="chartBox" id="genderBox">
						<div class="title">성별</div>
						<div class="chartArea chart21"></div>
					</div>
				</div>
            </div>
        </div>
    </div>
    <script type="module">
		import barChart from "/resources/js/admins/chart/AnimationBarChart.js";
		import circleChart from "/resources/js/admins/chart/AnimationCircleChart.js";
		import stackedBarChart from "/resources/js/admins/chart/AnimationStackedBarChart.js";
		import horizonalStackedBarChart from "/resources/js/admins/chart/AnimationHorizonalStackedBarChart.js";
		
		let ChartData = {
			"chart1": ${goods_category},
			"chart2": ${goods_fail_category},
			"chart3": ${goods_category_all},

			"chart4": ${bids_category},
			"chart5": ${bids_category_all},

			"chart11": ${users_month_latestyear},

			"chart21": ${users_gender}
        }

		circleChart("chart1", ChartData.chart1, {
        	Title: "상위 카테고리별 게시글 수"
        });
		circleChart("chart2", ChartData.chart2, {
        	Title: "상위 카테고리별 유찰 수"
        });
        horizonalStackedBarChart("chart3", ChartData.chart3, {
        	Title: "하위 카테고리별 게시글 수",
			Legend: ["경매글 수"]
        });
        circleChart("chart4", ChartData.chart4, {
        	Title: "상위 카테고리별 경매 참여 수"
        });
        horizonalStackedBarChart("chart5", ChartData.chart5, {
        	Title: "하위 카테고리별 경매 참여 수",
		    Legend: ["호가 횟수"]
        });

		horizonalStackedBarChart("chart11", ChartData.chart11, {
			Title: "최근 1년간 월별 가입자 수",
			Legend: ["가입자 수"],
			RateDataLabelOnOff: false
		});

		circleChart("chart21", ChartData.chart21, {
			Title: "성별 가입자 수"
		});
		
		Array.from(document.getElementsByClassName("chartMenuButton")).forEach((item, index) => {
			item.addEventListener("click", (e) => {
				Array.from(document.getElementsByClassName("chartMenuButton")).forEach((item, index) => {
					item.style.backgroundColor = "#ddd";
				});
				e.target.style.backgroundColor = "#fff";
				if(index == 0){
					Array.from(document.getElementsByClassName("chartBox")).forEach((item, index) => { 
						item.style.display = "flex"
					});
				} else {	
					let menuIndex = index;
					Array.from(document.getElementsByClassName("chartBox")).forEach((item, index) => {
						if(menuIndex-1 != index) { 
							item.style.display = "none";
						} else {
							item.style.display = "flex";
						}
					});
				}
			});
		});
	</script>
</body>
</html>