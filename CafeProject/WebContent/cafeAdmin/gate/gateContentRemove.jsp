<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="admins.AdminsDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="org.json.simple.JSONObject"%>
<% request.setCharacterEncoding("UTF-8");  %>
<% 
AdminsDAO adminsDAO = new AdminsDAO();

int result = adminsDAO.deleteGateContent();
if(result == -1){
	JSONObject json = new JSONObject();
	json.put("error", "예상치 못한 오류가 발생했습니다.");
	response.setCharacterEncoding("UTF-8");
	response.setContentType("application/json");
	out.print(json.toJSONString());
}else{
	JSONObject json = new JSONObject();
	json.put("status", true);
	json.put("message", "기존 카페대문을 제거했습니다.");
	response.setCharacterEncoding("UTF-8");
	response.setContentType("application/json");
	out.print(json.toJSONString());
} 
%>