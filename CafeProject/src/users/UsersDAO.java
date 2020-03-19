package users;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;

public class UsersDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UsersDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/t2";
			String dbID = "root";
			String dbPassword = "";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int login(String id, String password) {
		String SQL = "select password from users where id = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if(rs.getString(1).equals(password))
					return 1; 
				else
					return 0; 
			}
			return -1; 
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -2; 
	}
	
	public int join(Users users) {
		SimpleDateFormat timeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date time = new Date();
		String currentTime = timeFormat.format(time);
		String SQL = "insert into users(id, password, nick, born, gender, "
				+ "email, phone, level, joinDate, recentVisit, writeCount, commentCount) "
				+ "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, users.getId());
			pstmt.setString(2, users.getPassword());
			pstmt.setString(3, users.getNick());
			pstmt.setString(4, users.getBorn());
			pstmt.setString(5, users.getGender());
			pstmt.setString(6, users.getEmail());
			pstmt.setString(7, users.getPhone());
			pstmt.setInt(8, 1);
			pstmt.setString(9,currentTime);
			pstmt.setString(10,currentTime);
			pstmt.setInt(11, 0);
			pstmt.setInt(12, 0);
			
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs !=null) rs.close();
				if(pstmt != null) pstmt.close();
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}
	
	public int noEmailJoin(Users users) {
		SimpleDateFormat timeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date time = new Date();
		String currentTime = timeFormat.format(time);
		String SQL = "insert into users(id, password, nick, born, gender, "
				+ " phone, level, joinDate, recentVisit, writeCount, commentCount) "
				+ "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, users.getId());
			pstmt.setString(2, users.getPassword());
			pstmt.setString(3, users.getNick());
			pstmt.setString(4, users.getBorn());
			pstmt.setString(5, users.getGender());
			pstmt.setString(6, users.getPhone());
			pstmt.setInt(7, 1);
			pstmt.setString(8,currentTime);
			pstmt.setString(9,currentTime);
			pstmt.setInt(10, 0);
			pstmt.setInt(11, 0);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs !=null) rs.close();
				if(pstmt != null) pstmt.close();
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}
	
	public String registerCheck(String m, String id) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		if(m =="checkId") {
				String SQL = "select from users where id = ?";
				try {
					pstmt = conn.prepareStatement(SQL);
					pstmt.setString(1, id);
					rs = pstmt.executeQuery();
					rs.afterLast();
					int count = rs.getRow();
					rs.beforeFirst();
					
					if(count >=1) {
						return "N";
					}
					else {
						return "Y";
					}
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					try {
						if(rs != null) rs.close();
						if(pstmt != null) pstmt.close();
					}catch(Exception e) {
						e.printStackTrace();
					}
				}
		}
		return "N";
	}
	
}