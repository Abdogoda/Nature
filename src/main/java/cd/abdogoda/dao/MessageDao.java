package cd.abdogoda.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import cd.abdogoda.model.Message;

public class MessageDao {
	private Connection conn;
	private String query,query2;
	private PreparedStatement pst,pst2;
	private ResultSet rs,rs2;
	public MessageDao(Connection conn) {
		this.conn = conn;
	}
	public boolean addMessage(String name, String email, String phone, String message) {
		boolean status = false;
		try {
			query= "SELECT * FROM messages WHERE u_name = ? AND u_email = ? AND u_phone = ? AND message = ?";
			pst = this.conn.prepareStatement(query);
			pst.setString(1, name);
			pst.setString(2, email);
			pst.setString(3, phone);
			pst.setString(4, message);
			rs = pst.executeQuery();
			if(rs.next()) {
				status = false;
			}else {
				pst2 = this.conn.prepareStatement("INSERT INTO messages (u_name,u_email,u_phone,message) VALUES (?,?,?,?)");
				pst2.setString(1, name);
				pst2.setString(2, email);
				pst2.setString(3, phone);;
				pst2.setString(4, message);
				pst2.executeUpdate();
				status = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.print(e.getMessage());
		}
		return status;
	}
	public int getMessagesCount() {
		int count = 0;
		try {
			query= "SELECT COUNT(*) FROM messages WHERE isRead = 0";
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
	public List<Message> getAllMessages(){
		List<Message> messages = new ArrayList<>();
		try {
			query= "SELECT * FROM messages ORDER BY date DESC";
			pst = this.conn.prepareStatement(query);
			rs = pst.executeQuery();
			while(rs.next()) {
				Message m = new Message();
				m.setId(rs.getInt("id"));
				m.setName(rs.getString("u_name"));
				m.setEmail(rs.getString("u_email"));
				m.setPhone(rs.getString("u_phone"));
				m.setMessage(rs.getString("message"));
				m.setIsRead(rs.getBoolean("isRead"));
				m.setDate(rs.getTimestamp("date"));
				messages.add(m);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return messages;
	}
	public boolean markAllAsMessages(){
		boolean status = false;
		try {
			query= "UPDATE messages SET isRead = 1";
			pst = this.conn.prepareStatement(query);
			pst.executeUpdate();
			status = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}
	public boolean removeMessages(int m_id){
		boolean status = false;
		try {
			query2 = "SELECT * FROM messages WHERE id = ? LIMIT 1";
			pst2 = this.conn.prepareStatement(query2);
			pst2.setInt(1, m_id);
			rs2 = pst2.executeQuery();
			if(rs2.next()) {
				query= "DELETE FROM messages WHERE id = ?";
				pst = this.conn.prepareStatement(query);
				pst.setInt(1, m_id);
				pst.executeUpdate();
				status = true;
			}else {
				status = false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}
}
