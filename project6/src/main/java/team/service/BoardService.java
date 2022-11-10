package team.service;

import java.util.List;

import team.domain.BoardDTO;


public interface BoardService {
	
	public int register(BoardDTO dto);
		
	public int modify(BoardDTO dto);
	
	public int remove(BoardDTO dto);
	
	public List<BoardDTO> getList(String symbol);
	
}
