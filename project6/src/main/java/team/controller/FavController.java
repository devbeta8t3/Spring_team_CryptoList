package team.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.log4j.Log4j;
import team.domain.FavVO;

@Controller
@RequestMapping("/*")	// 1차 맵핑
@Log4j
public class FavController {

	@GetMapping("/getFav")
	public @ResponseBody FavVO getFav(String u_id) {	// 객체를 JSON 형태로 html 바디에 응답해준다.
		
		log.info("/getFav......................");
		FavVO dto = new FavVO();
		// 입력받은 u_id가 DB와 일치하면 값 쏴줘!!!
		dto.setU_id(u_id);
		dto.setSymbol(symbol);
		
		return dto;	// 객체를 반환하면 JSON 형태로 응답 @ResponseBody
	}
}
