package team.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import team.domain.UserVO;
import team.service.UserService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping(value = "/")
public class UserController
{
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	@Autowired
	private UserService userservice;

	// 회원가입 페이지 이동메서드
	@RequestMapping(value = "register", method = RequestMethod.GET)
	public void registerGET()
	{
		logger.info("회원가입 페이지로 이동 - GET method");
	}

	// 회원가입 메서드
	@RequestMapping(value = "register", method = RequestMethod.POST)
	public String registerPOST(UserVO user) throws Exception
	{
		// 회원가입 서비스 실행
		userservice.userRegister(user);

		logger.info("회원가입 성공 - POST method");
		logger.info("홈화면 으로 이동 ");

		return "redirect:/";// 홈으로 이동
	}

	// 아이디 중복 검사 메서드
	@RequestMapping(value = "useridCheck", method = RequestMethod.POST)
	@ResponseBody
	public String useridCheckPOST(String u_id) throws Exception
	{
		logger.info("useridCheck()");

		int result = userservice.useridCheck(u_id);

		logger.info("결과값 = " + result);

		if (result != 0)
		{
			return "fail"; // 중복 아이디가 존재
		} else
		{
			return "success"; // 중복 아이디 x
		}
	}

	// 회원 정보 페이지
	@RequestMapping(value = "userInfo", method = RequestMethod.GET)
	public String userInfo()
	{
		return "userInfo";
	}

	// 회원 정보 수정
	@RequestMapping(value = "userUpdate", method = RequestMethod.POST)
	public String userUpdate(UserVO vo, HttpSession session) throws Exception
	{
		userservice.userUpdate(vo);


		return "redirect:/list";
	}

	// 회원 삭제
	@RequestMapping(value = "userDelete", method = RequestMethod.POST)
	public String userDelete(UserVO vo, HttpSession session) throws Exception
	{
		userservice.userDelete(vo);
		session.invalidate();
		return "redirect:/login";
	}

	// 로그인 페이지 이동메서드
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public void loginGET()
	{
		logger.info("로그인 페이지로 이동");
	}

	// 로그인 메서드
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String loginPOST(HttpServletRequest request, UserVO user, RedirectAttributes rttr) throws Exception
	{
		// System.out.println("login 메서드 시작");
		// System.out.println("전달데이터 : " + user);

		HttpSession session = request.getSession();
		UserVO lvo = userservice.userLogin(user);

		if (lvo == null)
		{
			// 일치하지 않는 아이디, 비밀번호 입력 경우(로그인 실패)
			int result = 0;
			rttr.addFlashAttribute("result", result);
			logger.info("로그인 실패");
			return "redirect:/login";
		}
		// 일치하는 아이디, 비밀번호 경우(로그인 성공)
		session.setAttribute("user", lvo);
		session.setAttribute("sessionId", lvo.getU_id());
		logger.info("로그인 성공");
		return "redirect:/list";
	}

	// 로그아웃 메서드
	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request) throws Exception
	{
		logger.info("logout 메서드실행");

		HttpSession session = request.getSession();
		session.invalidate();

		return "redirect:/";// 홈으로 이동
	}
}
