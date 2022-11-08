package team.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardDTO {

	private int c_id;
	private String u_id;
	private String u_name;
	private String symbol;
	private Date c_date;
	private Date c_update;
	private String content;
	
}
