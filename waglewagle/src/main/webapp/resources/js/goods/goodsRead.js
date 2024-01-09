$(function(){
	let url = window.location.pathname;
	let auctions_ing_id = url.substr(url.lastIndexOf("/")+1);
	$.ajax({
		url:"/chat/readBid",
		data: {auctions_ing_id : auctions_ing_id},
		success: function(data){
			if(data === 'true'){
				console.log("update read 성공");
			}else{
				console.log("update read 실패");
			}
		}
	});
});