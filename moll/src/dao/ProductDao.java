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
		
		String sql = "SELECT product_id, category_id, product_name, product_price, product_pic FROM product LIMIT 0, 6";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Product product = new Product();
			product.setProductId(rs.getInt("product_id"));
			product.setProductName(rs.getString("product_name"));
			product.setProductPrice(rs.getInt("product_price"));
			product.setCategoryId(rs.getInt("category_id"));
			product.setProductPic(rs.getString("product_pic"));
			
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
		
		String sql = "SELECT product_id, category_id, product_name, product_price, product_pic FROM product WHERE category_id=? LIMIT 0, 6";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1, categoryId);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Product product = new Product();
			product.setProductId(rs.getInt("product_id"));
			product.setProductName(rs.getString("product_name"));
			product.setProductPrice(rs.getInt("product_price"));
			product.setCategoryId(rs.getInt("category_id"));
			product.setProductPic(rs.getString("product_pic"));
			
			list.add(product);
		}
		
		conn.close();
		
		return list;
	}
	
	// 제품별 전체보기에서 페이징을 위한 메서드
	public ArrayList<Product> selectProductNamePaging(Product product) throws Exception{
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
		 * ?, 9
		 */
			
		String sql = "SELECT product_id, category_id, product_name, product_price, product_pic FROM product WHERE category_id=? LIMIT ?, 9";
		PreparedStatement stmt = conn.prepareStatement(sql);
			
		stmt.setInt(1, product.getCategoryId());
		product.setCurrentPage(product.getCurrentPage() * 9);
		stmt.setInt(2, product.getCurrentPage());
			
		ResultSet rs = stmt.executeQuery();
			
		while(rs.next()) {
			Product paramProduct = new Product();
			paramProduct.setProductId(rs.getInt("product_id"));
			paramProduct.setProductName(rs.getString("product_name"));
			paramProduct.setProductPrice(rs.getInt("product_price"));
			paramProduct.setCategoryId(rs.getInt("category_id"));
			paramProduct.setProductPic(rs.getString("product_pic"));
			
			list.add(paramProduct);
		}
			
		conn.close();
		
		return list;
	}
	
	// 제품별 전체 품목 개수를 구하는 메서드
	public int selectProductNameCount(Product product) throws Exception{
		int lastPage = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT COUNT(*) cot FROM product WHERE category_Id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1, product.getCategoryId());
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			lastPage = rs.getInt("cot");
		}
		
		conn.close();
		
		return lastPage;
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