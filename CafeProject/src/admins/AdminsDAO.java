package admins;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AdminsDAO {

		private Connection conn;
		private PreparedStatement pstmt;
		private ResultSet rs;

		public AdminsDAO() {
			try {
				String dbURL = "jdbc:mysql://localhost:3306/t2";
				String dbID = "root";
				String dbPassword = "";
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		public int titleImageInsert(String title_image) {
			String SQL = "insert into title_image(id, title_image) values(1, ?)";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, title_image);
				return pstmt.executeUpdate();
			}catch(Exception e){
				e.printStackTrace();
			}
			return -1;
		}
		
	public int titleImageUpdate(String title_image) {
		String SQL = "update title_image set title_image = ? where id = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, title_image);
			return pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}

	public int gateContentInsert(String gateContent) {
		String SQL = "insert into gate_content(id, gateContent) values(1, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, gateContent);
			return pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}
	
public int gateContentUpdate(String gateContent) {
	String SQL = "update gate_content set gateContent = ? where id = 1";
	try {
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		pstmt.setString(1, gateContent);
		return pstmt.executeUpdate();
	}catch(Exception e){
		e.printStackTrace();
	}
	return -1;
}

public int cafeProfileImgInsert(String imgData) {
	String SQL = "insert into cafe_profile_image(id, cafeProfileImage) values(1, ?)";
	try {
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		pstmt.setString(1, imgData);
		return pstmt.executeUpdate();
	}catch(Exception e){
		e.printStackTrace();
	}
	return -1;
}

public int cafeProfileImgUpdate(String imgData) {
String SQL = "update cafe_profile_image set cafeProfileImage = ? where id = 1";
try {
	PreparedStatement pstmt = conn.prepareStatement(SQL);
	pstmt.setString(1, imgData);
	return pstmt.executeUpdate();
}catch(Exception e){
	e.printStackTrace();
}
return -1;
}

	public String getTitleImg() {
		try {
			String SQL = "select title_image from title_image where id = 1";
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String admins = rs.getString(1);
				
				return admins;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public String getCafeProfileImg() {
		try {
			String SQL = "select cafeProfileImage from cafe_profile_image where id = 1";
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String admins = rs.getString(1);
				
				return admins;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public String getGateContent() {
		try {
			String SQL = "select gateContent from gate_content where id = 1";
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String admins = rs.getString(1);
				
				return admins;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int getCount(){
		int count = 0;
		String sql = "select count(*) from title_image where id=1";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				count = rs.getInt(1);
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
		return count; // 총 레코드 수 리턴
	}
	
	public int getGateCount(){
		int count = 0;
		String sql = "select count(*) from gate_content where id=1";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				count = rs.getInt(1);
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
		return count; // 총 레코드 수 리턴
	}

	public int getCafeProfileImgCount(){
		int count = 0;
		String sql = "select count(*) from cafe_profile_image where id=1";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				count = rs.getInt(1);
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
		return count; // 총 레코드 수 리턴
	}
}
