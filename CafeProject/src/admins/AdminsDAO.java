package admins;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import boards.Board_ids;

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
	
	public int deleteTitleImg() {
		String SQL = "delete from title_image where id = 1";
		try {
			pstmt = conn.prepareStatement(SQL);

			return pstmt.executeUpdate();
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
		return -1;
	}
	
	public int deleteCafeProfileImg() {
		String SQL = "delete from cafe_profile_image where id = 1";
		try {
			pstmt = conn.prepareStatement(SQL);

			return pstmt.executeUpdate();
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
		return -1;
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
	
	public int deleteGateContent() {
		String SQL = "delete from gate_content where id = 1";
		try {
			pstmt = conn.prepareStatement(SQL);

			return pstmt.executeUpdate();
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
		return -1;
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
	
	public int chkLevelExist(){
		int count = 0;
		String sql = "select count(*) from level_name where level=1";
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
	
	public int insertLevelInfo() {
		try {
			for(int i =1; i<7; i++) {
			String SQL = "insert into level_name(level, levelName, lv_explain, boardC, commentC, visitC, activation) values("+ i +", \"\", \"\", 0, 0, 0, 0)";
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.executeUpdate();
			}
			return 1;
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}
	
	public int updateLevelInfo1(String lvName_1, String explain_1) {
		String SQL = "update level_name set levelName = ?, lv_explain = ? where level = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, lvName_1);
			pstmt.setString(2, explain_1);
			return pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;
		}
	public int updateLevelInfo2(String lvName_2, String explain_2, int board_2, int comment_2, int visit_2, int selectValue_2) {
		String SQL = "update level_name set levelName = ?, lv_explain = ?, boardC = ?, commentC = ?, visitC = ?, activation = ? where level = 2";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, lvName_2);
			pstmt.setString(2, explain_2);
			pstmt.setInt(3, board_2);
			pstmt.setInt(4, comment_2);
			pstmt.setInt(5, visit_2);
			pstmt.setInt(6, selectValue_2);
			return pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}
	public int updateLevelInfo3(String lvName_3, String explain_3, int board_3, int comment_3, int visit_3, int selectValue_3) {
		String SQL = "update level_name set levelName = ?, lv_explain = ?, boardC = ?, commentC = ?, visitC = ?, activation = ? where level = 3";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, lvName_3);
			pstmt.setString(2, explain_3);
			pstmt.setInt(3, board_3);
			pstmt.setInt(4, comment_3);
			pstmt.setInt(5, visit_3);
			pstmt.setInt(6, selectValue_3);
			return pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}
	public int updateLevelInfo4(String lvName_4, String explain_4, int board_4, int comment_4, int visit_4, int selectValue_4) {
		String SQL = "update level_name set levelName = ?, lv_explain = ?, boardC = ?, commentC = ?, visitC = ?, activation = ? where level = 4";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, lvName_4);
			pstmt.setString(2, explain_4);
			pstmt.setInt(3, board_4);
			pstmt.setInt(4, comment_4);
			pstmt.setInt(5, visit_4);
			pstmt.setInt(6, selectValue_4);
			return pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}
	public int updateLevelInfo5(String lvName_5, String explain_5, int board_5, int comment_5, int visit_5, int selectValue_5) {
		String SQL = "update level_name set levelName = ?, lv_explain = ?, boardC = ?, commentC = ?, visitC = ?, activation = ? where level = 5";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, lvName_5);
			pstmt.setString(2, explain_5);
			pstmt.setInt(3, board_5);
			pstmt.setInt(4, comment_5);
			pstmt.setInt(5, visit_5);
			pstmt.setInt(6, selectValue_5);
			return pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}
	public int updateLevelInfo6(String lvName_6, String explain_6, int board_6, int comment_6, int visit_6, int selectValue_6) {
		String SQL = "update level_name set levelName = ?, lv_explain = ?, boardC = ?, commentC = ?, visitC = ?, activation = ? where level = 6";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, lvName_6);
			pstmt.setString(2, explain_6);
			pstmt.setInt(3, board_6);
			pstmt.setInt(4, comment_6);
			pstmt.setInt(5, visit_6);
			pstmt.setInt(6, selectValue_6);
			return pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}

	public int activate(int target) {
		String SQL = "update level_name set activation = 0 where level = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, target);
			return pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<Level_name> getLevelInfo() {
		String SQL = "select * from level_name";
		ArrayList<Level_name> levelInfo = new ArrayList<Level_name>();
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Level_name level_name = new Level_name();

				level_name.setLevel(rs.getInt(1));
				level_name.setLevelName(rs.getString(2));
				level_name.setLv_explain(rs.getString(3));
				level_name.setBoardC(rs.getInt(4));
				level_name.setCommentC(rs.getInt(5));
				level_name.setVisitC(rs.getInt(6));
				level_name.setActivation(rs.getInt(7));

				levelInfo.add(level_name);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return levelInfo;
	}
}
