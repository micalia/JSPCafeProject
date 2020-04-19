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
int level = 1;
if (session.getAttribute("level") != null){
	level = (int) session.getAttribute("level");
}
int b_id = Integer.parseInt(request.getParameter("b_id"));
String reply = request.getParameter("reply");
String replyNum = request.getParameter("replyNum");

int n_replyNum = -1;
if(replyNum != null){
	n_replyNum = Integer.parseInt(replyNum); 
}
  BoardsDAO boardsDAO = new BoardsDAO();
  int chk = boardsDAO.beforeUpdateChk(n_replyNum, id);
 if(chk == 1){
  int result = boardsDAO.replyUpdate(n_replyNum, reply);
if(result == -1){
	JSONObject json = new JSONObject();
	json.put("error", "예상치 못한 오류가 발생했습니다.");
	response.setCharacterEncoding("UTF-8");
	response.setContentType("application/json");
	out.print(json.toJSONString());
}else{
	boardsDAO.replyUpCount(b_id);
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
        if(id.equals(replyList.get(i).getUser_id()) || level>17){
        	data.put("deleteAction", "<span class='replyDelete' onclick='if(confirm(\"답글을 삭제하시겠습니까?\")){replyDelete(" + replyList.get(i).getNum() + "," + replyList.get(i).getBundle() + ");}'>삭제</span>");
        }else{
        	data.put("deleteAction","");
        }
        if(id.equals(replyList.get(i).getUser_id())){
        	data.put("modifyAction", "<span class='replyModify'>&nbsp;|&nbsp;</span><span class='replyModify' onclick='replyModify(" + replyList.get(i).getNum() + ")'>수정</span>");
        }else{
        	data.put("modifyAction","");
        }
        data.put("rec_nick", replyList.get(i).getRec_nick());
        data.put("rec_id", replyList.get(i).getRec_user_id());
        jArray.add(i, data);
    }
	json.put("jreply", jArray);
	response.setCharacterEncoding("UTF-8");
	response.setContentType("application/json");
	out.print(json.toJSONString()); 
} 
  }
%>