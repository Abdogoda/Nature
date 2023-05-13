package cd.abdogoda.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import cd.abdogoda.model.Cart;
import cd.abdogoda.model.Favorite;
import cd.abdogoda.model.Product;

public class ProductDao {
	private Connection conn;
	private String query;
	private PreparedStatement pst,pst2;
	private ResultSet rs;
	public ProductDao(Connection conn) {
		this.conn = conn;
	}
	public List<Product> getAllProducts() {
		List<Product> products = new ArrayList<Product>();
		try {
			query = "SELECT * FROM products";
			pst = this.conn.prepareStatement(query);
			rs = pst.executeQuery();
			while (rs.next()) {
				Product row = new Product();
				row.setId(rs.getInt("id"));
				row.setName(rs.getString("name"));
				row.setCategory(rs.getString("category"));
				row.setPrice(rs.getDouble("price"));
				row.setImage(rs.getString("image"));
				products.add(row);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return products;
	}
	public List<Product> orderAndRangeAllProducts(String order_column, int priceRange) {
		List<Product> products = new ArrayList<Product>();
		try {
			query = "SELECT * FROM products WHERE price < ? ORDER BY ?";
			pst = this.conn.prepareStatement(query);
			pst.setInt(1, priceRange);
			pst.setString(2, order_column);
			rs = pst.executeQuery();
			while (rs.next()) {
				Product row = new Product();
				row.setId(rs.getInt("id"));
				row.setName(rs.getString("name"));
				row.setCategory(rs.getString("category"));
				row.setPrice(rs.getDouble("price"));
				row.setImage(rs.getString("image"));
				products.add(row);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return products;
	}
	public List<Product> getRecentProducts() {
		List<Product> products = new ArrayList<Product>();
		try {
			query = "SELECT * FROM products ORDER BY date DESC Limit 8";
			pst = this.conn.prepareStatement(query);
			rs = pst.executeQuery();
			while (rs.next()) {
				Product row = new Product();
				row.setId(rs.getInt("id"));
				row.setName(rs.getString("name"));
				row.setCategory(rs.getString("category"));
				row.setPrice(rs.getDouble("price"));
				row.setImage(rs.getString("image"));
				products.add(row);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return products;
	}
	public List<Product> getSimillerProducts(String category) {
		List<Product> products = new ArrayList<Product>();
		try {
			query = "SELECT * FROM products WHERE category = ? LIMIT 8";
			pst = this.conn.prepareStatement(query);
			pst.setString(1, category);
			rs = pst.executeQuery();
			while (rs.next()) {
				Product row = new Product();
				row.setId(rs.getInt("id"));
				row.setName(rs.getString("name"));
				row.setCategory(rs.getString("category"));
				row.setPrice(rs.getDouble("price"));
				row.setImage(rs.getString("image"));
				products.add(row);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return products;
	}
	public List<Cart> getCartProducts(ArrayList<Cart> cartList){
		List<Cart> products = new ArrayList<Cart>();
		try {
			if(cartList.size() > 0) {
				for(Cart item:cartList) {
					query = "SELECT * FROM products WHERE id = ?";
					pst = this.conn.prepareStatement(query);
					pst.setInt(1, item.getId());
					rs = pst.executeQuery();
					while(rs.next()) {
						Cart row = new Cart();
						row.setId(rs.getInt("id"));
						row.setName(rs.getString("name"));
						row.setCategory(rs.getString("category"));
						row.setPrice(rs.getDouble("price"));
						row.setImage(rs.getString("image"));
						row.setQuantity(item.getQuantity());
						products.add(row);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return products;
	}
	public double getTotalCartPrice(ArrayList<Cart> cartList) {
		double sum = 0.0;
		try {
			if(cartList.size()>0) {
				for(Cart item:cartList) {
					query = "SELECT * FROM products WHERE id = ?";
					pst = this.conn.prepareStatement(query);
					pst.setInt(1, item.getId());
					rs = pst.executeQuery();
					while(rs.next()) {
						sum += rs.getDouble("price")*item.getQuantity();
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return sum;
	}
	public Product getProduct(int id) {
		Product row = null;
		try {
			query = "SELECT * FROM products WHERE id = ?";
			pst = this.conn.prepareStatement(query);
			pst.setInt(1, id);
			rs = pst.executeQuery();
			while (rs.next()) {
				row = new Product();
				row.setId(rs.getInt("id"));
				row.setName(rs.getString("name"));
				row.setCategory(rs.getString("category"));
				row.setPrice(rs.getDouble("price"));
				row.setImage(rs.getString("image"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return row;
	}
	public boolean addProduct(String name, String category, double price, String image) {
		boolean status = false;
		try {
			query= "SELECT * FROM products WHERE name = ?";
			pst = this.conn.prepareStatement(query);
			pst.setString(1, name);
			rs = pst.executeQuery();
			if(rs.next()) {
				status = false;
			}else {
				pst2 = this.conn.prepareStatement("INSERT INTO products (name,category,price,image) VALUES (?,?,?,?)");
				pst2.setString(1, name);
				pst2.setString(2, category);
				pst2.setDouble(3, price);;
				pst2.setString(4, image);
				pst2.executeUpdate();
				status = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.print(e.getMessage());
		}
		return status;
	}
	public boolean editProduct(int id ,String name, String category, double price, String image) {
		boolean status = false;
		try {
			query= "SELECT * FROM products WHERE id = ?";
			pst = this.conn.prepareStatement(query);
			pst.setInt(1, id);
			rs = pst.executeQuery();
			if(rs.next()) {
				String qr = "";
				if(image != null && image != "") {
					qr = ", image = ?";
				}
				pst2 = this.conn.prepareStatement("UPDATE products SET name = ? , category = ? , price = ? "+ qr +" WHERE id = ?");
				pst2.setString(1, name);
				pst2.setString(2, category);
				pst2.setDouble(3, price);
				if(image != null && image != "") {
					pst2.setString(4, image);
					pst2.setInt(5, id);
				}else {
					pst2.setInt(4, id);
				}
				pst2.executeUpdate();
				status = true;
			}else {
				status = false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.print(e.getMessage());
		}
		return status;
	}
	public boolean deleteProduct(int id) {
		boolean status = false;
		try {
			query= "SELECT * FROM products WHERE id = ?";
			pst = this.conn.prepareStatement(query);
			pst.setInt(1, id);
			rs = pst.executeQuery();
			if(rs.next()) {
				pst2 = this.conn.prepareStatement("DELETE FROM products WHERE id = ?");
				pst2.setInt(1, id);
				pst2.executeUpdate();
				status = true;
			}else {
				status = false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.print(e.getMessage());
		}
		return status;
	}
	public boolean checkIsFav(int p_id, int u_id) {
		boolean status = false;
		try {
			query= "SELECT * FROM favorite WHERE p_id = ? AND u_id = ? LIMIT 1";
			pst = this.conn.prepareStatement(query);
			pst.setInt(1, p_id);
			pst.setInt(2, u_id);
			rs = pst.executeQuery();
			if(rs.next()) {
				status = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.print(e.getMessage());
		}
		return status;
	}
	public boolean removeFromFav(int p_id, int u_id) {
		boolean status = false;
		try {
			query= "DELETE FROM favorite WHERE p_id = ? AND u_id = ?";
			pst = this.conn.prepareStatement(query);
			pst.setInt(1, p_id);
			pst.setInt(2, u_id);
			pst.executeUpdate();
			status = true;
		} catch (Exception e) {
			e.printStackTrace();
			System.out.print(e.getMessage());
		}
		return status;
	}
	public boolean addToFav(int p_id, int u_id) {
		boolean status = false;
		try {
			query= "INSERT INTO favorite (p_id,u_id) VALUES (?, ?)";
			pst = this.conn.prepareStatement(query);
			pst.setInt(1, p_id);
			pst.setInt(2, u_id);
			pst.executeUpdate();
			status = true;
		} catch (Exception e) {
			e.printStackTrace();
			System.out.print(e.getMessage());
		}
		return status;
	}
	public int getUserFavs(int u_id) {
		int count = 0;
		try {
			query= "SELECT COUNT(*) FROM favorite WHERE u_id = ?";
			pst = this.conn.prepareStatement(query);
			pst.setInt(1, u_id);
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
	public List<Favorite> getUserProductFavs(int u_id) {
		List<Favorite> favs = new ArrayList<Favorite>();
		try {
			query= "SELECT * FROM favorite WHERE u_id = ?";
			pst = this.conn.prepareStatement(query);
			pst.setInt(1, u_id);
			rs = pst.executeQuery();
			while(rs.next()) {
				Favorite fav = new Favorite();
				fav.setId(rs.getInt("id"));
				fav.setP_id(rs.getInt("p_id"));
				fav.setU_id(rs.getInt("u_id"));
				favs.add(fav);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.print(e.getMessage());
		}
		return favs;
	}

}
