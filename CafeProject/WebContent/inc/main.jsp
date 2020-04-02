<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="boards.BoardsDAO" %>
    <%@ page import="admins.AdminsDAO" %>
    <%@ page import="boards.Board_ids" %>
    <%@ page import="users.UsersDAO" %>
    <%@ page import="java.util.ArrayList" %>
    
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title></title>
    <!-- Styles -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap-4.4.1-dist/css/bootstrap.min.css">
    <script src="<%=request.getContextPath()%>/js/jquery-3.4.1.min.js"></script>
    <script src="<%=request.getContextPath()%>/summernote/popper.min.js"></script>
    <script src="<%=request.getContextPath()%>/bootstrap-4.4.1-dist/js/bootstrap.min.js"></script>
    
<style>
body{
  width:1080px;
  margin: 0 auto;
}
p, h1, h2, h3, h4, h5, h6, ul, ol, li, dl, dt, dd, table, th, td, form, fieldset, legend, input, textarea,button, select {
    margin: 0;
    padding: 0;
    font-size: 15px;
}

  #banner{
    border: 1px solid;
    width:1080px;
    height: 180px;
  }
  
  #banner:hover{
  	cursor:pointer;
  }
  #bodyLeft{
    width:200px;
  }
  #profile{
    overflow: hidden;
    height: auto;
    border: 1px solid;
  }
  ul, li, ol, dl{
    list-style: none;
  }
  nav{
    float: left;
    margin-top:5px;
  }
  .navStyle{
  	width:200px;
  	border: 1px solid black;
  }
  article{
    float: right;
  }
  .profileTop{
    overflow: hidden;
    padding: 5px 10px;
    display: table;
  margin-left: auto;
  margin-right: auto;
  }
  .profileTop li{
    float:left;
    width: 72px;
    padding-top: 3px;
    font-weight: bold;
    font-size: 15px;
    line-height: 20px;
    text-align: center;
    color: #959595;
  }
  
  .profileImg{
	border: 1px solid;
	width: 58px;
	height: 58px; 
	border: 1px solid rgba(0, 0, 0, 0.04);
	float:left; 
	border-radius:22px; 
	margin-right: 8px;
  }
  .cafe_intro{
  border:4px solid #eee;
    overflow:hidden;
    width:860px;
    height: auto;
  }

  .content-area{
    overflow:hidden;
    height:auto;
    width:1080px;
    margin-top: 14px;
  }
.liUnder:hover{
  text-decoration: underline;
  cursor:pointer;
}
table{
    width: 100%;
}

.tableContainer{
    margin-top:24px;
}
.main-area{
    float:right;
    width:860px;
}
.side-area{
    float:left;
    width:200px;
}
td{
    padding:4px 7px;
}
.td_subject{
    padding-left:8px;
    padding-right:18px;
}
.subjectcss{
    color:black;
}
.subjectcss:hover{
    color:black;
}
.content-border{
    border:1px solid black;
}
.footer{
        margin-top:60px;
        border-top-color:black;
        border-top-width:2px;
        padding:24px 0px 24px 0px;
        border-top-style:solid;
        clear: both;
    }
    #menuIcon{
    margin-bottom:5px;
    }
    #info-data1{
    	padding: 12px 10px;
    	overflow: hidden;
    	width: 100%;
    }
    #info-data2{
    	padding: 12px 10px;
    	overflow: hidden;
    	width: 100%;
    }
    .cafe-menu-all-list{
    	margin:10px;
    	margin-top:5px;
    	margin-bottom:3px;
    }
    .cafe-menu-list{
    	margin:10px;
    	margin-top:3px;
    	margin-bottom:5px;
    }
    .cafe-menu-space{
    	    border-top: 1px solid #e5e5e5;
    	    height: 2px;
    }
    .cafe-menu-list a{
    	color:black;
    }
    .infoText{
    	cursor:pointer;
    }
    .infoText:hover{
    	text-decoration:underline;
    }
    .infoTextActive{
    	color:black;
    }
    .infoTextActive:hover{
    	text-decoration:none;
    	cursor:text;
    }
    .topbar{
    	margin:1px 0px;
    }
</style>
  </head>
  <body>
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
	%>
	<div class="topbar">
	<%
		if(id == null){
	%>
      <a href="<%=request.getContextPath()%>/member/login.jsp">로그인</a>
      <%
		}else{
	%>
     <%= nick %>
      
     <a href="<%=request.getContextPath()%>/member/logout.jsp">로그아웃</a>
      
    <%
		}
	%>
