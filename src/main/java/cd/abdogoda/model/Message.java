package cd.abdogoda.model;

import java.sql.Timestamp;

public class Message {
	private int id;
	private String name;
	private String phone;
	private String email;
	private String message;
	private boolean isRead;
	private Timestamp date;
	
	public Message(int id, String name, String phone, String email, String message, Timestamp date, boolean isRead) {
		this.id = id;
		this.name = name;
		this.phone = phone;
		this.email = email;
		this.message = message;
		this.isRead = isRead;
		this.date = date;
	}

	public String getEmail() {
		return email;
	}

	public boolean getIsRead() {
		return isRead;
	}

	public void setIsRead(boolean isRead) {
		this.isRead = isRead;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Timestamp getDate() {
		return date;
	}

	public void setDate(Timestamp date) {
		this.date = date;
	}

	public Message() {}

	
}
