package boards;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.io.PrintWriter;

public class BoardsDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public BoardsDAO() {
		try {
			String dbURL="jdbc:mysql://localhost:3306/t2";
			String dbID="root";
			String dbPassword="";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getDate() {
		String SQL = "select now()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	
	public int getNext() {
		String SQL = "select id from boards order by id desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1; //첫번째 게시물인 경우
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;//데이터베이스오류
	}
	
	public String getBoardName(int board_id) {
		String SQL = "select boardName from board_ids where board_id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, board_id);
			rs = pstmt.executeQuery();
				if(rs.next()) {
					String board_ids = rs.getString(1);
					return board_ids;
				}
			}catch(Exception e){
				e.printStackTrace();
			}
			return null;
	}
	public int write(int boardNum, int board_id, String nick, String id, String subject, String content) {
		String SQL = "insert into boards (id, board_id, boardName, nick, user_id, subject, content, uploadDate, hit, likeCount) "
				+ "values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			pstmt.setInt(1, boardNum);
			pstmt.setInt(2, board_id);	
			pstmt.setString(3, getBoardName(board_id));	
			pstmt.setString(4, nick);
			pstmt.setString(5, id);
			pstmt.setString(6, subject);
			pstmt.setString(7, content);
			pstmt.setString(8, getDate());
			pstmt.setInt(9, 0);
			pstmt.setInt(10, 0);
			return pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}
	
//	public ArrayList<Bbs> getList(int pageNumber){
//		String SQL = "select * from BBS where bbsID < ? and bbsAvailable = 1 order by bbsID desc limit 14";
//		ArrayList<Bbs> list = new ArrayList<Bbs>();
//		try {
//			PreparedStatement pstmt = conn.prepareStatement(SQL);
//			pstmt.setInt(1,  getNext() - (pageNumber - 1) * 14);
//			rs = pstmt.executeQuery();
//			while(rs.next()) {
//				Bbs bbs = new Bbs();
//				bbs.setBbsID(rs.getInt(1));
//				bbs.setBbsTitle(rs.getString(2));
//				bbs.setUserID(rs.getString(3));
//				bbs.setBbsDate(rs.getString(4));
//				bbs.setBbsContent(rs.getString(5));
//				bbs.setBbsAvailable(rs.getInt(6));
//				list.add(bbs);
//			}			
//		}catch(Exception e){
//			e.printStackTrace();
//		}
//		return list;
//	}
	
	public ArrayList<Boards> mainGetList(){
		String SQL = "select id, subject, nick, uploadDate, hit from boards order by id desc limit 20";
		ArrayList<Boards> list = new ArrayList<Boards>();
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Boards boards = new Boards();
				
				boards.setId(rs.getInt(1));
				boards.setSubject(rs.getString(2));
				boards.setNick(rs.getString(3));
				boards.setUploadDate(rs.getString(4));
				boards.setHit(rs.getInt(5));
				list.add(boards);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Board_ids> mainGetMenuList(){
		String SQL = "select board_id, boardName from board_ids";
		ArrayList<Board_ids> menuList = new ArrayList<Board_ids>();
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Board_ids board_ids = new Board_ids();
				
				board_ids.setBoard_id(rs.getInt(1));
				board_ids.setBoardName(rs.getString(2));
				
				menuList.add(board_ids);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return menuList;
	}
	
//	public boolean nextPage(int pageNumber) {
//		String SQL = "select * from BBS where bbsID < ? and bbsAvailable = 1";
//		try {
//			PreparedStatement pstmt = conn.prepareStatement(SQL);
//			pstmt.setInt(1,  getNext() - (pageNumber - 1) * 14);
//			rs = pstmt.executeQuery();
//			if(rs.next()) {
//				return true;
//			}
//		}catch(Exception e){
//			e.printStackTrace();
//		}
//		return false;
//	}
//	
	public Boards show(int id) {
		String SQL = "select * from boards where id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Boards boards = new Boards();
				boards.setId(rs.getInt(1));
				boards.setBoard_id(rs.getInt(2));
				boards.setBoardName(rs.getString(3));
				boards.setNick(rs.getString(4));
				boards.setUser_id(rs.getString(5));
				boards.setSubject(rs.getString(6));
				boards.setContent(rs.getString(7));
				boards.setUploadDate(rs.getString(8));
				boards.setHit(rs.getInt(9));
				boards.setLikeCount(rs.getInt(10));
				
				return boards;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	

//	
//	public int update(int bbsID, String bbsTitle, String bbsContent) {
//		String SQL = "update BBS set bbsTitle = ?, bbsContent = ? where bbsID = ?";
//		try {
//			PreparedStatement pstmt = conn.prepareStatement(SQL);
//			pstmt.setString(1, bbsTitle);
//			pstmt.setString(2, bbsContent);	
//			pstmt.setInt(3, bbsID);
//			return pstmt.executeUpdate();
//		}catch(Exception e){
//			e.printStackTrace();
//		}
//		return -1;//�����ͺ��̽� ����
//	}
//	
//	public int delete(int bbsID) {
//		String SQL = "update BBS set bbsAvailable = 0 where bbsID = ?";
//		try {
//			PreparedStatement pstmt = conn.prepareStatement(SQL);
//			pstmt.setInt(1, bbsID);			
//			return pstmt.executeUpdate();
//		}catch(Exception e){
//			e.printStackTrace();
//		}
//		return -1;//�����ͺ��̽� ����
//	}
}
