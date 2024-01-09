package kr.co.waglewagle.error;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

//import kr.co.waglewagle.admins.service.ReplyService;
import kr.co.waglewagle.domain.NoticesVO;

@Controller
public class errorController {
//	@Autowired
//	private NoticeService service;
	
	@GetMapping("/error/notFound404")
	public String index(Model model,NoticesVO vo) {
		//서비스 호출하고 map return 받을거니까...
//		model.addAttribute("map",service.list(vo));
		return "/error/notFound404";
	}
	
	
	
}