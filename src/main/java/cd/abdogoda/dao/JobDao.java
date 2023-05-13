package cd.abdogoda.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import cd.abdogoda.model.Job;

public class JobDao {
	private Connection conn;
	private String query,query2;
	private PreparedStatement pst, pst2;
	private ResultSet rs;

	public JobDao(Connection conn) {
		this.conn = conn;
	}
	
	public boolean addJob(String title) {
		boolean status = false;
		try {
			query = "SELECT * FROM jobs WHERE title = ? LIMIT 1";
			pst = this.conn.prepareStatement(query);
			pst.setString(1, title);
			rs = pst.executeQuery();
			if(rs.next()) {
				status = false;
			}else {
				query2 = "INSERT INTO jobs (title) VALUES (?)";
				pst2 = this.conn.prepareStatement(query2);
				pst2.setString(1, title);
				pst2.executeUpdate();
				status = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}
	
	public boolean addJobPermission(int j_id, int p_id) {
		boolean status = false;
		try {
			query = "SELECT * FROM job_permissions WHERE job_id = ? AND permission_id = ? LIMIT 1";
			pst = this.conn.prepareStatement(query);
			pst.setInt(1, j_id);
			pst.setInt(2, p_id);
			rs = pst.executeQuery();
			if(rs.next()) {
				status = false;
			}else {
				query2 = "INSERT INTO job_permissions (job_id, permission_id) VALUES (?, ?)";
				pst2 = this.conn.prepareStatement(query2);
				pst2.setInt(1, j_id);
				pst2.setInt(2, p_id);
				pst2.executeUpdate();
				status = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}
	
	public boolean editJob(int id, String title) {
		boolean status = false;
		try {
			query = "SELECT * FROM jobs WHERE id = ? LIMIT 1";
			pst = this.conn.prepareStatement(query);
			pst.setInt(1, id);
			rs = pst.executeQuery();
			if(rs.next()) {
				query2 = "UPDATE jobs SET title = ? WHERE id = ?";
				pst2 = this.conn.prepareStatement(query2);
				pst2.setString(1, title);
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
	
	public boolean deleteJob(int id) {
		boolean status = false;
		try {
			query = "SELECT * FROM jobs WHERE id = ? LIMIT 1";
			pst = this.conn.prepareStatement(query);
			pst.setInt(1, id);
			rs = pst.executeQuery();
			if(rs.next()) {
				query2 = "DELETE FROM jobs WHERE id = ?";
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
	
	public List<Job> allJobs() {
		List<Job> jobs = new ArrayList<>();
		try {
			query = "SELECT * FROM jobs ORDER BY id DESC";
			pst = this.conn.prepareStatement(query);
			rs = pst.executeQuery();
			while(rs.next()) {
				Job job = new Job();
				job.setId(rs.getInt("id"));
				job.setTitle(rs.getString("title"));
				jobs.add(job);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return jobs;
	}
	
	public Job getJob(int id) {
		Job job = null;
		try {
			query = "SELECT * FROM jobs WHERE id = ? LIMIT 1";
			pst = this.conn.prepareStatement(query);
			pst.setInt(1, id);
			rs = pst.executeQuery();
			if(rs.next()) {
				job = new Job();
				job.setId(id);
				job.setTitle(rs.getString("title"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return job;
	}
	public Job getJobByTitle(String title) {
		Job job = null;
		try {
			query = "SELECT * FROM jobs WHERE title = ? LIMIT 1";
			pst = this.conn.prepareStatement(query);
			pst.setString(1, title);
			rs = pst.executeQuery();
			if(rs.next()) {
				job = new Job();
				job.setId(rs.getInt("id"));
				job.setTitle(rs.getString("title"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return job;
	}
}
