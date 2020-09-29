package dao;

import java.sql.*;

import vo.*;
import commons.*;

public class MemberDao {
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
}