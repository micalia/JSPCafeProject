<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.util.Enumeration"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<% 
java.util.Calendar cal = java.util.Calendar.getInstance();
String year = Integer.toString(cal.get ( cal.YEAR ));
String month = Integer.toString(cal.get ( cal.MONTH ) + 1) ;
String time = year + month;

String uploadFolder = "/cafeAdmin/gate/upload/" + time;
ServletContext context = getServletContext();
String uploadPath = context.getRealPath(uploadFolder);

File Folder = new File(uploadPath);

if(!Folder.exists()) {
	try{
	    Folder.mkdir(); //폴더 생성합니다.
	    System.out.println("폴더가 생성되었습니다.");
        } 
        catch(Exception e){
	    e.getStackTrace();
	} 
}
%>
<% 
//String upsloadPath = request.getRealPath("upload");
int size = 10 * 1024 * 1024; // 업로드 사이즈 제한 10M 이하
String subject = "";
String fileName = "";

try{
	MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "utf-8", new DefaultFileRenamePolicy());
	Enumeration files = multi.getFileNames();
	String file = (String)files.nextElement(); 
	fileName = multi.getFilesystemName(file); 
}catch(Exception e){
	e.printStackTrace();
}
String filePath = "/CafeProject/cafeAdmin/gate/upload/" + time + "/" + fileName;

JSONObject json = new JSONObject();
json.put("url", filePath);

response.setContentType("application/json");
out.print(json.toJSONString());

%>