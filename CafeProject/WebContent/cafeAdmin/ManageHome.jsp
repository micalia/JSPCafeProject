<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./layouts/checkPermission.jsp" %>
<center>
<a href="<%=request.getContextPath()%>/home.jsp">
  <img src="../img/cafeLogo.png"style="height:61px;">
</a></center>
<a href="./ManageMenu.jsp">메뉴관리</a><br>
<a href="./ManageMemberLevel.jsp">멤버 등급 관리</a><br>
<a href="./title/ManageTitle.jsp">타이틀 이미지 바꾸기</a><br>
<a href="./gate/ManageGateEdit.jsp">카페 대문 바꾸기</a><br>
<a href="./cafeProfile/ManageCafeProfileImg.jsp">카페 프로필 이미지 바꾸기</a><br>
</body>
</html>