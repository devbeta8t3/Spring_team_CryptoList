package team.mapper;

import team.domain.UserDTO;

public interface UserMapper {
	
	//�α���
	public UserDTO userLogin(UserDTO user);
	
	//ȸ������
	public void userRegister(UserDTO user);
	
	//ȸ������ ����
	public void userUpdate(UserDTO user);

	//ȸ������
	public void userDelete(UserDTO user);

	//���̵� �ߺ� �˻� 
	public int useridCheck(String u_id);
	
}
