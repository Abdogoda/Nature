package cd.abdogoda.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import cd.abdogoda.model.Permission;

public class PermissionDao {
	private Connection conn;
	private String query, query2;
	private PreparedStatement pst, pst2;
	private ResultSet rs;

	public PermissionDao(Connection conn) {
		this.conn = conn;
	}
	
	public boolean addPermission(String name) {
		boolean status = false;
		try {
			query = "SELECT * FROM permissions WHERE name = ? LIMIT 1";
			pst = this.conn.prepareStatement(query);
			pst.setString(1, name);
			rs = pst.executeQuery();
			if(rs.next()) {
				status = false;
			}else {
				query2 = "INSERT INTO permissions (name) VALUES (?)";
				pst2 = this.conn.prepareStatement(query2);
				pst2.setString(1, name);
				pst2.executeUpdate();
				status = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}
	
	public boolean editPermission(int id, String name) {
		boolean status = false;
		try {
			query = "SELECT * FROM permissions WHERE id = ? LIMIT 1";
			pst = this.conn.prepareStatement(query);
			pst.setInt(1, id);
			rs = pst.executeQuery();
			if(rs.next()) {
				query2 = "UPDATE permissions SET name = ? WHERE id = ?";
				pst2 = this.conn.prepareStatement(query2);
				pst2.setString(1, name);
				pst2.setInt(2, id);
				pst2.executeUpdate();
				status = true;
			}else {
				status = false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}
	
	public boolean deletePermission(int id) {
		boolean status = false;
		try {
			query = "SELECT * FROM permissions WHERE id = ? LIMIT 1";
			pst = this.conn.prepareStatement(query);
			pst.setInt(1, id);
			rs = pst.executeQuery();
			if(rs.next()) {
				query2 = "DELETE FROM permissions WHERE id = ?";
				pst2 = this.conn.prepareStatement(query2);
				pst2.setInt(1, id);
				pst2.executeUpdate();
				status = true;
			}else {
				status = false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}
	
	public List<Permission> allPermission() {
		List<Permission> permissions = new ArrayList<>();
		try {
			query = "SELECT * FROM permissions ORDER BY id DESC";
			pst = this.conn.prepareStatement(query);
			rs = pst.executeQuery();
			while(rs.next()) {
				Permission perm = new Permission();
				perm.setId(rs.getInt("id"));
				perm.setName(rs.getString("name"));
				permissions.add(perm);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return permissions;
	}

	public List<Permission> getJobPermissions(int j_id) {
		List<Permission> permissions = new ArrayList<>();
		try {
			query = "SELECT * FROM job_permissions JOIN permissions ON job_permissions.permission_id = permissions.id WHERE job_permissions.job_id = ?";
			pst = this.conn.prepareStatement(query);
			pst.setInt(1, j_id);
			rs = pst.executeQuery();
			while(rs.next()) {
				Permission perm = new Permission();
				perm.setId(rs.getInt("permission_id"));
				perm.setName(rs.getString("name"));
				permissions.add(perm);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return permissions;
	}

	public boolean removeJobPermissions(int j_id) {
		boolean status = false;
		try {
			query = "DELETE FROM job_permissions WHERE job_id = ?";
			pst = this.conn.prepareStatement(query);
			pst.setInt(1, j_id);
			pst.executeUpdate();
			status = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

}
