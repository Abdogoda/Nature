package cd.abdogoda.model;

public class Favorite{
	private int p_id;
	private int id;
	private int u_id;
	public int getP_id() {
		return p_id;
	}
	public void setP_id(int p_id) {
		this.p_id = p_id;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getU_id() {
		return u_id;
	}
	public void setU_id(int u_id) {
		this.u_id = u_id;
	}
	public Favorite(int p_id, int id, int u_id) {
		this.p_id = p_id;
		this.id = id;
		this.u_id = u_id;
	}
	public Favorite() {}


	
}
