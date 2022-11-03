package team.domain;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class FavVOList {

	private List<FavorVO> list;
	
	public FavVOList() {
		list = new ArrayList<>();
	}
}
