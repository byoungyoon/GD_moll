package dao;

import java.util.ArrayList;

import commons.DBUtil;

import java.sql.*;
import vo.*;

public class ProductDao {	
	// prouduct 데이터베이스를 다 출력
	public ArrayList<Product> selectProductList() throws Exception{
		ArrayList<Product> list = new ArrayList<Product>();
		
		// 데이터베이스를 메소드로 호출(Connection을 출력값으로 받음)
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		/*
		 * SELECT
		 * product_id, category_id, product_name, product_price
		 * FROM
		 * product
		 * LIMIT 
		 * 0, 9
		 * */
		
		String sql = "SELECT product_id, category_id, product_name, product_price FROM product LIMIT 0, 6";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Product product = new Product();
			product.setProductId(rs.getInt("product_id"));
			product.setProductName(rs.getString("product_name"));
			product.setProductPrice(rs.getInt("product_price"));
			product.setCategoryId(rs.getInt("category_id"));
			
			list.add(product);
		}
		
		conn.close();
		
		return list;
	}
	
	// product 데이터베이스에서 선택한 것만 출력
	public ArrayList<Product> selectProductName(int categoryId) throws Exception{
		ArrayList<Product> list = new ArrayList<Product>();
		
		// 데이터베이스를 메소드로 호출(Connection을 출력값으로 받음)
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		/*
		 * SELECT
		 * product_id, category_id, product_name, product_price
		 * FROM
		 * product
		 * WHERE 
		 * category_id=?
		 * LIMIT 
		 * 0, 6
		 */
		
		String sql = "SELECT product_id, category_id, product_name, product_price FROM product WHERE category_id=? LIMIT 0, 6";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1, categoryId);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Product product = new Product();
			product.setProductId(rs.getInt("product_id"));
			product.setProductName(rs.getString("product_name"));
			product.setProductPrice(rs.getInt("product_price"));
			product.setCategoryId(rs.getInt("category_id"));
			
			list.add(product);
		}
		
		conn.close();
		
		return list;
	}
	
	public Product selectProductOne(Product product) throws Exception {
		Product returnProduct = null;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		/*
		 * SELECT
		 * product_name, product_price, product_content, product_soldout, product_pic
		 * FROM
		 * product
		 * WHERE
		 * product_id=?
		 */
		
		String sql = "SELECT product_name, product_price, product_content, product_soldout, product_pic FROM product WHERE product_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1, product.getProductId());
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			returnProduct = new Product();
			
			returnProduct.setProductName(rs.getString("product_name"));
			returnProduct.setProductPrice(rs.getInt("product_price"));
			returnProduct.setProductContent(rs.getString("product_content"));
			returnProduct.setProductSoldout(rs.getString("product_Soldout"));
			returnProduct.setProductPic(rs.getString("product_pic"));
		}
		
		return returnProduct;
	}
}