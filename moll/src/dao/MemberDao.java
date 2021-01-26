package dao;

import java.sql.*;

import vo.*;
import commons.*;

public class MemberDao {
	public int selectMemberLogin(Member member) throws Exception{
		int memberCk = 0;
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT COUNT(*) FROM member WHERE member_email = ? and member_pw = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, member.getMemberEamil());
		stmt.setString(2, member.getMemberPw());
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			memberCk = rs.getInt("COUNT(*)");
		}
		
		stmt.close();
		rs.close();
		
		return memberCk;
	}
	
	// ����ڰ� �α��� �Ͽ��� ��� Email�� ������ �ƴ� �̸����� ���̱� ���� �޼���
	public Member selectMemberName(Member member) throws Exception{
		Member returnMember = null;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT member_name FROM member WHERE member_email = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, member.getMemberEamil());
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			returnMember = new Member();
			
			returnMember.setMemberName(rs.getString("member_name"));
		}
		
		return returnMember;
	}
	
	// ����ڰ� ������������ ������ ��� ���̴� �Ż�����
	public Member selectMemberOne(Member member) throws Exception{
		Member returnMember = null;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT member_email, member_name, member_date FROM member WHERE member_email = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setString(1,member.getMemberEamil());
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			returnMember = new Member();
			
			returnMember.setMemberName(rs.getString("member_name"));
			returnMember.setMemberEamil(rs.getString("member_email"));
			returnMember.setMemberDate(rs.getString("member_date"));
		}
		
		conn.close();
		
		return returnMember;
	}
}