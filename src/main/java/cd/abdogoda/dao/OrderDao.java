package cd.abdogoda.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import cd.abdogoda.model.Order;
import cd.abdogoda.model.OrderDetails;
import cd.abdogoda.model.OrderStatus;
import cd.abdogoda.model.Product;

public class OrderDao {
	private Connection conn;
	private String query;
	private PreparedStatement pst, pst2;
	private ResultSet rs;

	public OrderDao(Connection conn) {
		this.conn = conn;
	}

	public int insertOrderDetails(int u_id, String city, String state, String street, String building, String flat,
			String payment_method, Double sub_total, Double shipping_tax, Double total) {
		int id = 0;
		try {
			query = "INSERT INTO order_details (u_id, city, state, street, building, flat, payment_method, sub_total, shipping_tax, total) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pst = this.conn.prepareStatement(query);
			pst.setInt(1, u_id);
			pst.setString(2, city);
			pst.setString(3, state);
			pst.setString(4, street);
			pst.setString(5, building);
			pst.setString(6, flat);
			pst.setString(7, payment_method);
			pst.setDouble(8, sub_total);
			pst.setDouble(9, shipping_tax);
			pst.setDouble(10, total);
			pst.executeUpdate();

			// Retrieve the last inserted row's column values
			pst2 = this.conn.prepareStatement("SELECT MAX(o_id) FROM order_details");
			rs = pst2.executeQuery();
			if (rs.next()) {
				id = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return id;
	}

	public boolean insertOrderPayment(int o_id, String card_number, String card_holder, String card_cvv,
			String expiration_date) {
		boolean result = false;
		try {
			query = "INSERT INTO order_payment (o_id, card_number, card_holder, card_cvv, expiration_date) VALUES (?, ?, ?, ?, ?)";
			pst = this.conn.prepareStatement(query);
			pst.setInt(1, o_id);
			pst.setString(2, card_number);
			pst.setString(3, card_holder);
			pst.setString(4, card_cvv);
			pst.setString(5, expiration_date);
			pst.executeUpdate();
			result = true;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public boolean insertOrderStatus(int e_id, int o_id, String status) {
		boolean result = false;
		try {
			query = "INSERT INTO order_status (o_id, e_id, status) VALUES (?, ?, ?)";
			pst = this.conn.prepareStatement(query);
			pst.setInt(1, o_id);
			pst.setInt(2, e_id);
			pst.setString(3, status);
			pst.executeUpdate();
			result = true;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public boolean insertOrder(Order model) {
		boolean result = false;
		try {
			query = "INSERT INTO orders (o_id, p_id, o_price, quantity, total) VALUES (?, ?, ?, ?, ?)";
			pst = this.conn.prepareStatement(query);
			pst.setInt(1, model.getOrderId());
			pst.setInt(2, model.getProductId());
			pst.setDouble(3, model.getOrderPrice());
			pst.setInt(4, model.getQuantity());
			pst.setDouble(5, model.getOrderTotal());
			pst.executeUpdate();
			result = true;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public List<Order> allOrders() {
		List<Order> list = new ArrayList<>();
		try {
			query = "SELECT * FROM orders " + "INNER JOIN products ON orders.p_id = products.id "
					+ "INNER JOIN order_details ON orders.o_id = order_details.o_id " + "ORDER BY orders.id DESC";
			pst = this.conn.prepareStatement(query);
			rs = pst.executeQuery();
			while (rs.next()) {
				Order order = new Order();
				order.setOrderId(rs.getInt("o_id"));
				order.setProductId(rs.getInt("p_id"));
				order.setName(rs.getString("name"));
				order.setImage(rs.getString("image"));
				order.setCategory(rs.getString("category"));
				order.setOrderPrice(rs.getDouble("o_price"));
				order.setOrderTotal(rs.getDouble("o_price") * rs.getInt("quantity"));
				order.setQuantity(rs.getInt("quantity"));
				order.setO_date(rs.getTimestamp("o_date"));
				list.add(order);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<OrderDetails> allOrderDetails() {
		List<OrderDetails> list = new ArrayList<>();
		try {
			query = "SELECT * FROM order_details ORDER BY o_id DESC";
			pst = this.conn.prepareStatement(query);
			rs = pst.executeQuery();
			while (rs.next()) {
				OrderDetails order = new OrderDetails();
				order.setOrderId(rs.getInt("o_id"));
				order.setUserId(rs.getInt("u_id"));
				order.setSub_total(rs.getDouble("sub_total"));
				order.setShipping_tax(rs.getDouble("shipping_tax"));
				order.setTotal(rs.getDouble("total"));
				order.setDate(rs.getTimestamp("o_date"));
				list.add(order);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public List<OrderDetails> recentOrderDetails() {
		List<OrderDetails> list = new ArrayList<>();
		try {
			query = "SELECT * FROM order_details ORDER BY o_id DESC LIMIT 6";
			pst = this.conn.prepareStatement(query);
			rs = pst.executeQuery();
			while (rs.next()) {
				OrderDetails order = new OrderDetails();
				order.setOrderId(rs.getInt("o_id"));
				order.setUserId(rs.getInt("u_id"));
				order.setSub_total(rs.getDouble("sub_total"));
				order.setShipping_tax(rs.getDouble("shipping_tax"));
				order.setTotal(rs.getDouble("total"));
				order.setDate(rs.getTimestamp("o_date"));
				list.add(order);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public OrderDetails getOrderDetails(int o_id) {
		OrderDetails order_details = null;
		try {
			query = "SELECT * FROM order_details WHERE o_id = ?";
			pst = this.conn.prepareStatement(query);
			pst.setInt(1, o_id);
			rs = pst.executeQuery();
			while (rs.next()) {
				order_details = new OrderDetails();
				order_details.setOrderId(rs.getInt("o_id"));
				order_details.setUserId(rs.getInt("u_id"));
				order_details.setSub_total(rs.getDouble("sub_total"));
				order_details.setShipping_tax(rs.getDouble("shipping_tax"));
				order_details.setTotal(rs.getDouble("total"));
				order_details.setDate(rs.getTimestamp("o_date"));
				order_details.setCity(rs.getString("city"));
				order_details.setState(rs.getString("state"));
				order_details.setStreet(rs.getString("street"));
				order_details.setBuilding(rs.getString("building"));
				order_details.setFlat(rs.getString("flat"));
				order_details.setPayment_method(rs.getString("payment_method"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return order_details;
	}

	public List<OrderDetails> userOrderDetails(int id) {
		List<OrderDetails> list = new ArrayList<>();
		try {
			query = "SELECT * FROM order_details WHERE u_id = ? ORDER BY o_id DESC";
			pst = this.conn.prepareStatement(query);
			pst.setInt(1, id);
			rs = pst.executeQuery();
			while (rs.next()) {
				OrderDetails order = new OrderDetails();
				order.setOrderId(rs.getInt("o_id"));
				order.setUserId(rs.getInt("u_id"));
				order.setSub_total(rs.getDouble("sub_total"));
				order.setShipping_tax(rs.getDouble("shipping_tax"));
				order.setTotal(rs.getDouble("total"));
				order.setDate(rs.getTimestamp("o_date"));
				order.setCity(rs.getString("city"));
				order.setState(rs.getString("state"));
				order.setStreet(rs.getString("street"));
				order.setBuilding(rs.getString("building"));
				order.setFlat(rs.getString("flat"));
				order.setPayment_method(rs.getString("payment_method"));
				list.add(order);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<Order> userOrders(int id) {
		List<Order> list = new ArrayList<>();
		try {
			query = "SELECT * FROM orders " + "INNER JOIN products ON orders.p_id = products.id "
					+ "INNER JOIN order_details ON orders.o_id = order_details.o_id " + "WHERE order_details.u_id = ? "
					+ "ORDER BY orders.id DESC";
			pst = this.conn.prepareStatement(query);
			pst.setInt(1, id);
			rs = pst.executeQuery();
			while (rs.next()) {
				Order order = new Order();
				order.setOrderId(rs.getInt("o_id"));
				order.setProductId(rs.getInt("p_id"));
				order.setName(rs.getString("name"));
				order.setImage(rs.getString("image"));
				order.setCategory(rs.getString("category"));
				order.setOrderPrice(rs.getDouble("o_price"));
				order.setOrderTotal(rs.getDouble("o_price") * rs.getInt("quantity"));
				order.setQuantity(rs.getInt("quantity"));
				order.setO_date(rs.getTimestamp("o_date"));
				list.add(order);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<Order> userOrdersWithDetailsId(int o_id) {
		List<Order> list = new ArrayList<>();
		try {
			query = "SELECT * FROM orders INNER JOIN products ON orders.p_id = products.id INNER JOIN order_details ON orders.o_id = order_details.o_id WHERE orders.o_id = ? ORDER BY orders.id DESC";
			pst = this.conn.prepareStatement(query);
			pst.setInt(1, o_id);
			rs = pst.executeQuery();
			while (rs.next()) {
				Order order = new Order();
				order.setOrderId(rs.getInt("o_id"));
				order.setProductId(rs.getInt("p_id"));
				order.setName(rs.getString("name"));
				order.setImage(rs.getString("image"));
				order.setCategory(rs.getString("category"));
				order.setOrderPrice(rs.getDouble("o_price"));
				order.setOrderTotal(rs.getDouble("o_price") * rs.getInt("quantity"));
				order.setQuantity(rs.getInt("quantity"));
				order.setO_date(rs.getTimestamp("o_date"));
				list.add(order);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<OrderStatus> getOrderStatus(int o_id) {
		List<OrderStatus> order_status = new ArrayList<>();
		try {
			query = "SELECT * FROM order_status WHERE o_id = ? ORDER BY status_date DESC LIMIT 1";
			pst = this.conn.prepareStatement(query);
			pst.setInt(1, o_id);
			rs = pst.executeQuery();
			while (rs.next()) {
				OrderStatus row = new OrderStatus();
				row.setO_id(o_id);
				row.setE_id(rs.getInt("e_id"));
				row.setStatus(rs.getString("status"));
				row.setStatus_id(rs.getInt("status_id"));
				row.setStatus_date(rs.getTimestamp("status_date"));
				order_status.add(row);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return order_status;
	}

	public String getLastStatus(int o_id) {
		String status = null;
		try {
			query = "SELECT status FROM order_status WHERE o_id = ? ORDER BY status_date DESC LIMIT 1";
			pst = this.conn.prepareStatement(query);
			pst.setInt(1, o_id);
			rs = pst.executeQuery();
			if (rs.next()) {
				status = rs.getString("status");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}
	public int ordersCount() {
		int count = 0;
		try {
			query= "SELECT COUNT(*) FROM order_details";
			pst = this.conn.prepareStatement(query);
			rs = pst.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.print(e.getMessage());
		}
		return count;
	}
	public void cancelOrder(int id) {
		try {
			query = "DELETE FROM orders WHERE o_id = ?";
			pst = this.conn.prepareStatement(query);
			pst.setInt(1, id);
			pst.execute();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public int totalSales() {
		int sum = 0;
		try {
			query= "SELECT SUM(total) FROM order_details";
			pst = this.conn.prepareStatement(query);
			rs = pst.executeQuery();
			if(rs.next()) {
				sum = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.print(e.getMessage());
		}
		return sum;
	}
}
