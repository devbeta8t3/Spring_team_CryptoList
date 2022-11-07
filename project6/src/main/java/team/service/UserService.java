package team.service;

import team.domain.UserVO;

public interface UserService
{

	// 로그인
	public UserVO userLogin(UserVO user) throws Exception;

	// 회원 가입
	public void userRegister(UserVO user) throws Exception;

	// 회원정보 수정
	public void userUpdate(UserVO user) throws Exception;

	// 회원 탈퇴
	public void userDelete(UserVO user) throws Exception;

	// ID 중복 체크
	public int useridCheck(String u_id) throws Exception;

}
