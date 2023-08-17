package egovframework.example.sample.user.model;

import java.util.Date;

public class UserVO {
	
	private Long user_id;
	private String email;
	private String password;
	private String name;
	private String loginMethod;
	private Date created;
	private Date updated;
	private Date deleted;
	private boolean isDeleted;
	private int grade;
	private boolean isAdmin;
	

	
	public Long getUser_id() {
		return user_id;
	}
	
	public String getEmail() {
		return email;
	}
	
	public String getPassword() {
		return password;
	}
	
	public String getName() {
		return name;
	}
	
	public String getLoginMethod() {
		return loginMethod;
	}
	
	public Date getCreated() {
		return created;
	}
	
	public Date getUpdated() {
		return updated;
	}
	
	public boolean getIsAdmin() {
		return isAdmin;
	}
	
	public void setUser_id(Long user_id) {
		this.user_id=user_id;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	public void setName(String name) {
		this.name=name;
	}
	
	public void setLoginMethod(String loginMethod) {
		this.loginMethod = loginMethod;
	}
	
	public void setCreated(Date created) {
		this.created = created;
	}
	
	public void setUpdated(Date updated) {
		this.updated =updated;
	}
	
	public void setIsAdmin(boolean isAdmin) {
		this.isAdmin = isAdmin;
	}

	public int getGrade() {
		return grade;
	}

	public void setGrade(int grade) {
		this.grade = grade;
	}

	public void setAdmin(boolean isAdmin) {
		this.isAdmin = isAdmin;
	}

	public Date getDeleted() {
		return deleted;
	}

	public void setDeleted(Date deleted) {
		this.deleted = deleted;
	}

	public boolean getIsDeleted() {
		return isDeleted;
	}

	public void setIsDeleted(boolean isDeleted) {
		this.isDeleted = isDeleted;
	}
}
