package team.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.log4j.Log4j;
import team.domain.FavorVO;

@Controller
@RequestMapping("/*")	// 1차 맵핑
@Log4j
public class FavorController {

	@GetMapping("/getFav")
	public @ResponseBody FavorVO getFav(String u_id) {	// 객체를 JSON 형태로 html 바디에 응답해준다.
		
		log.info("/getFav......................");
		FavorVO dto = new FavorVO();
		// 입력받은 u_id가 DB와 일치하면 값 쏴줘!!!
		//dto.setU_id(u_id);
		//dto.setSymbol();
		
		// 객체를 반환하면 JSON 형태로 응답 @ResponseBody
		// 따라서 ajax 응답으로 적합한듯.
		return dto;	
	}
}
