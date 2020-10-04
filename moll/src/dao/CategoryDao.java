package dao;

import java.util.ArrayList;

import commons.DBUtil;

import java.sql.*;
import vo.*;

public class CategoryDao {
	// 카테고리 아이디를 받아서 이름으로 출력
	public Category selectCategoryName(Category category) throws Exception{
		Category returnCategory = null;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT category_name FROM category WHERE category_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, category.getCategoryId());	
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			returnCategory = new Category();
			
			returnCategory.setCategoryName(rs.getString("category_name"));
		}
		
		conn.close();
		
		return returnCategory;
	}
	
	//카테고리 전체수를 계산하는 메서드
	public int categoryCount() throws Exception{
		int returnCount = 0;
		
		// 데이터베이스 선언
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT COUNT(*) cot FROM category";
		PreparedStatement stmt = conn.prepareStatement(sql);
			
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			returnCount = rs.getInt("cot");
		}
		
		return returnCount;
	}
	
	// 위 Category 목록
	public ArrayList<Category> selectCategoryList(int currentPage) throws Exception{
		//	데이터베이스의 값을 ResultSet 값이 아닌 배열의 값으로 저장하기 위한 변수
		ArrayList<Category> list = new ArrayList<Category>();
		
		String sql = "SELECT category_id, category_name FROM category Limit ?, 5";
		
		// 데이터베이스 선언
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1, currentPage);
	
		ResultSet rs = stmt.executeQuery();
		
		
		while(rs.next()) {
			Category category = new Category();
			category.setCategoryId(rs.getInt("category_id"));
			category.setCategoryName(rs.getString("category_name"));
				
			list.add(category);
		}
			
		conn.close();
		
		return list;
	}
	
	// 위 Category 목록
	public ArrayList<Category> selectCategoryList2() throws Exception{
		//	데이터베이스의 값을 ResultSet 값이 아닌 배열의 값으로 저장하기 위한 변수
		ArrayList<Category> list = new ArrayList<Category>();
		
		String sql = "SELECT category_id, category_name FROM category";
		
		// 데이터베이스 선언
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		PreparedStatement stmt = conn.prepareStatement(sql);
	
		ResultSet rs = stmt.executeQuery();
		
		
		while(rs.next()) {
			Category category = new Category();
			category.setCategoryId(rs.getInt("category_id"));
			category.setCategoryName(rs.getString("category_name"));
				
			list.add(category);
		}
			
		conn.close();
		
		return list;
	}
	
		// Category 추천 목록
		public ArrayList<Category> selectCategoryCkList() throws Exception{
			//	데이터베이스의 값을 ResultSet 값이 아닌 배열의 값으로 저장하기 위한 변수
			ArrayList<Category> list = new ArrayList<Category>();
			
			String sql = "SELECT category_id, category_name, category_pic FROM category WHERE category_ck='Y' LIMIT 0, 4";
			
			// 데이터베이스 선언
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			
			PreparedStatement stmt = conn.prepareStatement(sql);
		
			ResultSet rs = stmt.executeQuery();
			
			
			while(rs.next()) {
				Category category = new Category();
				category.setCategoryId(rs.getInt("category_id"));
				category.setCategoryName(rs.getString("category_name"));
				category.setCategoryPic(rs.getString("category_pic"));
					
				list.add(category);
			}
				
			conn.close();
			
			return list;
		}
}































