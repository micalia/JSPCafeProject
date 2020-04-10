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
String reply = request.getParameter("reply");
String getBundle = request.getParameter("bundleData");
if(request.getParameter("rereply") != null)reply = request.getParameter("rereply");

int bundle = -1;
if(getBundle != null){
bundle = Integer.parseInt(getBundle); 
}
  BoardsDAO boardsDAO = new BoardsDAO();
if(bundle == -1){
int result = boardsDAO.replyInsert(b_id, bundle, reply, nick, id);
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
        jArray.add(i, data);
    }
	json.put("jreply", jArray);
	response.setCharacterEncoding("UTF-8");
	response.setContentType("application/json");
	out.print(json.toJSONString()); 
} 
}else{
	int result = boardsDAO.replyInsert(b_id, bundle, reply, nick, id);
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
	        jArray.add(i, data);
	    }
		json.put("jreply", jArray);
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		out.print(json.toJSONString()); 
}
}
%>