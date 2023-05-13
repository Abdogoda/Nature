package cd.abdogoda.model;

import java.sql.Date;

public class Employee {
	private int employee_id;
	private Date birth_date;
	private int gender;
	private String ssn;
	private int job_id;
	public Employee() {}
	public Employee(int employee_id, Date birth_date, int gender, String ssn, int job_id) {
		this.employee_id = employee_id;
		this.birth_date = birth_date;
		this.gender = gender;
		this.ssn = ssn;
		this.job_id = job_id;
	}
	public int getEmployee_id() {
		return employee_id;
	}
	public void setEmployee_id(int employee_id) {
		this.employee_id = employee_id;
	}
	public Date getBirth_date() {
		return birth_date;
	}
	public void setBirth_date(Date birth_date) {
		this.birth_date = birth_date;
	}
	public int getGender() {
		return gender;
	}
	public void setGender(int gender) {
		this.gender = gender;
	}
	public String getSsn() {
		return ssn;
	}
	public void setSsn(String ssn) {
		this.ssn = ssn;
	}
	public int getJob_id() {
		return job_id;
	}
	public void setJob_id(int job_id) {
		this.job_id = job_id;
	}
	
}
