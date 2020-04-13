<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boards.BoardsDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="boards.Reply" %>
<% request.setCharacterEncoding("UTF-8");  %>
<% 
String id = null;
if (session.getAttribute("id") != null){
	id = (String) session.getAttribute("id");
}
String nick = null;
if (session.getAttribute("nick") != null){
	nick = (String) session.getAttribute("nick");
}
int b_id = Integer.parseInt(request.getParameter("b_id"));
int reply_num = Integer.parseInt(request.getParameter("reply_num"));
int bundle = -1;
int result = -1;
if(request.getParameter("bundle") != null){
bundle = Integer.parseInt(request.getParameter("bundle"));
}
  BoardsDAO boardsDAO = new BoardsDAO();
int bundleChk = boardsDAO.getBundleCount(bundle);
if(bundleChk > 1){//같은이름의 번들이 여러개라면
	int bundleHost = boardsDAO.getBundleHost(bundle);
	if(bundleHost == reply_num){//번들 호스트라면 '삭제된댓글'로 업데이트
		result = boardsDAO.deleteTextUpdate(reply_num);
		System.out.println("1");
	}else{
		if(boardsDAO.getBundleCount(bundle) == 2 && boardsDAO.getHostUserIdChk(bundle).getUser_id().equals("none")){
			result = boardsDAO.deleteBundle(bundle);
			System.out.println("2");
		}else{	
     		result = boardsDAO.replyDelete(reply_num);
     		System.out.println("3");
		}
		
	}
}else{
	result = boardsDAO.replyDelete(reply_num);
	System.out.println("4");
}
if(result == -1){
	JSONObject json = new JSONObject();
	json.put("error", "예상치 못한 오류가 발생했습니다.");
	response.setCharacterEncoding("UTF-8");
	response.setContentType("application/json");
	out.print(json.toJSONString());
}else{
	JSONArray jArray = new JSONArray();
	JSONObject json= new JSONObject();
	ArrayList<Reply> replyList = boardsDAO.getReply(b_id); 
	for (int i = 0; i < replyList.size(); i++) {
        JSONObject data= new JSONObject();
        data.put("b_id", replyList.get(i).getB_id());
        data.put("bundle", replyList.get(i).getBundle());
        data.put("num", replyList.get(i).getNum());
        data.put("reply", replyList.get(i).getReply());
        data.put("time", replyList.get(i).getTime().substring(0, 16).replace("-", "."));
        data.put("nick", replyList.get(i).getNick());
        data.put("user_id", replyList.get(i).getUser_id());
        data.put("rec_nick", replyList.get(i).getRec_nick());
        data.put("rec_id", replyList.get(i).getRec_user_id());
        jArray.add(i, data);
    }
	json.put("jreply", jArray);
	response.setCharacterEncoding("UTF-8");
	response.setContentType("application/json");
	out.print(json.toJSONString()); 
} 
%>