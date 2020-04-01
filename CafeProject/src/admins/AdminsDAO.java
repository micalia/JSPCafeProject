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
}
