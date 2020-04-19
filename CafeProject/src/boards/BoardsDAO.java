package boards;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BoardsDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public BoardsDAO() {
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

	public String getDate() {
		String SQL = "select now()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	
	  public int getNext() { 
		  String SQL = "select id from boards order by id desc";
		  try { 
			  PreparedStatement pstmt = conn.prepareStatement(SQL);
			  rs = pstmt.executeQuery(); 
			  if (rs.next()) { 
				  return rs.getInt(1) + 1; 
				  } 
			  return 1;// 첫번째 게시물인 경우 
			  } catch (Exception e) {
				  e.printStackTrace(); 
			  } 
		  return -1; //데이터베이스오류 
	  }
	

	public String getBoardName(int board_id) {
		String SQL = "select boardName from board_ids where board_id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, board_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String board_ids = rs.getString(1);
				return board_ids;
			}
		} catch (Exception e) {
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
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<Boards> getList(int page, int pagesize) {
		String sql = "SELECT id, subject, nick, uploadDate, hit FROM boards order by boards.id desc limit ?, ?";
		ArrayList<Boards> list = new ArrayList<Boards>();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, page);
			pstmt.setInt(2, pagesize);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Boards boards = new Boards();
				boards.setId(rs.getInt(1));
				boards.setSubject(rs.getString(2));
				boards.setNick(rs.getString(3));
				boards.setUploadDate(rs.getString(4));
				boards.setHit(rs.getInt(5));
				list.add(boards);
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
		return list;
	}
	
	public ArrayList<Boards> getListInMenu(int boardId, int page, int pagesize) {
		String sql = "SELECT id, subject, nick, uploadDate, hit FROM boards where board_id = ? order by boards.id desc limit ?, ?";
		ArrayList<Boards> list = new ArrayList<Boards>();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardId);
			pstmt.setInt(2, page);
			pstmt.setInt(3, pagesize);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Boards boards = new Boards();
				boards.setId(rs.getInt(1));
				boards.setSubject(rs.getString(2));
				boards.setNick(rs.getString(3));
				boards.setUploadDate(rs.getString(4));
				boards.setHit(rs.getInt(5));
				list.add(boards);
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
		return list;
	}
	
	public ArrayList<Boards> mainGetList() {
		String SQL = "select id, subject, nick, uploadDate, hit, replyCount from boards order by id desc limit 20";
		ArrayList<Boards> list = new ArrayList<Boards>();
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Boards boards = new Boards();

				boards.setId(rs.getInt(1));
				boards.setSubject(rs.getString(2));
				boards.setNick(rs.getString(3));
				boards.setUploadDate(rs.getString(4));
				boards.setHit(rs.getInt(5));
				boards.setReplyCount(rs.getInt(6));
				list.add(boards);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public ArrayList<Board_ids> mainGetMenuList() {
		String SQL = "select board_id, boardName from board_ids";
		ArrayList<Board_ids> menuList = new ArrayList<Board_ids>();
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Board_ids board_ids = new Board_ids();

				board_ids.setBoard_id(rs.getInt(1));
				board_ids.setBoardName(rs.getString(2));

				menuList.add(board_ids);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return menuList;
	}

	public int replyUpCount(int id) {
		String SQL = "update boards set replyCount = replyCount + 1 where id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, id);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int replyDownCount(int id) {
		String SQL = "update boards set replyCount = replyCount - 1 where id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, id);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int hitUp(int id) {
		String SQL = "update boards set hit = hit + 1 where id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, id);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	public Boards show(int id) {
		try {
			String SQL = "select * from boards where id = ?";
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
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
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public int insertMenu(Board_ids board_ids) {
		String SQL = "insert into board_ids(boardName) values(?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, board_ids.getBoardName());

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

	public int deleteMenu(Board_ids board_id) {
		String SQL = "delete from board_ids where board_id = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, board_id.getBoard_id());

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

	public int updateMenu(int board_id, String boardName) {
		String SQL = "update board_ids set boardName = ? where board_id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, boardName);
			pstmt.setInt(2, board_id);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int getCount(){
		int count = 0;
		String sql = "select count(*) from boards";
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
	
	public int getCountInMenu(int boardId){
		int count = 0;
		String sql = "select count(*) from boards where board_id = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardId);
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
	
	public int update(int board_id, String subject, String content, int b_id) {
		String SQL = "update boards set board_id = ?, boardName = ?, subject = ? ,content = ? where id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, board_id);
			pstmt.setString(2, getBoardName(board_id));
			pstmt.setString(3, subject);
			pstmt.setString(4, content);
			pstmt.setInt(5, b_id);
			return pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}
	
	public int delete(int b_id) {
		String SQL = "delete from boards where id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, b_id);			
			return pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}

	public int replyInsert(int b_id, int bundle, String reply,  String nick, String id, String rec_nick, String rec_id) {
		String SQL;
		if(bundle == -1) {
			SQL = "insert into reply(b_id, bundle, reply, time, nick, user_id) values(?, (select ifnull(max(bundle)+1,1) from reply as rep), ?, ?, ?, ?)";
		}else if(rec_id != null){
			SQL = "insert into reply(b_id, bundle, reply, time, nick, user_id, rec_nick, rec_user_id) values(?, ?, ?, ?, ?, ?, ?, ?)";
		}else {		
			SQL = "insert into reply(b_id, bundle, reply, time, nick, user_id) values(?, ?, ?, ?, ?, ?)";
		}
		try {
			pstmt = conn.prepareStatement(SQL);
			if(bundle == -1) {
				pstmt.setInt(1, b_id);
				pstmt.setString(2, reply);
				pstmt.setString(3, getDate());
				pstmt.setString(4, nick);
				pstmt.setString(5, id);

			}else if(rec_id != null){
				pstmt.setInt(1, b_id);
				pstmt.setInt(2, bundle);
				pstmt.setString(3, reply);
				pstmt.setString(4, getDate());
				pstmt.setString(5, nick);
				pstmt.setString(6, id);
				pstmt.setString(7, rec_nick);
				pstmt.setString(8, rec_id);
			}else {
				pstmt.setInt(1, b_id);
				pstmt.setInt(2, bundle);
				pstmt.setString(3, reply);
				pstmt.setString(4, getDate());
				pstmt.setString(5, nick);
				pstmt.setString(6, id);
			}
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
	
	public ArrayList<Reply> getReply(int b_id) {
		String sql = "select * from reply where b_id = ? order by if(bundle = 0, num, bundle), num";
		ArrayList<Reply> list = new ArrayList<Reply>();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Reply reply = new Reply();
				reply.setB_id(rs.getInt(1));
				reply.setBundle(rs.getInt(2));
				reply.setNum(rs.getInt(3));
				reply.setReply(rs.getString(4));
				reply.setTime(rs.getString(5));
				reply.setNick(rs.getString(6));
				reply.setUser_id(rs.getString(7));
				reply.setRec_nick(rs.getString(8));
				reply.setRec_user_id(rs.getString(9));
				list.add(reply);
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
		return list;
	}
	
	public int replyDelete(int reply_num) {
		String SQL = "delete from reply where num = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, reply_num);			
			return pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}
	
	public int replyUpdate(int n_replyNum, String reply) {
		String SQL = "update reply set time = now(), reply = ? where num = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, reply);;
			pstmt.setInt(2, n_replyNum);
			return pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}
	
	public int beforeUpdateChk(int n_replyNum, String id){
		int count = 0;
		String sql = "select count(*) from reply where num = ? and user_id = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, n_replyNum);
			pstmt.setString(2, id);;
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
	
	public int getBundleCount(int bundle){
		int count = 0;
		String sql = "select count(*) from reply where bundle = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bundle);
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
	
	public int getBundleHost(int bundle){
		int hostNum = 0;
		String sql = "select min(num) from reply where bundle = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bundle);
			rs = pstmt.executeQuery();
			if(rs.next()){
				hostNum = rs.getInt(1);
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
		return hostNum; 
	}
	
	public int deleteTextUpdate(int reply_num) {
		String SQL = "update reply set reply = 'none', nick = 'none', user_id = 'none', rec_nick = 'none', rec_user_id = 'none' where num = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, reply_num);

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

	public Reply getHostUserIdChk(int bundle) {
		String SQL = "select min(num), user_id from reply where bundle = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bundle);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Reply reply = new Reply();
				reply.setNum(rs.getInt(1));
				reply.setUser_id(rs.getString(2));
				return reply;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int deleteBundle(int bundle) {
		String SQL = "delete from reply where bundle = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bundle);			
			return pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}
}
