package team.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import team.domain.BoardDTO;
import team.mapper.BoardMapper;


@Log4j
@Service
//@AllArgsConstructor 대신 @Setter 사용
public class BoardServiceImpl implements BoardService {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Override
	public int register(BoardDTO dto) {// BoardMapper의 insert 실행
		
		log.info("register......" +dto);
		return mapper.insert(dto);
	}

	@Override
	public int remove(BoardDTO dto) {// BoardMapper의 delete 실행
		
		log.info("remove......" +dto);
		return mapper.delete(dto);
	}

	@Override
	public List<BoardDTO> getList(String symbol) {// BoardMapper의 getBoardList 실행
		
		log.info("get Favorite List of Symbol : " +symbol);
		return mapper.getBoardList(symbol);
	}

	
}