</div>
<div id="banner" style="clear:both;"onclick = "location.href='<%=request.getContextPath()%>/home.jsp'" >
    <a href ="<%=request.getContextPath()%>/home.jsp">
    <% AdminsDAO adminsDAO = new AdminsDAO(); 
    String titleImg = adminsDAO.getTitleImg();
    if(titleImg == null){
    %>
    <center>
     <a href="<%=request.getContextPath()%>/home.jsp">
       <img src="<%=request.getContextPath()%>/img/cafeLogo.png"style="height:61px;margin-top:53px;">
     </a></center>
              <%}else{ %>
              <script>
              document.getElementById("banner").style.border="0px";
              </script>
    <img src="<%=titleImg %>" onerror="window.location.reload()" style="width:1080px;height:180px;">
    <%} %>
    </a>
</div>

<div class="content-area">
<div class="side-area" oncontextmenu="return false" onselectstart="return false" ondragstart="return false">
<div id="bodyLeft">
 <div id="profile">
    <ul class="profileTop">
      <li class="profileTop1" onclick="infoData1()"><span id = "cafeInfo" class="infoText infoTextActive">카페정보</span></li>
      <li class="profileTop2" onclick="<% if(session.getAttribute("id") == null){ %> alert('로그인이 필요합니다') <% }else{ %>infoData2()<%}%>"><span id = "myInfo" class="infoText">나의정보</span></li>
    </ul>
     <div class="profileSecond">
     <div id="info-data1">
     <img src="<%=request.getContextPath()%>/img/profile.jpg" class="profileImg">
     <%if(level > 11){ %>
      <a href="<%=request.getContextPath()%>/cafeAdmin/ManageHome.jsp">카페관리</a>
      <% } %>
      </div>
      <%if(session.getAttribute("id") != null){ %>
      <div id="info-data2" style="display:none;">
     <img src="<%=request.getContextPath()%>/img/profile.jpg" class="profileImg">
     <% if(nick.length()>6){%>
     <%= nick.substring(0,6) %>..<br>
    	 <%}else{ %>
    	 <%=nick %>
    	 <%} %>
    	 <br>
 
       레벨 : <%= level %>
      </div>
<%} %>
	<%
		if(id != null){
	%>
            <button type="button" class="btn btn-secondary btn-block"style="border-radius: 0;"onclick="location.href='<%=request.getContextPath()%>/board/write.jsp'" >카페 글쓰기</button>
       <%
		}else{
	%>
            <button type="button" class="btn btn-secondary btn-block"style="border-radius: 0;"onclick="location.href='<%=request.getContextPath()%>/member/register.jsp'">카페 가입하기</button>
	<%
		}
	%>
      
    </div> 
  </div> 

</div>

<nav class ="navStyle">
<ul class="cafe-menu-all-list">
	<li>
	<?xml version="1.0" encoding="utf-8"?>
<!-- Generator: Adobe Illustrator 24.1.1, SVG Export Plug-In . SVG Version: 6.00 Build 0)  -->
<svg id = "menuIcon"version="1.1" id="레이어_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px"
	 y="0px"  width ="10px" height="11px" viewBox="0 0 101.24 122.86" style="enable-background:new 0 0 101.24 122.86;" xml:space="preserve">
