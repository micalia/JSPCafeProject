<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="boards.BoardsDAO" %>
    <%@ page import="boards.Board_ids" %>
    <%@ page import="java.util.ArrayList" %>
<%@ include file="./layouts/checkPermission.jsp" %>
<center style="margin-top:42px;">
    <a href="<%=request.getContextPath()%>/home.jsp">
      <img src="<%=request.getContextPath()%>/img/cafeLogo.png"style="height:61px;">
    </a>
</center>
<style>
#menuList{
    border:1px solid black;
    width:513px;
    height:400px;
    margin-top:9px;
}
ul{
    list-style:none;
    padding-left:0px;
    margin-top:6px;
    margin-bottom:6px;
}
label{
    cursor: pointer;
}
#contentBox{
	width:517px;
	overflow:hidden;
	margin:0 auto;
	margin-top:20px;
}
</style>
<div id="contentBox">
<form action="insertMenu.jsp" method="post">
    메뉴 추가
    <input type="text" name="boardName" autocomplete="off" autofocus maxlength="20">
    <input type="submit" value="추가">
  </form>

메뉴이름 수정 
    <input type="text" id="changeMenu"style="margin-top:6px;" readonly maxlength="20"> => <input type="text" id="changeMenuAction" maxlength="20">
    <button class="update">수정</button><br>

<button class="delete" style="margin-top:6px;">선택한 메뉴 삭제</button>
<div id="menuList">
    <ul>
     <%
      	BoardsDAO boardsDAO = new BoardsDAO();
      	ArrayList<Board_ids> menuList = boardsDAO.mainGetMenuList();
      	for(int i = 0; i < menuList.size(); i++){
      %>
    <li><input type="checkbox" id = "chk_<%= menuList.get(i).getBoard_id() %>" name="checkbox"class="checkbox" data-id="<%= menuList.get(i).getBoard_id() %>" onclick="checkOnly(this)"><span id="li_<%= menuList.get(i).getBoard_id() %>"><label for="chk_<%= menuList.get(i).getBoard_id() %>"><%= menuList.get(i).getBoardName() %></label></span></li>
          <% } %>
    </ul>
</div>

</div>

  <script
  src="https://code.jquery.com/jquery-3.4.1.min.js"
  integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
  crossorigin="anonymous"></script>
  <script type="text/javascript">

  function checkOnly(chk){
      var obj = document.getElementsByName("checkbox");
      for(var i=0; i<obj.length;i++){
        if(obj[i] != chk){
          obj[i].checked=false;
        }
      }
    }
    $(document).ready(function () {

         $('.checkbox').on('click',function(){

        // $('.checkbox:checked').each(function() {
            $("#changeMenu").val($("label[for="+this.id+"]").text());
            $("#changeMenu").attr('data-id',($(this).attr('data-id')));

        // });
         });

        $('.delete').on('click', function(e) {

            var idsArr = [];
            $(".checkbox:checked").each(function() {
                idsArr.push($(this).attr('data-id'));
            });

            if(idsArr.length <=0)
            {
                alert("삭제할 카테고리를 선택해주세요");
            }  else {

                if(confirm("정말로 선택한 카테고리를 지우시겠습니까?")){

                    var strIds = idsArr.join(",");

                    $.ajax({
                        url: "deleteMenu.jsp",
                        type: 'post',
                        data: 'board_id='+strIds,
                        success: function (data) {
                        	console.log(data);
                            if (data['status']==true) {
                                $(".checkbox:checked").each(function() {
                                    $(this).parents("li").remove();
                                });
                                $("#changeMenu").val('');
                                $("#changeMenu").attr('data-id','');
                                alert(data['message']);
                            } else {
                                alert('오류가 발생했습니다');
                            }
                        },
                        error: function (data) {
                            alert(data.error);
                        }
                    });

                }
            }
        });

        $('.update').on('click', function(e) {
            var id=$("#changeMenu").attr('data-id');
            var changeName=$("#changeMenuAction").val();

            $.ajax({
                        url: "updateMenu.jsp",
                        type: 'post',
                        data: {
                        		'board_id':id,
                                'boardName':changeName
                            },
                        success: function (data) {
                            if (data['status']==true) {
                                changeList='chk_'.concat(id);
                                $("label[for="+changeList+"]").html(changeName);
                                alert(data['message']);
                            } else {
                                alert('오류가 발생했습니다');
                            }
                        },
                        error: function (data) {
                            alert(data.responseText);
                        }
                    });
        });
    });
</script>
</body>
</html>