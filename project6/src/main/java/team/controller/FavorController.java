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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;


import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import team.domain.FavorVO;
import team.service.FavorService;

@RequestMapping("/*")	// 1차 맵핑
@Log4j
@RestController
@AllArgsConstructor
public class FavorController {

	private FavorService service;
	
	// 즐겨찾기 추가
	// 클라이언트(브라우저)는 JSON 타입으로 된 즐겨찾기 데이터를 전송하고,
	// 서버는 즐겨찾기의 처리 결과가 정상적으로 되었는지 문자열로 결과를 알려주는 방식으로 처리
	@PostMapping(value = "/new", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody FavorVO vo) {
		
		log.info("FavorVO: " + vo);
		
		int insertCount = service.register(vo);
		log.info("Favorite INSERT COUNT: " + insertCount);
		
		return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
								: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 줄겨찾기 삭제
	@DeleteMapping(value= "/del", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> remove(@RequestBody FavorVO vo) {
		
		log.info("remove: " + vo);
		
		return service.remove(vo) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
										: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 즐겨찾기 가져오기
	@GetMapping(value = "/getFav/{u_id}", 
				produces = { MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<List<FavorVO>> getFav(@PathVariable("u_id") String u_id) {	// 객체를 JSON 형태로 html 바디에 응답해준다.
		
		log.info("gettin Favorite List......................");
		log.info("User ID: " +u_id);
		
		return new ResponseEntity<>(service.getList(u_id), HttpStatus.OK);	
	}
}
