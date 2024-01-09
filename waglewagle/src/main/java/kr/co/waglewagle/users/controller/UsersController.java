package kr.co.waglewagle.users.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.waglewagle.auctions.service.AuctionsService;
import kr.co.waglewagle.domain.UsersVO;
import kr.co.waglewagle.goods.won.FileStore;
import kr.co.waglewagle.goods.won.UploadImage;
import kr.co.waglewagle.users.service.UsersService;
import kr.co.waglewagle.users.ty.mailauth.MailService;


@Controller
public class UsersController {
	
	@Autowired
	private UsersService service;
	@Autowired
	private MailService ms;
	
	@Autowired
	private AuctionsService auctionsService;
	
	@Autowired
	private FileStore fs;
	
	// 회원가입 페이지 이동
	@GetMapping("/users/join")
	public String joinForm(HttpServletResponse res) {
		res.setHeader("Pragma", "no-cache"); // HTTP 1.0.
		res.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT");
		res.setHeader("Cache-Control", "no-store, no-cache, must-revalidate"); // HTTP 1.1.
		return "users/join";
	}
	
	// 회원가입
	@PostMapping("/users/join")
	public String joinProcess(HttpServletResponse res, Model model, UsersVO vo){
		
		res.setHeader("Pragma", "no-cache"); // HTTP 1.0.
		res.setHeader("Expires", "Tue, 6 July 1999 12:00:00 GMT");
		res.setHeader("Cache-Control", "no-store, no-cache, must-revalidate"); // HTTP 1.1.
		
		UsersVO usersVO = vo;
		
		String cmd = ""; //move or back
		String msg = "";
		String url = "";
		boolean joinResult = service.join(usersVO);
		if(joinResult) {
			int users_id = service.selectUsersId(vo.getUsers_email());
			boolean creatPointResult = service.createPoint(users_id);
			if(creatPointResult) { // 회원가입 성공
				cmd = "move";
				msg = "회원가입 되었습니다.";
				url = "/users/login";
			} else { // 회원가입 실패 - 포인트 계좌 생성 실패
				cmd = "move";
				msg = "포인트 계좌 생성에 실패했습니다. 관리자에게 문의하세요.";
				url = "/users/main";
			}
		} else { // 회원가입 실패
			cmd = "back";
			msg = "회원가입에 실패했습니다.";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("cmd", cmd);
		model.addAttribute("url", url);
		
		return "common/inform";
	}
	
	// 로그인 페이지로 이동
	@GetMapping("/users/login")
	public String loginForm() {
		return "users/login";
	}
	
	// 로그인
	@PostMapping("/users/login")
	public String login(HttpSession session, Model model, UsersVO vo){
		
		// db에 있는 정보
		UsersVO login = service.login(vo);
		boolean isValid = false;
		String cmd = ""; //move or back
		String msg = "";
		String url = "";
		
		if(login == null) { // 로그인 실패 - 회원 정보가 존재하지 않음
			msg = "아이디와 비밀번호를 확인해주세요.";
			cmd = "back";
		}else if(login.getUsers_status() == 0) { // 정상 회원일 때 -> 로그인
			isValid = BCrypt.checkpw(vo.getUsers_pwd(), login.getUsers_pwd()); 
			if(isValid) { // 로그인 성공!
				session.setAttribute("users_info", login);
				cmd = "move";
				url = "/";
			} else { // 로그인 실패 - 비밀번호 틀림!
				msg = "아이디와 비밀번호를 확인해주세요.";
				cmd = "back";
			}
		} else if (login.getUsers_status() == 1){ // 로그인 실패 - 정지된 회원
			msg = "정지계정입니다. 관리자에게 문의해주세요.";
			cmd = "move";
			url = "/";
		} else { // 로그인 실패 - 탈퇴한 회원
			msg = "아이디와 비밀번호를 확인해주세요.";
			cmd = "back";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("cmd", cmd);
		model.addAttribute("url", url);
		
		return "common/inform";
	}

	// 이메일 중복 체크
	@ResponseBody
	@GetMapping("/users/emaildup")
	public String emailDupCheck(String users_email) {
		return String.valueOf(service.isEmailDup(users_email));
	}
	
	// 이메일 인증 번호 발송
	@ResponseBody
	@PostMapping("/users/send_authnum")
	public String sendAuthNum(HttpSession session, String users_email) {
		try {
			String authNum = ms.sendSimpleMessage(users_email);
			session.setAttribute("authNum", authNum);
			return authNum;
		} catch(Exception e) {
			e.printStackTrace();
			return "FAILED";
		}
	}
	
	// 이메일 인증 번호 검증
	@ResponseBody
	@PostMapping("/users/check_authnum")
	public String checkAuthNum(HttpSession session, String validNum){
		String authNum = (String)session.getAttribute("authNum");
		session.setAttribute("authNum", ""); //authNum 초기화
		return validNum.equals(authNum) ? "true" : "false";
	}
	
	// 닉네임 중복 체크
	@ResponseBody
	@GetMapping("/users/nickcheck")
	public String nickCheck(String users_nick) {
		return String.valueOf(service.isNickDup(users_nick));
	}
	
	// 아이디/비밀번호 찾기 페이지로 이동
	@GetMapping("/users/find_info")
	public String findInfo() {
		return "users/findInfo";
	}
	
	// 아이디 찾기
	@PostMapping("/users/find_id")
	public String findId(Model model, String users_name, String users_phone ) {
		Map<String, String> user_info = new HashMap<>();
		user_info.put("users_name", users_name);
		user_info.put("users_phone", users_phone);
		
		UsersVO vo = service.findId(user_info);
		if(vo == null) { // 아이디 찾기 실패 - 존재하지 않는 이메일
			model.addAttribute("users_email", "NOT_EXIST");
		}else {
			if(vo.getUsers_status() == 1) { // 아이디 찾기 실패 - 정지 계정
				model.addAttribute("msg", "정지 계정입니다.");
				model.addAttribute("cmd", "move");
				model.addAttribute("url", "/");
				
				return "common/inform";
			} else if(vo.getUsers_status() == 2) { // 아이디 찾기 실패 - 탈퇴 회원
				model.addAttribute("users_email", "NOT_EXIST");
			} else { // 아이디 찾기 성공
				String users_email = vo.getUsers_email();
				int atIdx = users_email.indexOf("@");
				String maskedEmail = users_email.substring(0,3) + "*****" + users_email.substring(atIdx);
				model.addAttribute("users_email", maskedEmail);
			}
		}
		model.addAttribute("result_type", "find_id");
		
		return "users/findResult";
	}
	
	// 비밀번호 찾기
	@PostMapping("/users/find_pwd")
	public String findPwd(Model model, String users_name, String users_email, RedirectAttributes rs) {
		Map<String, String> user_info = new HashMap<>();
		user_info.put("users_name", users_name);
		user_info.put("users_email", users_email);
		
		UsersVO vo = service.findPwd(user_info);
		if(vo == null) { // 비밀번호 찾기 실패 - 존재하지 않는 유저
			model.addAttribute("result_type", "find_pwd");
			return "users/findResult";
		}else {
			if(vo.getUsers_status() == 1) { // 비밀번호 찾기 실패 - 정지 계정
				model.addAttribute("msg", "정지 계정입니다.");
				model.addAttribute("cmd", "move");
				model.addAttribute("url", "/");
				
				return "common/inform";
			} else if(vo.getUsers_status() == 2) { // 비밀번호 찾기 실패 - 탈퇴 회원
				model.addAttribute("result_type", "find_pwd");
				return "users/findResult";
			}
			rs.addFlashAttribute("vo", vo);
			return "redirect:change_pwd";
		}
	}

	// 아이디/비밀번호 찾기 결과 페이지로 이동
	@GetMapping("/users/find_result")
	public String findResult() {
		return "users/findResult";
	}
	
	// 비밀번호 변경 페이지로 이동
	@GetMapping("/users/change_pwd")
	public String changePwd() {
		return "users/changePwd";
	}
	
	// 비밀번호 변경
	@PostMapping("/users/change_pwd")
	public String changePwdProcess(Model model, String users_pwd, String users_id){
		String cmd = ""; // move or back
		String msg = "";
		String url = "";
		Map<String, String> user_info = new HashMap<>();
		user_info.put("users_pwd", users_pwd);
		user_info.put("users_id", users_id);
		boolean pwdIsChanged = service.changePwd(user_info);
		if(pwdIsChanged) { // 비밀번호 변경 성공
			cmd = "move";
			msg = "비밀번호가 변경되었습니다.";
			url = "/users/login";
		}else { // 비밀번호 변경 실패
			cmd = "back";
			msg = "비밀변호 변경에 실패했습니다.";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("cmd", cmd);
		model.addAttribute("url", url);
		
		return "common/inform";
	}

	// 관심지역 수정
	@ResponseBody
	@PostMapping("/update/favor_areas")
	public boolean updateAreas(HttpSession sess, @RequestBody Map<String, Object> areas) {
		Map<String, Object> dataForAreaUpdate = new HashMap<>();
		UsersVO vo = (UsersVO) sess.getAttribute("users_info");
		dataForAreaUpdate.put("users_id", vo.getUsers_id());
		dataForAreaUpdate.put("areas", areas.get("addr"));
		
		int result = service.updateAreas(dataForAreaUpdate);
		
		return result == 1 ? true : false;
	}
	
	// [마이페이지] 비밀번호 변경 시, 비밀번호가 맞는지 여부 확인
	@ResponseBody
	@PostMapping("/pwd/check")
	public boolean pwdCheck(HttpSession sess, @RequestBody Map<String, Object> pwd) {
		UsersVO vo = (UsersVO) sess.getAttribute("users_info");
		
		String encryptPwd = service.selectPwd(vo.getUsers_id());
		boolean isValid = BCrypt.checkpw((String)pwd.get("data"), encryptPwd);
		
		return isValid;
	}
	
	// [마이페이지] 비밀번호 변경
	@ResponseBody
	@PostMapping("/pwd/change")
	public boolean pwdChange(HttpSession sess, @RequestBody Map<String, Object> pwd) {
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		
		Map<String, Object> dataForValidPwd = new HashMap<>();
		UsersVO vo = (UsersVO) sess.getAttribute("users_info");
		dataForValidPwd.put("users_id", vo.getUsers_id());
		dataForValidPwd.put("users_pwd", encoder.encode((String)pwd.get("data")));	
		return service.pwdChange(dataForValidPwd) == 1 ? true : false;
	}
	
	// 로그아웃
	@GetMapping("/users/logout")
	public String logout(HttpSession sess) {
		sess.removeAttribute("users_info");
		return "redirect:/";
	}
	
	// 회원탈퇴
	@ResponseBody
	@PostMapping("/users/delete")
	public Map<String, Integer> deleteAccount(HttpSession sess, @RequestBody Map<String, Object> pwd) {
		System.out.println();
		
		UsersVO vo = (UsersVO) sess.getAttribute("users_info");
		String encryptPwd = service.selectPwd(vo.getUsers_id());
		boolean isValid = BCrypt.checkpw((String)pwd.get("data"), encryptPwd);

		Map<String, Integer> result = new HashMap<>();
		if(isValid) { // 비밀번호 일치
			int auctionsCount = 0;
			auctionsCount += auctionsService.countAuctions(vo.getUsers_id());
			auctionsCount += auctionsService.countAuctionsIng(vo.getUsers_id());
			if(auctionsCount == 0) { // 진행 중인 경매가 없는 경우
				if(service.deleteAccount(vo.getUsers_id()) == 1) { // 회원탈퇴 성공
					result.put("resultCode", 0);
				} else { // 회원탈퇴 실패
					result.put("resultCode", 3);
				}
			} else { // 회원탈퇴 실패 - 진행 중인 경매가 있음
				result.put("resultCode", 2);
			}
		} else { // 회원탈퇴 실패 - 비밀번호 불일치
			result.put("resultCode", 1);
		}
		return result;
	}
	
	// 마이페이지 - 목록
	@GetMapping("/mypage/{pageName}")
	public String mypageListPages(@PathVariable("pageName") String pageName, Model model, HttpSession sess, Integer page, Integer scroll) {
		// 총 게시글 수 계산
		UsersVO vo = (UsersVO) sess.getAttribute("users_info");
		int itemsNumPerPage = 5;
		int totalAuctionsNum = 0;
		if("auctions".equals(pageName)) { // 경매 중
			totalAuctionsNum = auctionsService.countAuctions(vo.getUsers_id());
		} else if("auctions_ing".equals(pageName)) { // 거래 중
			totalAuctionsNum = auctionsService.countAuctionsIng(vo.getUsers_id());
		} else if("auctions_end_sold".equals(pageName)) { // 판매 완료
			totalAuctionsNum = auctionsService.countAuctionsEndSold(vo.getUsers_id());
		} else if("auctions_end_bought".equals(pageName)) { // 구매 완료
			totalAuctionsNum = auctionsService.countAuctionsEndBought(vo.getUsers_id());
		} else if("auctions_break".equals(pageName)) { // 파기 상품
			totalAuctionsNum = auctionsService.countAuctionsBreak(vo.getUsers_id());
		} else if("auctions_fail".equals(pageName)) { // 유찰 상품
			totalAuctionsNum = auctionsService.countAuctionsFail(vo.getUsers_id());
		} else if("favors_list".equals(pageName)) { // 찜 상품
			totalAuctionsNum = auctionsService.countFavors(vo.getUsers_id());
		} else if("qnas".equals(pageName)) { // 문의 내역
			totalAuctionsNum = service.countQnas(vo.getUsers_id());
			itemsNumPerPage = 10;
		}
		totalAuctionsNum = (int) Math.ceil(((double)totalAuctionsNum) / itemsNumPerPage);
		int nowPage1 = 0; // 현재 페이지 (1의 자리)
		int nowPage10 = 0; // 현재 페이지 (10의 자리)
		
		// 거래중 게시글 조회에 필요한 값(유저 id, 페이지 번호) 저장
		Map<String, Integer> auctionsVal = new HashMap<String, Integer>();
		auctionsVal.put("users_id", vo.getUsers_id());
		if(page == null || page > totalAuctionsNum) {
			auctionsVal.put("start_page", 0);
			nowPage1 = 1;
			nowPage10 = 0;
		} else {
			auctionsVal.put("start_page", (page-1)*itemsNumPerPage);
			nowPage1 = page;
			nowPage10 = ((int)(page-1)/10) * 10;
		}
		
		// 글 목록, 메뉴 index 저장
		if("auctions".equals(pageName)) { // 경매 중
			model.addAttribute("ListData", auctionsService.checkAuctions(auctionsVal));
			model.addAttribute("menuTab", 0);
			model.addAttribute("menuNum", 0);
		} else if("auctions_ing".equals(pageName)) { // 거래 중
			model.addAttribute("ListData", auctionsService.checkAuctionsIng(auctionsVal));
			model.addAttribute("menuTab", 0);
			model.addAttribute("menuNum", 1);
		} else if("auctions_end_sold".equals(pageName)) { // 판매 완료
			model.addAttribute("ListData", auctionsService.checkAuctionsEndSold(auctionsVal));
			model.addAttribute("menuTab", 0);
			model.addAttribute("menuNum", 2);
		} else if("auctions_end_bought".equals(pageName)) { // 구매 완료
			model.addAttribute("ListData", auctionsService.checkAuctionsEndBought(auctionsVal));
			model.addAttribute("menuTab", 0);
			model.addAttribute("menuNum", 3);
		} else if("auctions_break".equals(pageName)) { // 파기 상품
			model.addAttribute("ListData", auctionsService.checkAuctionsBreak(auctionsVal));
			model.addAttribute("menuTab", 0);
			model.addAttribute("menuNum", 4);
		} else if("auctions_fail".equals(pageName)) { // 유찰 상품
			model.addAttribute("ListData", auctionsService.checkAuctionsFail(auctionsVal));
			model.addAttribute("menuTab", 0);
			model.addAttribute("menuNum", 5);
		} else if("favors_list".equals(pageName)) { // 찜 상품
			model.addAttribute("ListData", auctionsService.checkFavors(auctionsVal));
			model.addAttribute("menuTab", 0);
			model.addAttribute("menuNum", 6);
		} else if("qnas".equals(pageName)) { // 문의 내역
			model.addAttribute("ListData", service.checkQnas(auctionsVal));
			model.addAttribute("menuTab", 1);
			model.addAttribute("menuNum", 2);
		}
		
		// 페이지 번호 전달
		model.addAttribute("pageNum1", nowPage1); // 현재 페이지(1의 자리)
		model.addAttribute("pageNum10", nowPage10); // 현재 페이지(10의 자리)
		model.addAttribute("pageNumMax", totalAuctionsNum); // 전체 페이지 수
		
		model.addAttribute("scrollY", scroll);
		
		return "mypage/main";
	}
	
	// 마이페이지 - 프로필 수정
	@PostMapping("/mypage/profile/change")
	public String mypageProfileChange(MultipartFile profileImg, HttpSession sess, RedirectAttributes ra) {
		UsersVO vo = (UsersVO) sess.getAttribute("users_info");
		UploadImage ui = fs.storeProfileFile(profileImg, vo.getUsers_id());
		
		Map<String, Object> dataForUpdateProfile = new HashMap<>();
		dataForUpdateProfile.put("users_id", vo.getUsers_id());
		dataForUpdateProfile.put("img", ui.getFullPath());
		
		int result = service.updateProfile(dataForUpdateProfile);
		ra.addFlashAttribute("updateResult", result == 1 ? true : false);
		
		return "redirect:/mypage/auctions";
	}
	
	// 마이페이지 - 관심지역 수정 페이지로 이동
	@GetMapping("/mypage/favors_list/fix")
	public String mypageFavorsListFix(Model model, HttpSession session, Integer scroll) {
		model.addAttribute("menuTab", 1);
		model.addAttribute("menuNum", 0);
		
		// 접속한 유저의 관심지역 조회
		UsersVO vo = (UsersVO) session.getAttribute("users_info");
		String areasStr = service.checkFavorAreas(vo.getUsers_id());
		System.out.println("areasStr: " + areasStr);
		String[] areas = areasStr != null ? (areasStr.length() != 0 ? areasStr.split(",") : null) : null;
		model.addAttribute("favor_areas", areas); 
		model.addAttribute("favor_areas_count", areas != null ? areas.length : 0);

		model.addAttribute("scrollY", scroll);
		
		return "mypage/main";
	}
	
	// 마이페이지 - 비밀번호 수정 페이지로 이동
	@GetMapping("/mypage/pwd/change")
	public String mypagePwdChange(Model model, HttpSession session, Integer scroll) {
		model.addAttribute("menuTab", 1);
		model.addAttribute("menuNum", 1);

		model.addAttribute("scrollY", scroll);
		
		return "mypage/main";
	}

}