<style type="text/css">
	.st0{fill:#7D7D7D;}
	.st1{fill:#FEFEFE;}
	.st2{fill:#7E7E7E;}
	
</style>
<g>
	<path class="st0" d="M85.17,122.84c-23.03,0-46.06,0-69.09,0c-0.08-0.07-0.16-0.2-0.25-0.21c-7.54-1.19-13.58-7.13-15.37-14.59
		c-0.18-0.74,0.03-1.56-0.45-2.24c0-29.59,0-59.18,0-88.77c0.17-0.06,0.21-0.2,0.23-0.37c0.84-6.6,4.32-11.39,10.06-14.61
		C12.1,1.04,14.11,0.59,16.07,0c17.27,0,34.55,0,51.82,0c0.06,0.18,0.21,0.2,0.37,0.24c3.01,0.71,5.66,2.05,7.87,4.27
		c6.96,7,13.95,13.96,20.93,20.95c0.95,0.95,1.69,2.06,2.34,3.24c0.89,1.62,1.3,3.4,1.85,5.13c0,23.99,0,47.98,0,71.98
		c-0.17,0.06-0.21,0.2-0.23,0.37c-0.84,6.6-4.32,11.39-10.06,14.61C89.14,121.8,87.13,122.25,85.17,122.84z M9.84,61.3
		c0,13.95,0,27.91,0,41.86c0,0.8,0,1.6,0.18,2.38c1.08,4.78,4.87,7.64,10.2,7.64c20.27,0.01,40.54,0,60.81,0
		c1.12,0,2.23-0.08,3.32-0.38c3.76-1.01,7.15-4.46,7.13-10.13c-0.08-21.99-0.03-43.98-0.03-65.97c0-0.36-0.03-0.72-0.03-1.08
		c0-0.98-0.41-1.37-1.46-1.35c-3.52,0.07-7.04,0.06-10.55,0.02c-7.29-0.08-13.47-6.34-13.48-13.62c0-3.32-0.03-6.64,0.02-9.96
		c0.01-0.85-0.27-1.09-1.1-1.08c-15.03,0.02-30.07-0.02-45.1,0.03c-5.96,0.02-9.9,4.16-9.9,10.12C9.84,33.63,9.84,47.46,9.84,61.3z"
		/>
	<path class="st1" d="M101.24,33.83c-0.55-1.74-0.96-3.51-1.85-5.13c-0.65-1.18-1.39-2.29-2.34-3.24
		C90.08,18.47,83.09,11.5,76.13,4.51c-2.21-2.22-4.86-3.56-7.87-4.27C68.1,0.2,67.96,0.18,67.89,0c10.82,0,21.63,0.01,32.45-0.02
		c0.75,0,0.92,0.17,0.92,0.92C101.23,11.88,101.24,22.85,101.24,33.83z"/>
	<path class="st1" d="M16.07,0c-1.96,0.59-3.97,1.04-5.78,2.06C4.55,5.28,1.07,10.07,0.23,16.67C0.21,16.83,0.17,16.97,0,17.03
		C0,11.62,0.01,6.2-0.02,0.78c0-0.66,0.13-0.8,0.79-0.8C5.87,0.02,10.97,0,16.07,0z"/>
	<path class="st1" d="M0,105.81c0.49,0.67,0.28,1.49,0.45,2.24c1.79,7.45,7.83,13.39,15.37,14.59c0.09,0.01,0.17,0.14,0.25,0.21
		c-5.1,0-10.2-0.02-15.3,0.02c-0.67,0-0.8-0.14-0.79-0.8C0.01,116.64,0,111.22,0,105.81z"/>
	<path class="st1" d="M85.17,122.84c1.96-0.59,3.97-1.04,5.78-2.06c5.74-3.22,9.22-8.01,10.06-14.61c0.02-0.17,0.06-0.31,0.23-0.37
		c0,5.44-0.01,10.88,0.02,16.31c0,0.6-0.14,0.74-0.74,0.74C95.4,122.83,90.29,122.84,85.17,122.84z"/>
	<path class="st1" d="M9.84,61.3c0-13.83,0-27.67,0-41.5c0-5.97,3.95-10.1,9.9-10.12c15.03-0.06,30.07-0.01,45.1-0.03
		c0.82,0,1.11,0.23,1.1,1.08c-0.04,3.32-0.02,6.64-0.02,9.96c0.01,7.29,6.19,13.55,13.48,13.62c3.52,0.04,7.04,0.05,10.55-0.02
		c1.06-0.02,1.46,0.37,1.46,1.35c0,0.36,0.03,0.72,0.03,1.08c0,21.99-0.05,43.98,0.03,65.97c0.02,5.67-3.37,9.12-7.13,10.13
		c-1.09,0.29-2.2,0.38-3.32,0.38c-20.27,0-40.54,0-60.81,0c-5.33,0-9.12-2.86-10.2-7.64c-0.18-0.79-0.18-1.59-0.18-2.38
		C9.84,89.21,9.84,75.25,9.84,61.3z M50.65,59.74c-8.43,0-16.87-0.02-25.3,0.01c-4.46,0.01-7.27,4.67-5.13,8.45
		c1.23,2.17,3.22,2.98,5.61,2.99c5.72,0.02,11.43,0.01,17.15,0.01c10.75,0,21.5,0,32.26,0c2.04,0,3.89-0.49,5.21-2.16
		c1.46-1.85,1.75-3.9,0.7-6.04c-1.07-2.18-2.94-3.22-5.3-3.23C67.44,59.72,59.05,59.74,50.65,59.74z M50.74,84.21
		c-8.39,0-16.79,0-25.18,0c-1.58,0-2.99,0.47-4.16,1.52c-1.77,1.58-2.36,3.96-1.56,6.09c0.9,2.4,2.96,3.83,5.78,3.83
		c16.67,0.02,33.33,0.02,50,0c1.87,0,3.56-0.58,4.77-2.08c1.48-1.83,1.82-3.89,0.8-6.04c-1.06-2.23-2.96-3.3-5.38-3.31
		C67.45,84.19,59.1,84.21,50.74,84.21z M39.93,35.27c-4.87,0-9.75-0.01-14.62,0c-2.43,0.01-4.57,1.46-5.41,3.63
		c-1.55,3.96,1.35,7.82,5.92,7.82c9.39,0.02,18.77,0,28.16,0.01c0.76,0,1.51-0.09,2.24-0.31c2.78-0.86,4.44-3.52,4.01-6.4
		c-0.38-2.55-2.93-4.73-5.67-4.74C49.67,35.25,44.8,35.27,39.93,35.27z"/>
	<path class="st2" d="M50.65,59.74c8.39,0,16.79-0.02,25.18,0.02c2.36,0.01,4.23,1.05,5.3,3.23c1.05,2.14,0.76,4.19-0.7,6.04
		c-1.32,1.67-3.17,2.16-5.21,2.16c-10.75,0-21.5,0-32.26,0c-5.72,0-11.43,0.01-17.15-0.01c-2.38-0.01-4.38-0.82-5.61-2.99
		c-2.14-3.78,0.67-8.43,5.13-8.45C33.79,59.72,42.22,59.74,50.65,59.74z"/>
	<path class="st2" d="M50.74,84.21c8.35,0,16.71-0.02,25.06,0.01c2.42,0.01,4.32,1.08,5.38,3.31c1.02,2.15,0.68,4.21-0.8,6.04
		c-1.21,1.49-2.9,2.08-4.77,2.08c-16.67,0.01-33.33,0.02-50,0c-2.82,0-4.88-1.43-5.78-3.83c-0.8-2.13-0.21-4.51,1.56-6.09
		c1.17-1.05,2.58-1.52,4.16-1.52C33.95,84.22,42.35,84.21,50.74,84.21z"/>
	<path class="st2" d="M39.93,35.27c4.87,0,9.75-0.02,14.62,0.01c2.74,0.02,5.3,2.19,5.67,4.74c0.43,2.88-1.23,5.54-4.01,6.4
		c-0.72,0.22-1.48,0.31-2.24,0.31c-9.39,0-18.77,0.01-28.16-0.01c-4.57-0.01-7.47-3.86-5.92-7.82c0.85-2.16,2.98-3.62,5.41-3.63
		C30.18,35.26,35.05,35.27,39.93,35.27z"/>
</g>
</svg>
	<a href = "<%=request.getContextPath()%>/board/list.jsp" style="color:black;">전체글보기</a>
	</li>
</ul>
<div class = "cafe-menu-space"></div>
  <ul class = "cafe-menu-list">
  
  <%
	BoardsDAO boardsDAO = new BoardsDAO();
	ArrayList<Board_ids> menuList = boardsDAO.mainGetMenuList();
	for(int i = 0; i < menuList.size(); i++){
      %>

  <li>
<?xml version="1.0" encoding="utf-8"?>
<!-- Generator: Adobe Illustrator 24.1.1, SVG Export Plug-In . SVG Version: 6.00 Build 0)  -->
<svg id = "menuIcon"version="1.1" id="레이어_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px"
	 y="0px"  width ="10px" height="11px" viewBox="0 0 101.24 122.86" style="enable-background:new 0 0 101.24 122.86;" xml:space="preserve">
<style type="text/css">
	.st0{fill:#7D7D7D;}
	.st1{fill:#FEFEFE;}
	.st2{fill:#7E7E7E;}
	
</style>
<g>
	<path class="st0" d="M85.17,122.84c-23.03,0-46.06,0-69.09,0c-0.08-0.07-0.16-0.2-0.25-0.21c-7.54-1.19-13.58-7.13-15.37-14.59
		c-0.18-0.74,0.03-1.56-0.45-2.24c0-29.59,0-59.18,0-88.77c0.17-0.06,0.21-0.2,0.23-0.37c0.84-6.6,4.32-11.39,10.06-14.61
		C12.1,1.04,14.11,0.59,16.07,0c17.27,0,34.55,0,51.82,0c0.06,0.18,0.21,0.2,0.37,0.24c3.01,0.71,5.66,2.05,7.87,4.27
		c6.96,7,13.95,13.96,20.93,20.95c0.95,0.95,1.69,2.06,2.34,3.24c0.89,1.62,1.3,3.4,1.85,5.13c0,23.99,0,47.98,0,71.98
		c-0.17,0.06-0.21,0.2-0.23,0.37c-0.84,6.6-4.32,11.39-10.06,14.61C89.14,121.8,87.13,122.25,85.17,122.84z M9.84,61.3
		c0,13.95,0,27.91,0,41.86c0,0.8,0,1.6,0.18,2.38c1.08,4.78,4.87,7.64,10.2,7.64c20.27,0.01,40.54,0,60.81,0
		c1.12,0,2.23-0.08,3.32-0.38c3.76-1.01,7.15-4.46,7.13-10.13c-0.08-21.99-0.03-43.98-0.03-65.97c0-0.36-0.03-0.72-0.03-1.08
		c0-0.98-0.41-1.37-1.46-1.35c-3.52,0.07-7.04,0.06-10.55,0.02c-7.29-0.08-13.47-6.34-13.48-13.62c0-3.32-0.03-6.64,0.02-9.96
		c0.01-0.85-0.27-1.09-1.1-1.08c-15.03,0.02-30.07-0.02-45.1,0.03c-5.96,0.02-9.9,4.16-9.9,10.12C9.84,33.63,9.84,47.46,9.84,61.3z"
		/>
	<path class="st1" d="M101.24,33.83c-0.55-1.74-0.96-3.51-1.85-5.13c-0.65-1.18-1.39-2.29-2.34-3.24
		C90.08,18.47,83.09,11.5,76.13,4.51c-2.21-2.22-4.86-3.56-7.87-4.27C68.1,0.2,67.96,0.18,67.89,0c10.82,0,21.63,0.01,32.45-0.02
		c0.75,0,0.92,0.17,0.92,0.92C101.23,11.88,101.24,22.85,101.24,33.83z"/>
	<path class="st1" d="M16.07,0c-1.96,0.59-3.97,1.04-5.78,2.06C4.55,5.28,1.07,10.07,0.23,16.67C0.21,16.83,0.17,16.97,0,17.03
		C0,11.62,0.01,6.2-0.02,0.78c0-0.66,0.13-0.8,0.79-0.8C5.87,0.02,10.97,0,16.07,0z"/>
	<path class="st1" d="M0,105.81c0.49,0.67,0.28,1.49,0.45,2.24c1.79,7.45,7.83,13.39,15.37,14.59c0.09,0.01,0.17,0.14,0.25,0.21
		c-5.1,0-10.2-0.02-15.3,0.02c-0.67,0-0.8-0.14-0.79-0.8C0.01,116.64,0,111.22,0,105.81z"/>
	<path class="st1" d="M85.17,122.84c1.96-0.59,3.97-1.04,5.78-2.06c5.74-3.22,9.22-8.01,10.06-14.61c0.02-0.17,0.06-0.31,0.23-0.37
		c0,5.44-0.01,10.88,0.02,16.31c0,0.6-0.14,0.74-0.74,0.74C95.4,122.83,90.29,122.84,85.17,122.84z"/>
	<path class="st1" d="M9.84,61.3c0-13.83,0-27.67,0-41.5c0-5.97,3.95-10.1,9.9-10.12c15.03-0.06,30.07-0.01,45.1-0.03
		c0.82,0,1.11,0.23,1.1,1.08c-0.04,3.32-0.02,6.64-0.02,9.96c0.01,7.29,6.19,13.55,13.48,13.62c3.52,0.04,7.04,0.05,10.55-0.02
		c1.06-0.02,1.46,0.37,1.46,1.35c0,0.36,0.03,0.72,0.03,1.08c0,21.99-0.05,43.98,0.03,65.97c0.02,5.67-3.37,9.12-7.13,10.13
		c-1.09,0.29-2.2,0.38-3.32,0.38c-20.27,0-40.54,0-60.81,0c-5.33,0-9.12-2.86-10.2-7.64c-0.18-0.79-0.18-1.59-0.18-2.38
		C9.84,89.21,9.84,75.25,9.84,61.3z M50.65,59.74c-8.43,0-16.87-0.02-25.3,0.01c-4.46,0.01-7.27,4.67-5.13,8.45
		c1.23,2.17,3.22,2.98,5.61,2.99c5.72,0.02,11.43,0.01,17.15,0.01c10.75,0,21.5,0,32.26,0c2.04,0,3.89-0.49,5.21-2.16
		c1.46-1.85,1.75-3.9,0.7-6.04c-1.07-2.18-2.94-3.22-5.3-3.23C67.44,59.72,59.05,59.74,50.65,59.74z M50.74,84.21
		c-8.39,0-16.79,0-25.18,0c-1.58,0-2.99,0.47-4.16,1.52c-1.77,1.58-2.36,3.96-1.56,6.09c0.9,2.4,2.96,3.83,5.78,3.83
		c16.67,0.02,33.33,0.02,50,0c1.87,0,3.56-0.58,4.77-2.08c1.48-1.83,1.82-3.89,0.8-6.04c-1.06-2.23-2.96-3.3-5.38-3.31
		C67.45,84.19,59.1,84.21,50.74,84.21z M39.93,35.27c-4.87,0-9.75-0.01-14.62,0c-2.43,0.01-4.57,1.46-5.41,3.63
		c-1.55,3.96,1.35,7.82,5.92,7.82c9.39,0.02,18.77,0,28.16,0.01c0.76,0,1.51-0.09,2.24-0.31c2.78-0.86,4.44-3.52,4.01-6.4
		c-0.38-2.55-2.93-4.73-5.67-4.74C49.67,35.25,44.8,35.27,39.93,35.27z"/>
	<path class="st2" d="M50.65,59.74c8.39,0,16.79-0.02,25.18,0.02c2.36,0.01,4.23,1.05,5.3,3.23c1.05,2.14,0.76,4.19-0.7,6.04
		c-1.32,1.67-3.17,2.16-5.21,2.16c-10.75,0-21.5,0-32.26,0c-5.72,0-11.43,0.01-17.15-0.01c-2.38-0.01-4.38-0.82-5.61-2.99
		c-2.14-3.78,0.67-8.43,5.13-8.45C33.79,59.72,42.22,59.74,50.65,59.74z"/>
	<path class="st2" d="M50.74,84.21c8.35,0,16.71-0.02,25.06,0.01c2.42,0.01,4.32,1.08,5.38,3.31c1.02,2.15,0.68,4.21-0.8,6.04
		c-1.21,1.49-2.9,2.08-4.77,2.08c-16.67,0.01-33.33,0.02-50,0c-2.82,0-4.88-1.43-5.78-3.83c-0.8-2.13-0.21-4.51,1.56-6.09
		c1.17-1.05,2.58-1.52,4.16-1.52C33.95,84.22,42.35,84.21,50.74,84.21z"/>
	<path class="st2" d="M39.93,35.27c4.87,0,9.75-0.02,14.62,0.01c2.74,0.02,5.3,2.19,5.67,4.74c0.43,2.88-1.23,5.54-4.01,6.4
		c-0.72,0.22-1.48,0.31-2.24,0.31c-9.39,0-18.77,0.01-28.16-0.01c-4.57-0.01-7.47-3.86-5.92-7.82c0.85-2.16,2.98-3.62,5.41-3.63
		C30.18,35.26,35.05,35.27,39.93,35.27z"/>
</g>
</svg>

 <a href = "<%=request.getContextPath()%>/board/list.jsp?board_id=<%= menuList.get(i).getBoard_id()%>"><%= menuList.get(i).getBoardName() %></a></li>
<%
      	}
%>
  </ul>
</nav>
</div>
<script>
function infoData1(){
		var d2 = document.getElementById("info-data2");
		var d1 = document.getElementById("info-data1");
		d2.style.display = "none";
		d1.style.display = "block";
		document.getElementById("cafeInfo").classList.add("infoTextActive");
		document.getElementById("myInfo").classList.remove("infoTextActive");
}
function infoData2(){
		var d1 = document.getElementById("info-data1");
		var d2 = document.getElementById("info-data2");
		d1.style.display = "none";
		d2.style.display = "block";
		document.getElementById("myInfo").classList.add("infoTextActive");
		document.getElementById("cafeInfo").classList.remove("infoTextActive");
}
</script>
<div class = "main-area"> 

