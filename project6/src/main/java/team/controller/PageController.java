package team.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	
	@GetMapping("/memberLogin")
	public void memberLogin() {
	}
	// FavorController로 처리하자...
//	@GetMapping("/favor")
//	public String favor(@RequestParam("u_id") String u_id) {
//		
//		log.info("Favorite page with u_id : " +u_id);
//		return "/favor.jsp?u_id=" +u_id;
//	}
	
////////////////////// 참고할 코드 //////////////////////
//	
//	@GetMapping("/list")		// 1. 목록 조회
//	public void list(Model model) {
//		
//		log.info("list");
//		model.addAttribute("list", service.getList());
//	}
	
//	@GetMapping("/list")		// 1. 목록 조회 (with criteria)
//	public void list(Criteria cri, Model model) {
//		
//		log.info("list" +cri);
//		model.addAttribute("list", service.getList(cri));
//	}
//	
//	@PostMapping("/register")	// 2. 입력
//	public String register(BoardVO board, RedirectAttributes rttr) {
//		
//		log.info("register: " +board);
//		service.register(board);
//		rttr.addFlashAttribute("result", board.getBno());
//		
//		return "redirect:/board/list";
//	}
//	
////	@GetMapping("/get")			// 3. 검색
//	@GetMapping( {"/get", "/modify"} )			// 3. 검색
//	public void get(@RequestParam("bno") Long bno, Model model) {
//		
//		log.info("/get");
//		model.addAttribute("board", service.get(bno));
//	}
//	
//	@PostMapping("/modify")		// 4. 수정
//	public String modify(BoardVO board, RedirectAttributes rttr) {
//		
//		log.info("modify: " +board);
//		if (service.modify(board)) {
//			rttr.addFlashAttribute("result", "success");
//		}
//		return "redirect:/board/list";
//	}
//	
////	@PostMapping("/remove")		// 5. 삭제
////	@GetMapping("/remove")		// 5. 삭제
//	@RequestMapping(value = "remove", method = { RequestMethod.GET, RequestMethod.POST })
//	public String remove(@RequestParam("bno") Long bno, RedirectAttributes rttr) {
//		
//		log.info("remove... " +bno);
//		if (service.remove(bno)) {
//			rttr.addFlashAttribute("result", "success");	// flash: 1회성 - 삭제/수정/등록 등 '뒤로가기'버튼에 의한 오류 방지
//		}
//		return "redirect:/board/list";
//	}
	

}
