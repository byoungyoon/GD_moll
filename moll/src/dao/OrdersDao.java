package dao;

import java.sql.*;
import java.util.ArrayList;

import vo.*;
import commons.*;

public class OrdersDao {
	// 물품 구매하기
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
	
	// 마이 페이지에서 구매한 목록 보기
	public ArrayList<OrdersAndProduct> selectOrdersList(OrdersAndProduct oap) throws Exception{
		ArrayList<OrdersAndProduct> list = new ArrayList<OrdersAndProduct>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		/*
		 * SELECT
		 * p.product_name, o.orders_amount, o.orders_price, o.orders_addr, o.orders_state, o.orders_date
		 * FROM
		 * orders o INNER JOIN product p
		 * ON
		 * o.product_id = p.product_id
		 * WHERE
		 * o.member_email = ?
		 */
		
		String sql = "SELECT p.product_name, o.orders_amount, o.orders_price, o.orders_addr, o.orders_state, o.orders_date FROM orders o INNER JOIN product p ON o.product_id = p.product_id WHERE o.member_email = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, oap.orders.getMemberEmail());
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			OrdersAndProduct paramOap = new OrdersAndProduct();
			paramOap.product = new Product();
			paramOap.orders = new Orders();
			
			paramOap.product.setProductName(rs.getString("p.product_name"));
			paramOap.orders.setOrdersAmount(rs.getInt("o.orders_amount"));
			paramOap.orders.setOrdersPrice(rs.getInt("o.orders_price"));
			paramOap.orders.setOrdersAddr(rs.getString("o.orders_addr"));
			paramOap.orders.setOrdersState(rs.getString("o.orders_state"));
			paramOap.orders.setOrdersDate(rs.getString("o.orders_date"));
			
			list.add(paramOap);
		}
		
		conn.close();
		
		return list;
	}
}




















