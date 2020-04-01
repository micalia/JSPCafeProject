<%@ page import="java.util.*" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
 <%@ include file="Connection.jsp" %>
 <% 
  	String id = request.getParameter("id");	
  	String password = request.getParameter("password");
	
 	int statusQuery = 0;
 	String dbname="";
 	Class.forName("com.mysql.jdbc.Driver").newInstance();
 
	    if(id !=null || password != null){
	        try{
	            String query="SELECT password FROM users WHERE id='"+id+"'";
	            ps=connection.prepareStatement(query);
	            rs=ps.executeQuery();
	            while (rs.next()) {
	            	dbname=rs.getString("password");
	            }
	            if(dbname.equals(password)){
	            	String status="NNNNY";
	            	response.setContentType("text/plain");
	            	response.setCharacterEncoding("UTF-8"); 
	            	response.getWriter().write(status); 
	            }
	            else{
	            	String status="NNNNN";//아이디 이용할 수 없음
	            	response.setContentType("text/plain");
	            	response.setCharacterEncoding("UTF-8"); 
	            	response.getWriter().write(status); 
	            	
	            }
	        }catch(Exception ex){
	            out.println("Your Connection Failed");
	        }
	    }

%>

