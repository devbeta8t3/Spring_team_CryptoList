package team.domain;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class BoardDTOList {

	private List<BoardDTO> list;
	
	public BoardDTOList() {
		list = new ArrayList<>();
	}
}
