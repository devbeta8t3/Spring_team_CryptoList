package team.mapper;

import team.domain.UserVO;

public interface UserMapper {
	
	//�α���
	public UserVO userLogin(UserVO user);
	
	//ȸ������
	public void userRegister(UserVO user);
	
	//ȸ������ ����
	public void userUpdate(UserVO user);

	//ȸ������
	public void userDelete(UserVO user);

	//���̵� �ߺ� �˻� 
	public int useridCheck(String u_id);
	
}
