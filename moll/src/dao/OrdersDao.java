package dao;

import java.sql.*;

import vo.*;
import commons.*;

public class OrdersDao {
	public void selectOrdersOne(Orders orders) throws Exception{		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		/*
		 * INSERT INTO
		 * orders(product_id, orders_amount, orders_price, member_email, orders_addr, orders_state, orders_date
		 * VALUES
		 * (?,?,?,?,?,?,NOW())
		 */
		
		String sql = "INSERT INTO orders(product_id, orders_amount, orders_price, member_email, orders_addr, orders_state, orders_date) VALUES (?,?,?,?,?,?,NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1, orders.getProductId());
		stmt.setInt(2, orders.getOrdersAmount());
		stmt.setInt(3, orders.getOrdersPrice());
		stmt.setString(4, orders.getMemberEmail());
		stmt.setString(5, orders.getOrdersAddr());
		stmt.setString(6, "결제완료");
		
		stmt.executeUpdate();
	}
}
