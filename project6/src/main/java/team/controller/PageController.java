package team.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
//@RequestMapping("/board/*")	// 디렉토리 구조에 따라 추가
@AllArgsConstructor
public class PageController {
	
	@GetMapping("/list")
	public void list() {
	}
	
	@GetMapping("/info")
	public String info(@RequestParam("cSymbol") String symbol) {
		
		log.info("Information page with param : " +symbol);
		return "/info.jsp?cSymbol=" +symbol;
	}

	@GetMapping("/favorites")
	public String favor(@RequestParam("u_id") String u_id) {
		
		log.info("Favorites page with param : " +u_id);
		return "/favorites.jsp?u_id=" +u_id;
	}
	
	// 로그인/회원가입/회원수정 페이지는 UserController로 처리 - 김록길
//	@GetMapping("/memberLogin")
//	public void memberLogin() {
//	}
	
}
