package kr.co.waglewagle.goods.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;
import kr.co.waglewagle.domain.UsersVO;
import kr.co.waglewagle.goods.service.GoodsService;
import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class GoodsAPIController {
	@Autowired
	private GoodsService service;

	@PostMapping(path = "/goods/favor")
	public void goodsFavor(@SessionAttribute(name = "users_info", required = false) UsersVO loginUser, Integer goodsId,
			boolean status) {

		
		service.addGoodsFavor(loginUser.getUsers_id(), goodsId, status);

	}

}
