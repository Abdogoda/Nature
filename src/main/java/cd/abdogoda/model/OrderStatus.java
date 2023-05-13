package cd.abdogoda.model;

import java.sql.Timestamp;

public class OrderStatus {
	private int status_id;
	private int o_id;
	private int e_id;
	private String status;
	private Timestamp status_date;
	public OrderStatus() {}
	public OrderStatus(int status_id, int o_id, int e_id, String status, Timestamp status_date) {
		super();
		this.status_id = status_id;
		this.o_id = o_id;
		this.e_id = e_id;
		this.status = status;
		this.status_date = status_date;
	}
	public int getStatus_id() {
		return status_id;
	}
	public void setStatus_id(int status_id) {
		this.status_id = status_id;
	}
	public int getO_id() {
		return o_id;
	}
	public void setO_id(int o_id) {
		this.o_id = o_id;
	}
	public int getE_id() {
		return e_id;
	}
	public void setE_id(int e_id) {
		this.e_id = e_id;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Timestamp getStatus_date() {
		return status_date;
	}
	public void setStatus_date(Timestamp status_date) {
		this.status_date = status_date;
	}
}
