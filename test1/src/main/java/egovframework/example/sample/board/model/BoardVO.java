package egovframework.example.sample.board.model;
import java.util.Date;




public class BoardVO {
	
    private Long id;
	private String title;
	private String content;
	private Date created;
	private Date updated;
	private Long user_id;
	private String user_name;
	

	
	
	public String getUser_name() {
		return user_name;
	}
	
	public Long getUser_id() {
		return user_id;
	}
	
	public Long getId() {
		return id;
	}
	
	public String getTitle() {
		return title;
	}
	
	public String getContent() {
		return content;
	}
	
	public Date getCreated() {
		return created;
	}
	
	public Date getUpdated() {
		return updated;
	}
	
	public void setUser_name(String user_name) {
		this.user_name =user_name;
	}
	public void setUser_id(Long user_id) {
	
		this.user_id = user_id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	public void setContent(String content) {
		this.content = content;
	}
	
	public void setCreated(Date created) {
		this.created = created;
	}
	
	public void setUpdated(Date updated) {
		this.updated = updated;
	}


}
