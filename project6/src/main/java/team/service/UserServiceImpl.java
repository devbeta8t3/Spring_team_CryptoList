package team.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import team.mapper.UserMapper;
import team.domain.UserDTO;

@Service
public class UserServiceImpl implements UserService
{

	@Autowired
	UserMapper usermapper;

	// 로그인
	@Override
	public UserDTO userLogin(UserDTO user) throws Exception
	{
		return usermapper.userLogin(user);
	}

	// 회원 가입
	@Override
	public void userRegister(UserDTO user) throws Exception
	{
		usermapper.userRegister(user);
	}

	// 회원정보 수정
	@Override
	public void userUpdate(UserDTO user) throws Exception
	{
		usermapper.userUpdate(user);
	}

	// 회원 탈퇴
	@Override
	public void userDelete(UserDTO user) throws Exception
	{
		usermapper.userDelete(user);
	}

	// ID 중복 체크
	@Override
	public int useridCheck(String u_id) throws Exception
	{
		return usermapper.useridCheck(u_id);
	}

}
