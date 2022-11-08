package team.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import team.domain.BoardDTO;

public interface BoardMapper {
	
	public int insert(BoardDTO dto);
	
	public int delete(BoardDTO dto);
	
	public List<BoardDTO> getBoardList(@Param("symbol") String symbol);

}
