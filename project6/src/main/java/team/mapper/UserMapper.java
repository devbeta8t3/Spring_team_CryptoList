package team.mapper;

import team.domain.UserDTO;

public interface UserMapper {
	
	public UserDTO userLogin(UserDTO user);
	
	public void userRegister(UserDTO user);
	
	public void userUpdate(UserDTO user);

	public void userDelete(UserDTO user);

	public int useridCheck(String u_id);
	
}
