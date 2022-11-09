package team.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import team.domain.BoardDTO;
//import team.domain.Criteria;
import team.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {
	
	private BoardService service;
	
	// 게시물 등록하기
	@PostMapping(value = "/newBoard", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody BoardDTO dto) {
		
		log.info("BoardDTO: " + dto);
		
		int insertCount = service.register(dto);
		log.info("Board INSERT COUNT: " + insertCount);
		
		return insertCount == 1 ? new ResponseEntity<>("newBoard success", HttpStatus.OK)
								: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 게시물 삭제
	@DeleteMapping(value= "/delBoard", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> remove(@RequestBody BoardDTO dto) {
		
		log.info("Board remove: " + dto);
		
		return service.remove(dto) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
										: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 게시물 리스트 가져오기
	@GetMapping(value = "/getBoard/{symbol}", 
				produces = { MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<List<BoardDTO>> getBoard(@PathVariable("symbol") String symbol) {	// 객체를 JSON 형태로 html 바디에 응답해준다.
		
		log.info("getting Board List................. Symbol: " +symbol);
		
		return new ResponseEntity<>(service.getList(symbol), HttpStatus.OK);	
	}
	
	
	
//	public void register() {
//		
//	}
	
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
	
//	@PostMapping("/register")	// 2. 입력
//	public String register(BoardVO board, RedirectAttributes rttr) {
//		
//		log.info("register: " +board);
//		service.register(board);
//		rttr.addFlashAttribute("result", board.getBno());
//		
//		return "redirect:/board/list";
//	}
	
//	@GetMapping("/get")			// 3. 검색
//	@GetMapping( {"/get", "/modify"} )			// 3. 검색
//	public void get(@RequestParam("bno") Long bno, Model model) {
//		
//		log.info("/get");
//		model.addAttribute("board", service.get(bno));
//	}
	
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
//	@PostMapping("/remove")		// 5. 삭제
//	@GetMapping("/remove")		// 5. 삭제
//	@RequestMapping(value = "remove", method = { RequestMethod.GET, RequestMethod.POST })
//	public String remove(@RequestParam("bno") Long bno, RedirectAttributes rttr) {
//		
//		log.info("remove... " +bno);
//		if (service.remove(bno)) {
//			rttr.addFlashAttribute("result", "success");	// flash: 1회성 - 삭제/수정/등록 등 '뒤로가기'버튼에 의한 오류 방지
//		}
//		return "redirect:/board/list";
//	}
//	

}
