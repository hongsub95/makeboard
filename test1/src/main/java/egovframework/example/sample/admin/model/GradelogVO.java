package egovframework.example.sample.admin.model;

import java.util.Date;

public class GradelogVO {
	private Long gradeId;
	private Long qualify_userId;
	private Long qualified_userId;
	private int qualify_grade;
	private int qualified_grade;
	private Date created;
	
	public Long getGradeId() {
		return gradeId;
	}
	public void setGradeId(Long gradeId) {
		this.gradeId = gradeId;
	}
	public Long getQualify_userId() {
		return qualify_userId;
	}
	public void setQualify_userId(Long qualify_userId) {
		this.qualify_userId = qualify_userId;
	}
	public Long getQualified_userId() {
		return qualified_userId;
	}
	public void setQualified_userId(Long qualified_userId) {
		this.qualified_userId = qualified_userId;
	}
	public int getQualify_grade() {
		return qualify_grade;
	}
	public void setQualify_grade(int qualify_grade) {
		this.qualify_grade = qualify_grade;
	}
	public int getQualified_grade() {
		return qualified_grade;
	}
	public void setQualified_grade(int qualified_grade) {
		this.qualified_grade = qualified_grade;
	}
	public Date getCreated() {
		return created;
	}
	public void setCreated(Date created) {
		this.created = created;
	}
	
}
