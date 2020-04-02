<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="admins.AdminsDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="org.json.simple.JSONObject"%>
<%
	request.setCharacterEncoding("UTF-8");

	AdminsDAO adminsDAO = new AdminsDAO();
int Count = adminsDAO.getCafeProfileImgCount();
System.out.println(Count);
if(Count == 0){
	int result = adminsDAO.cafeProfileImgInsert(request.getParameter("imageData"));
	if(result == -1){
		JSONObject json = new JSONObject();
		json.put("error", "예상치 못한 오류가 발생했습니다.");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		out.print(json.toJSONString());
	}else{
		JSONObject json = new JSONObject();
		json.put("status", true);
		json.put("message", "성공적으로 반영 되었습니다.");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		out.print(json.toJSONString());
	}
}else{
	int result = adminsDAO.cafeProfileImgUpdate(request.getParameter("imageData"));
	if(result == -1){
		JSONObject json = new JSONObject();
		json.put("error", "예상치 못한 오류가 발생했습니다.");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		out.print(json.toJSONString());
	}else{
		JSONObject json = new JSONObject();
		json.put("status", true);
		json.put("message", "성공적으로 반영 되었습니다.");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		out.print(json.toJSONString());
	}
}
%>