package team.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import team.domain.FavorVO;
import team.mapper.FavorMapper;


@Log4j
@Service
//@AllArgsConstructor 대신 @Setter 사용
public class FavorServiceImpl implements FavorService {

	@Setter(onMethod_ = @Autowired)
	private FavorMapper mapper;
	
	@Override
	public int register(FavorVO vo) {// FavorMapper의 insert 실행
		
		log.info("register......" +vo);
		return mapper.insert(vo);
	}

	@Override
	public int remove(FavorVO vo) {// FavorMapper의 delete 실행
		
		log.info("remove......" +vo);
		return mapper.delete(vo);
	}

	@Override
	public List<FavorVO> getList(String u_id) {// FavorMapper의 getFavList 실행
		
		log.info("get Favorite List of User ID : " +u_id);
		return mapper.getFavList(u_id);
	}

	
}
