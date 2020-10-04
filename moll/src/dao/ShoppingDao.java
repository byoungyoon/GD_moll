package dao;

import java.sql.*;
import java.util.ArrayList;

import vo.*;
import commons.*;

public class ShoppingDao {
	// shopping 테이블에 데이터 추가
	public void insertShopping(Shopping shopping) throws Exception{
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		/*
		 * INSERT INTO
		 * shopping(member_email, product_id)
		 * VALUES
		 * (?,?)
		 */
		
		String sql = "INSERT INTO shopping(member_email, product_id) VALUES (?,?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, shopping.getMemberEmail());
		stmt.setInt(2, shopping.getProductId());
		
		stmt.executeLargeUpdate();
		
		conn.close();
	}
	
	public ArrayList<Shopping> selectShoppingList(Shopping shopping) throws Exception{
		ArrayList<Shopping> list = new ArrayList<Shopping>();
		
		return list;
	}
}
