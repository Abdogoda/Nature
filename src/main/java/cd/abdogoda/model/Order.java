package cd.abdogoda.model;

import java.sql.Timestamp;

public class Order extends Product{
	private int o_id;
	private int orderId;
	private int productId;
	private int quantity;
	private double orderPrice;
	private double orderTotal;
	private Timestamp o_date;
	public Order() {}
	public Order(int o_id, int orderId, int productId, int quantity, double orderPrice, double orderTotal, Timestamp o_date) {
		this.o_id = o_id;
		this.orderId = orderId;
		this.productId = productId;
		this.quantity = quantity;
		this.orderPrice = orderPrice;
		this.orderTotal = orderTotal;
		this.o_date = o_date;
	}
	public Timestamp getO_date() {
		return o_date;
	}
	public void setO_date(Timestamp o_date) {
		this.o_date = o_date;
	}
	public int getO_id() {
		return o_id;
	}
	public void setO_id(int o_id) {
		this.o_id = o_id;
	}
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public double getOrderPrice() {
		return orderPrice;
	}
	public void setOrderPrice(double orderPrice) {
		this.orderPrice = orderPrice;
	}
	public double getOrderTotal() {
		return orderTotal;
	}
	public void setOrderTotal(double orderTotal) {
		this.orderTotal = orderTotal;
	}
	@Override
	public String toString() {
		return "Order [o_id=" + o_id + ", orderId=" + orderId + ", productId=" + productId + ", quantity=" + quantity
				+ ", orderPrice=" + orderPrice + ", orderTotal=" + orderTotal + "]";
	}
}
