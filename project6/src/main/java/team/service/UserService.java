package team.service;

import team.domain.UserDTO;

public interface UserService
{

	// 로그인
	public UserDTO userLogin(UserDTO user) throws Exception;

	// 회원 가입
	public void userRegister(UserDTO user) throws Exception;

	// 회원정보 수정
	public void userUpdate(UserDTO user) throws Exception;

	// 회원 탈퇴
	public void userDelete(UserDTO user) throws Exception;

	// ID 중복 체크
	public int useridCheck(String u_id) throws Exception;

}
