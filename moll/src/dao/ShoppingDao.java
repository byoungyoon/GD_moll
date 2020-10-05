package dao;

import java.sql.*;
import java.util.ArrayList;

import vo.*;
import commons.*;

public class ShoppingDao {
	// ��񱸴Ͽ� ��ǰ�� �ִ��� Ȯ���Ͽ� ��ư ��Ȱ��ȭ �뵵
	public boolean shoppingCk(Shopping shopping) throws Exception{
		boolean returnBoolean = false;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		/*
		 * SELECT
		 * shopping_id
		 * FROM
		 * shopping
		 * WHERE
		 * product_id = ? and member_email= ?
		 */
		
		String sql = "SELECT shopping_id FROM shopping WHERE product_id = ? and member_email= ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1, shopping.getProductId());
		stmt.setString(2, shopping.getMemberEmail());
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			returnBoolean = true;
		}
		
		return returnBoolean;
	}
	
	// ��ٱ��Ͽ� �ִ� ������ ������ ��� �����ϴ� �뵵
	public void deleteShoppingToProduct(Shopping shopping) throws Exception{
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		/*
		 * DELETE FROM
		 * shopping
		 * WHERE
		 * product_id = ? and member_email= ?
		 */
		
		String sql = "DELETE FROM shopping WHERE product_id = ? and member_email= ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1, shopping.getProductId());
		stmt.setString(2, shopping.getMemberEmail());
		
		stmt.executeLargeUpdate();
		
		conn.close();
	}
	
	// shopping ���̺� ����
	public void deleteShopping(Shopping shopping) throws Exception{
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		/*
		 * DELETE FROM
		 * shopping
		 * WHERE
		 * shopping_id = ?
		 */
		
		String sql = "DELETE FROM shopping WHERE shopping_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1, shopping.getShoppingId());
		
		stmt.executeLargeUpdate();
		
		conn.close();
	}
	
	// shopping ���̺� ������ �߰�
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
	
	// ����� ���� �� ��ٱ��ϸ� ���
	public ArrayList<ShoppingAndProduct> selectShoppingList(ShoppingAndProduct sap) throws Exception{
		ArrayList<ShoppingAndProduct> list = new ArrayList<ShoppingAndProduct>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		/*
		 * SELECT
		 * s.shopping_id, p.product_id, p.product_name, p.product_price, p.product_pic
		 * FROM
		 * product p INNER JOIN shopping s
		 * ON
		 * p.product_id = s.product_id
		 * WHERE
		 * s.member_email = ?
		 */
		
		String sql = "SELECT s.shopping_id, p.product_id, p.product_name, p.product_price, p.product_pic FROM product p INNER JOIN shopping s ON p.product_id = s.product_id WHERE s.member_email = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, sap.shopping.getMemberEmail());
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			ShoppingAndProduct paramSap = new ShoppingAndProduct();
			paramSap.product = new Product();
			paramSap.shopping = new Shopping();
			
			paramSap.shopping.setShoppingId(rs.getInt("shopping_id"));
			paramSap.shopping.setProductId(rs.getInt("p.product_id"));
			paramSap.product.setProductName(rs.getString("p.product_name"));
			paramSap.product.setProductPrice(rs.getInt("p.product_price"));
			paramSap.product.setProductPic(rs.getString("p.product_pic"));
			
			list.add(paramSap);
		}
		
		conn.close();
		
		return list;
	}
}







