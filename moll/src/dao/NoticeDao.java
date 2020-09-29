package dao;

import java.util.ArrayList;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import vo.*;
import commons.*;

public class NoticeDao {
	public Notice selectNoticeOne(Notice notice) throws Exception{
		Notice returnNotice = null;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT notice_id, notice_title, notice_content, notice_date FROM notice WHERE notice_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1, notice.getNoticeId());
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			returnNotice = new Notice();
			
			returnNotice.setNoticeId(rs.getInt("notice_id"));
			returnNotice.setNoticeTitle(rs.getString("notice_title"));
			returnNotice.setNoticeContent(rs.getString("notice_content"));
			returnNotice.setNoticeDate(rs.getString("notice_date"));
		}
		
		conn.close();
		
		return returnNotice;
	}
	
	public ArrayList<Notice> selectNoticeList() throws Exception{
		ArrayList<Notice> list = new ArrayList<Notice>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "select notice_id, notice_title from notice order by notice_date desc limit 0, 2";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		ResultSet rs = stmt.executeQuery();
		
		Notice notice = null;
		
		while(rs.next()) {
			notice = new Notice();
			
			notice.setNoticeId(rs.getInt("notice_id"));
			notice.setNoticeTitle(rs.getString("notice_title"));
			
			list.add(notice);
		}
		
		return list;	
	}
}
