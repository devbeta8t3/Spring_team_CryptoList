package team.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import team.domain.FavorVO;

public interface FavorMapper {
	
	public int insert(FavorVO vo);
	
	public int delete(FavorVO vo);
	
	public List<FavorVO> getFavList(@Param("u_id") String u_id);

}
