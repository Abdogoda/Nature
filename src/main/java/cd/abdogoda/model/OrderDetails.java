package cd.abdogoda.model;

import java.sql.Timestamp;

public class OrderDetails {
	public OrderDetails() {}
	private int orderId;
	private int userId;
	private String city;
	private String state;
	private String street;
	private String building;
	private String flat;
	private String payment_method;
	private Double sub_total;
	private Double shipping_tax;
	private Double total;
	private Timestamp date;
	public OrderDetails(int orderId, int userId, String city, String state, String street,
			String building, String flat, String payment_method, Double sub_total, Double shipping_tax, Double total,
			Timestamp date) {
		this.orderId = orderId;
		this.userId = userId;
		this.city = city;
		this.state = state;
		this.street = street;
		this.building = building;
		this.flat = flat;
		this.payment_method = payment_method;
		this.sub_total = sub_total;
		this.shipping_tax = shipping_tax;
		this.total = total;
		this.date = date;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getStreet() {
		return street;
	}
	public void setStreet(String street) {
		this.street = street;
	}
	public String getBuilding() {
		return building;
	}
	public void setBuilding(String building) {
		this.building = building;
	}
	public String getFlat() {
		return flat;
	}
	public void setFlat(String flat) {
		this.flat = flat;
	}
	public String getPayment_method() {
		return payment_method;
	}
	public void setPayment_method(String payment_method) {
		this.payment_method = payment_method;
	}
	public Double getSub_total() {
		return sub_total;
	}
	public void setSub_total(Double sub_total) {
		this.sub_total = sub_total;
	}
	public Double getShipping_tax() {
		return shipping_tax;
	}
	public void setShipping_tax(Double shipping_tax) {
		this.shipping_tax = shipping_tax;
	}
	public Double getTotal() {
		return total;
	}
	public void setTotal(Double total) {
		this.total = total;
	}
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}

}
