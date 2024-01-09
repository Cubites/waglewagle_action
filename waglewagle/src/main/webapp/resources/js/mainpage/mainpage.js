	$(function(){
		//시구동 -> 동
		$(".productAddr").each(function(){
			var addr = $(this).text().trim();
			var dong = addr.substring(addr.lastIndexOf(' ')+1);
			$(this).text(dong);
		});
		
		
		$(".productExpArea").each(function(){
			var fullExp = $(this).find(".originExp").text().trim();
			var result = fullExp.substring(0,11);
			$(this).find(".productExp").text(result);
		});
		
	})
	
	$(function(){
		var swiper = new Swiper('.swiper.notBanner', {
			slidesPerView: 5,
			spaceBetween: 30,
			loop: true,
			loopAdditionalSlides: 1,
			navigation: {
				nextEl: '.swiper-button-next',
				prevEl: '.swiper-button-prev',
			},
		});
	});
	$(function(){
		var swiper = new Swiper('.swiper.banner', {
			slidesPerView: 1,
			// loop: false,
			loopAdditionalSlides: 1,
			autoplay:{
				delay:3000,
				disableOnInteraction: false,
			},
			navigation: {
				nextEl: '.swiper-button-next',
				prevEl: '.swiper-button-prev',
			},
		});
	});
		
	$(function(){
		$(".swiper-slide").mouseover(function(){
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
		$(".swiper-slide").mouseout(function(){
			$(this).find('.popProduct').find(".leftTime").css("display", "none");
		})
		
	})
		
		$(function(){
			$(".toDetailPage").click(function(){
				var goods_id = $(this).find('input').val();
				location.href='/goods/'+goods_id;
				
			})
		})