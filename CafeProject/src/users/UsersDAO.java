package users;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;
import users.Users;

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
	
	public void levelUp(String id, int levelUp){
		String sql = "update users set level = ? where id = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,levelUp);
			pstmt.setString(2,id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public int checkGap(String id){
		int timeGap = 0;
		String sql = "SELECT TIMESTAMPDIFF(MINUTE, (select recentVisit from users where id = ?), now())";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,id);
			rs = pstmt.executeQuery();
			if(rs.next()){
				timeGap = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return timeGap; // 총 레코드 수 리턴
	}
	
	public int visAndRecUpd(String id) {
		String SQL = "update users set recentVisit = now(), visitCount = visitCount + 1 where id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, id);
			return pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}
	
	public int recVisUpdate(String id) {
		String SQL = "update users set recentVisit = now() where id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, id);
			return pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}
	
	public Users getUserInfo(String id) {
			String SQL = "select visitCount, writeCount, commentCount from users where id = ?";
			try {
				Users user = new Users();
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					user.setVisitCount(rs.getInt("visitCount"));
					user.setWriteCount(rs.getInt("writeCount"));
					user.setCommentCount(rs.getInt("commentCount"));
					return user;
					
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
			return null;
	}
	
	public int writeCountUp(String id) {
		String SQL = "update users set writeCount = writeCount + 1 where id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, id);
			return pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}
	
	public int writeCountDown(int b_id) {
		String SQL = "update users set writeCount = writeCount - 1 where id = (select user_id from boards where id = ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, b_id);
			return pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}
	
	public int commentCountUp(String id) {
		String SQL = "update users set commentCount = commentCount + 1 where id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, id);
			return pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}
	
	public int commentCountDown(int reply_num) {
		String SQL = "update users set commentCount = commentCount - 1 where id = (select user_id from reply where num = ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, reply_num);
			return pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;
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
	
	public int getLevel(String id) {
		int level;
		String SQL = "select level from users where id = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				level = rs.getInt(1);
				
				return level;
			}
			return -1; 
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
		return -2; 
	}
	
	public int join(Users users) {
		SimpleDateFormat timeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date time = new Date();
		String currentTime = timeFormat.format(time);
		String SQL = "insert into users(id, password, nick, born, gender, "
				+ "email, phone, level, joinDate, recentVisit, visitCount, writeCount, commentCount) "
				+ "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0, ?, ?)";
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
				+ " phone, level, joinDate, recentVisit, visitCount, writeCount, commentCount) "
				+ "values(?, ?, ?, ?, ?, ?, ?, ?, ?, 0, ?, ?)";
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
	
	public String getNick(String id) {
			
			String nick = null;
			String SQL = "select nick from users where id = ?";
			try {
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				while(rs.next()) {
				nick = rs.getString("nick");
				}
				return nick;
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
			return nick;
	}

	
}