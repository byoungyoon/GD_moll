package commons;
import java.sql.*;

public class DBUtil {
	public Connection getConnection() throws Exception{
		String driver = "org.mariadb.jdbc.Driver";
		String addr = "jdbc:mariadb://legend-by.kro.kr:3306/mall";
		String dbid = "bur5698";
		String dbpw = "letsrember12";
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(addr, dbid, dbpw);
		
		return conn;
	}
}
