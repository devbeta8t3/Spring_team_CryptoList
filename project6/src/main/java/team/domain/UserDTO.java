package team.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class UserDTO {

	private String u_id;
	private String u_name;
	private String u_email;
	private String u_pw;
	private Date u_regdate;
	
}
