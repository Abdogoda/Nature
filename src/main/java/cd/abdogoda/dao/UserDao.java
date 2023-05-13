package cd.abdogoda.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import cd.abdogoda.model.Employee;
import cd.abdogoda.model.User;

public class UserDao {
	private Connection conn;
	private String query,query2,query3,query4;
	private PreparedStatement pst,pst2,pst3,pst4;
	private ResultSet rs,rs2,rs3,rs4;
	public UserDao(Connection conn) {
		this.conn = conn;
	}
	public User userLogin(String email, String password) {
		User user = null;
		try {
			query= "SELECT * FROM users WHERE email = ? AND password = ?";
			pst = this.conn.prepareStatement(query);
			pst.setString(1, email);
			pst.setString(2, password);
			rs = pst.executeQuery();
			if(rs.next()) {
				user = new User();
				user.setId(rs.getInt("id"));
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("email"));
				user.setPhone(rs.getString("phone"));
				user.setImage(rs.getString("image"));
				user.setImage(rs.getString("image"));
				user.setGroup_id(rs.getInt("group_id"));
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.print(e.getMessage());
		}
		return user;
	}
	public boolean addUser(String name, String email, String phone, String address, String password, String image, int group_id) {
		boolean status = false;
		try {
			query= "SELECT * FROM users WHERE email = ?";
			pst = this.conn.prepareStatement(query);
			pst.setString(1, email);
			rs = pst.executeQuery();
			if(rs.next()) {
				status = false;
			}else {
				pst2 = this.conn.prepareStatement("INSERT INTO users (name,email,phone,address,password,group_id,image) VALUES (?,?,?,?,?,?,?)");
				pst2.setString(1, name);
				pst2.setString(2, email);
				pst2.setString(3, phone);
				pst2.setString(4, address);
				pst2.setString(5, password);
				pst2.setInt(6, group_id);
				pst2.setString(7, image);
				pst2.executeUpdate();
				status = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.print(e.getMessage());
		}
		return status;
	}
	public boolean addAdmin(int e_id, String ssn, String birth_date, int gender, int job_id) {
		boolean status = false;
		try {
			query= "SELECT * FROM employees WHERE employee_id = ?";
			pst = this.conn.prepareStatement(query);
			pst.setInt(1, e_id);
			rs = pst.executeQuery();
			if(rs.next()) {
				status = false;
			}else {
				query4 = "INSERT INTO employees (employee_id,birth_date,gender,ssn,job_id) VALUES (?,?,?,?,?)";
				pst4 = this.conn.prepareStatement(query4);
				pst4.setInt(1, e_id);
				pst4.setString(2, birth_date);
				pst4.setInt(3, gender);
				pst4.setString(4, ssn);
				pst4.setInt(5, job_id);
				pst4.executeUpdate();
				status = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.print(e.getMessage());
		}
		return status;
	}
	public List<User> getAllUsers() {
		List<User> users = new ArrayList<User>();
		try {
			query = "SELECT * FROM users ORDER BY id DESC";
			pst = this.conn.prepareStatement(query);
			rs = pst.executeQuery();
			while (rs.next()) {
				User row = new User();
				row.setId(rs.getInt("id"));
				row.setName(rs.getString("name"));
				row.setEmail(rs.getString("email"));
				row.setPhone(rs.getString("phone"));
				row.setGroup_id(rs.getInt("group_id"));
				row.setImage(rs.getString("image"));
				users.add(row);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return users;
	}
	public User getUser(int id) {
		User row = null;
		try {
			query = "SELECT * FROM users WHERE id = ?";
			pst = this.conn.prepareStatement(query);
			pst.setInt(1, id);
			rs = pst.executeQuery();
			while (rs.next()) {
				row = new User();
				row.setId(rs.getInt("id"));
				row.setName(rs.getString("name"));
				row.setEmail(rs.getString("email"));
				row.setPhone(rs.getString("phone"));
				row.setAddress(rs.getString("address"));
				row.setGroup_id(rs.getInt("group_id"));
				row.setImage(rs.getString("image"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return row;
	}
	public Employee getEmployee(int id) {
		Employee row = null;
		try {
			query = "SELECT * FROM employees WHERE employee_id = ?";
			pst = this.conn.prepareStatement(query);
			pst.setInt(1, id);
			rs = pst.executeQuery();
			while (rs.next()) {
				row = new Employee();
				row.setEmployee_id(rs.getInt("employee_id"));
				row.setBirth_date(rs.getDate("birth_date"));
				row.setGender(rs.getInt("gender"));
				row.setSsn(rs.getString("ssn"));
				row.setJob_id(rs.getInt("job_id"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return row;
	}
	public boolean editUser(int id ,String name, String email, String phone, String image) {
		boolean status = false;
		try {
			query= "SELECT * FROM users WHERE email = ? AND id <> ?";
			pst = this.conn.prepareStatement(query);
			pst.setString(1, email);
			pst.setInt(2, id);
			rs = pst.executeQuery();
			if(rs.next()) {
				status = false;
			}else {
				String qr = "";
				if(image != null && image != "") {
					qr = ", image = ?";
				}
				pst2 = this.conn.prepareStatement("UPDATE users SET name = ? , email = ? , phone = ? "+ qr +" WHERE id = ?");
				pst2.setString(1, name);
				pst2.setString(2, email);
				pst2.setString(3, phone);
				if(image != null && image != "") {
					pst2.setString(4, image);
					pst2.setInt(5, id);
				}else {
					pst2.setInt(4, id);
				}
				pst2.executeUpdate();
				status = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.print(e.getMessage());
		}
		return status;
	}
	public int usersCount(int group_id) {
		int count = 0;
		try {
			query= "SELECT COUNT(*) FROM users WHERE group_id = ?";
			pst = this.conn.prepareStatement(query);
			pst.setInt(1, group_id);
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
}
