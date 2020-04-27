<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="admins.AdminsDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");
String lvName_1 = request.getParameter("lvName_1");
String lvName_2 = request.getParameter("lvName_2");
String lvName_3 = request.getParameter("lvName_3");
String lvName_4 = request.getParameter("lvName_4");
String lvName_5 = request.getParameter("lvName_5");
String lvName_6 = request.getParameter("lvName_6");
String explain_1 = request.getParameter("explain_1");
String explain_2 = request.getParameter("explain_2");
String explain_3 = request.getParameter("explain_3");
String explain_4 = request.getParameter("explain_4");
String explain_5 = request.getParameter("explain_5");
String explain_6 = request.getParameter("explain_6");
int b_2=0;
int b_3=0;
int b_4=0;
int b_5=0;
int b_6=0;
int c_2=0;
int c_3=0;
int c_4=0;
int c_5=0;
int c_6=0;
int v_2=0;
int v_3=0;
int v_4=0;
int v_5=0;
int v_6=0;
int s_2=0;
int s_3=0;
int s_4=0;
int s_5=0;
int s_6=0;
String board_2 = request.getParameter("board_2");
if(board_2 != null){
	b_2 = Integer.parseInt(board_2);
}
String board_3 = request.getParameter("board_3");
if(board_3 != null){
	b_3 = Integer.parseInt(board_3);
}
String board_4 = request.getParameter("board_4");
if(board_4 != null){
	b_4 = Integer.parseInt(board_4);
}
String board_5 = request.getParameter("board_5");
if(board_5 != null){
	b_5 = Integer.parseInt(board_5);
}
String board_6 = request.getParameter("board_6");
if(board_6 != null){
	b_6 = Integer.parseInt(board_6);
}
String comment_2 = request.getParameter("comment_2");
if(comment_2 != null){
	c_2 = Integer.parseInt(comment_2);
}
String comment_3 = request.getParameter("comment_3");
if(comment_3 != null){
	c_3 = Integer.parseInt(comment_3);
}
String comment_4 = request.getParameter("comment_4");
if(comment_4 != null){
	c_4 = Integer.parseInt(comment_4);
}
String comment_5 = request.getParameter("comment_5");
if(comment_5 != null){
	c_5 = Integer.parseInt(comment_5);
}
String comment_6 = request.getParameter("comment_6");
if(comment_6 != null){
	c_6 = Integer.parseInt(comment_6);
}
String visit_2 = request.getParameter("visit_2");
if(visit_2 != null){
	v_2 = Integer.parseInt(visit_2);
}
String visit_3 = request.getParameter("visit_3");
if(visit_3 != null){
	v_3 = Integer.parseInt(visit_3);
}
String visit_4 = request.getParameter("visit_4");
if(visit_4 != null){
	v_4 = Integer.parseInt(visit_4);
}
String visit_5 = request.getParameter("visit_5");
if(visit_5 != null){
	v_5 = Integer.parseInt(visit_5);
}
String visit_6 = request.getParameter("visit_6");
if(visit_6 != null){
	v_6 = Integer.parseInt(visit_6);
}
String selectValue_2 = request.getParameter("selectValue_2");
if(selectValue_2 != null){
	s_2 = Integer.parseInt(selectValue_2);
}
String selectValue_3 = request.getParameter("selectValue_3");
if(selectValue_3 != null){
	s_3 = Integer.parseInt(selectValue_3);
}
String selectValue_4 = request.getParameter("selectValue_4");
if(selectValue_4 != null){
	s_4 = Integer.parseInt(selectValue_4);
}
String selectValue_5 = request.getParameter("selectValue_5");
if(selectValue_5 != null){
	s_5 = Integer.parseInt(selectValue_5);
}
String selectValue_6 = request.getParameter("selectValue_6");
if(selectValue_6 != null){
	s_6 = Integer.parseInt(selectValue_6);
}


AdminsDAO adminsDAO = new AdminsDAO();  
if(adminsDAO.chkLevelExist() == 0){
	adminsDAO.insertLevelInfo();
	adminsDAO.updateLevelInfo1(lvName_1, explain_1);
	if(lvName_2 != null){
		adminsDAO.updateLevelInfo2(lvName_2, explain_2, b_2, c_2, v_2, s_2);
		}
		if(lvName_3 != null){
		adminsDAO.updateLevelInfo3(lvName_3, explain_3, b_3, c_3, v_3, s_3);
		}
		if(lvName_4 != null){
		adminsDAO.updateLevelInfo4(lvName_4, explain_4, b_4, c_4, v_4, s_4);
		}
		if(lvName_5 != null){
		adminsDAO.updateLevelInfo5(lvName_5, explain_5, b_5, c_5, v_5, s_5);
		}
		if(lvName_6 != null){
		adminsDAO.updateLevelInfo6(lvName_6, explain_6, b_6, c_6, v_6, s_6);
		}
		if(lvName_2 == null){
			adminsDAO.activate(2);
		}
		if(lvName_3 == null){
			adminsDAO.activate(3);
		}
		if(lvName_4 == null){
			adminsDAO.activate(4);
		}
		if(lvName_5 == null){
			adminsDAO.activate(5);
		}
		if(lvName_6 == null){
			adminsDAO.activate(6);
		}
}else{
	adminsDAO.updateLevelInfo1(lvName_1, explain_1);
	if(lvName_2 != null){
		adminsDAO.updateLevelInfo2(lvName_2, explain_2, b_2, c_2, v_2, s_2);
		}
		if(lvName_3 != null){
		adminsDAO.updateLevelInfo3(lvName_3, explain_3, b_3, c_3, v_3, s_3);
		}
		if(lvName_4 != null){
		adminsDAO.updateLevelInfo4(lvName_4, explain_4, b_4, c_4, v_4, s_4);
		}
		if(lvName_5 != null){
		adminsDAO.updateLevelInfo5(lvName_5, explain_5, b_5, c_5, v_5, s_5);
		}
		if(lvName_6 != null){
		adminsDAO.updateLevelInfo6(lvName_6, explain_6, b_6, c_6, v_6, s_6);
		}
		if(lvName_2 == null){
			adminsDAO.activate(2);
		}
		if(lvName_3 == null){
			adminsDAO.activate(3);
		}
		if(lvName_4 == null){
			adminsDAO.activate(4);
		}
		if(lvName_5 == null){
			adminsDAO.activate(5);
		}
		if(lvName_6 == null){
			adminsDAO.activate(6);
		}
}
%>
<script>
alert('성공적으로 반영 되었습니다');
location.href='./ManageMemberLevel.jsp';
</script>
</body>
</html>