package users;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UsersRegisterServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String id=request.getParameter("id");
		String password=request.getParameter("password");
		String nick=request.getParameter("nick");
		String born=request.getParameter("born");
		String gender=request.getParameter("gender");
		String email=request.getParameter("email");
		String phone=request.getParameter("phone");
		if(id == null || id.equals("") || password == null || password.equals("") 
					|| nick.equals("") || nick == null || born.equals("") || born.equals("") 
					|| gender.equals("") || gender == null || email.equals("") || email.equals("") 
					|| phone.equals("") || phone == null
				) {
			
		}
	}
}
