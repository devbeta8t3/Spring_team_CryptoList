package team.service;

import java.util.List;

import team.domain.FavorVO;

public interface FavorService {
	
	public int register(FavorVO vo);
	
	public int remove(FavorVO vo);
	
	public List<FavorVO> getList(String u_id);
	

}
