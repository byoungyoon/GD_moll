package dao;

import java.util.ArrayList;

import commons.DBUtil;

import java.sql.*;
import vo.*;

public class CategoryDao {
	// ī�װ� ���̵� �޾Ƽ� �̸����� ���
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
	
	//ī�װ� ��ü���� ����ϴ� �޼���
	public int categoryCount() throws Exception{
		int returnCount = 0;
		
		// �����ͺ��̽� ����
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
	
	// �� Category ���
	public ArrayList<Category> selectCategoryList(int currentPage) throws Exception{
		//	�����ͺ��̽��� ���� ResultSet ���� �ƴ� �迭�� ������ �����ϱ� ���� ����
		ArrayList<Category> list = new ArrayList<Category>();
		
		String sql = "SELECT category_id, category_name FROM category Limit ?, 5";
		
		// �����ͺ��̽� ����
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
	
	// �� Category ���
	public ArrayList<Category> selectCategoryList2() throws Exception{
		//	�����ͺ��̽��� ���� ResultSet ���� �ƴ� �迭�� ������ �����ϱ� ���� ����
		ArrayList<Category> list = new ArrayList<Category>();
		
		String sql = "SELECT category_id, category_name FROM category";
		
		// �����ͺ��̽� ����
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
	
		// Category ��õ ���
		public ArrayList<Category> selectCategoryCkList() throws Exception{
			//	�����ͺ��̽��� ���� ResultSet ���� �ƴ� �迭�� ������ �����ϱ� ���� ����
			ArrayList<Category> list = new ArrayList<Category>();
			
			String sql = "SELECT category_id, category_name, category_pic FROM category WHERE category_ck='Y' LIMIT 0, 4";
			
			// �����ͺ��̽� ����
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































