package team.domain;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

// 만들었지만 활용 안했음
@Data
public class FavVOList {

	private List<FavorVO> list;
	
	public FavVOList() {
		list = new ArrayList<>();
	}
}
