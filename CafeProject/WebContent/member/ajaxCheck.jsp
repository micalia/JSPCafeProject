<%@ page import="java.util.*" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
 <%@ include file="Connection.jsp" %>
 <% 
  	String m = request.getParameter("m");
  	String id = request.getParameter("id");
	String nick = request.getParameter("nick");
	String email = request.getParameter("email");
	
 	int statusQuery = 0;
 	String dbname="";
 	Class.forName("com.mysql.jdbc.Driver").newInstance();
 if(m.equals("checkId")){
	    if(id !=null ){
	        try{
	            String query="SELECT * FROM users WHERE id='"+id+"'";
	            ps=connection.prepareStatement(query);
	            rs=ps.executeQuery();
	            while (rs.next()) {
	            	dbname=rs.getString("id");
	            }
	            if(dbname.equals(id)){
	            	String status="NNNNN";//아이디 이용할 수 없음
	            	response.setContentType("text/plain");
	            	response.setCharacterEncoding("UTF-8"); 
	            	response.getWriter().write(status); 
	    	
	            }
	            else{
	            	String status="NNNNY";
	            	response.setContentType("text/plain");
	            	response.setCharacterEncoding("UTF-8"); 
	            	response.getWriter().write(status); 
	            	
	            }
	        }catch(Exception ex){
	            out.println("Your Connection Failed");
	        }
	    }
    }
 if(m.equals("checkNick")){
 if(nick != null){
	    	try{
	            String query="SELECT * FROM users WHERE nick='"+nick+"'";
	            ps=connection.prepareStatement(query);
	            rs=ps.executeQuery();
	            while (rs.next()) {
	            	dbname=rs.getString("nick");
	            }
	            if(dbname.equals(nick)){
	            	String status="NNNNN";//닉네임 사용불가능
	            	response.setContentType("text/plain");
	            	response.setCharacterEncoding("UTF-8"); 
	            	response.getWriter().write(status); 
	    	
	            }
	            else{
	            	String status="NNNNY";
	            	response.setContentType("text/plain");
	            	response.setCharacterEncoding("UTF-8"); 
	            	response.getWriter().write(status); 
	            	
	            }
	        }catch(Exception ex){
	            out.println("Your Connection Failed");
	        }
 	}
 }
   
 if(m.equals("checkEmail")){
 if(email != null){
	    	try{
	            String query="SELECT * FROM users WHERE email='"+email+"'";
	            ps=connection.prepareStatement(query);
	            rs=ps.executeQuery();
	            while (rs.next()) {
	            	dbname=rs.getString("email");
	            }
	            if(dbname.equals(email)){
	            	String status="NNNNN";
	            	response.setContentType("text/plain");
	            	response.setCharacterEncoding("UTF-8"); 
	            	response.getWriter().write(status); 
	    	
	            }
	            else{
	            	String status="NNNNY";
	            	response.setContentType("text/plain");
	            	response.setCharacterEncoding("UTF-8"); 
	            	response.getWriter().write(status); 
	            	
	            }
	        }catch(Exception ex){
	            out.println("Your Connection Failed");
	        }
 	}
 }
%>

