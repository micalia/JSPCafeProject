<%@ page import="org.apache.commons.codec.binary.Base64"%>
<%@ page import="java.time.Instant"%>
<%@ page import="java.io.ByteArrayInputStream"%>
<%@ page import="java.io.ByteArrayOutputStream"%>
<%@ page import="javax.imageio.ImageIO"%>
<%@ page import="java.awt.image.BufferedImage"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page import="java.io.File"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% 
String data;
String imageName;
data = request.getParameter("image");
String[] image_array_1 = data.split(";");
String[] image_array_2 = image_array_1[1].split(",");
byte[] decodeBytes = Base64.decodeBase64(image_array_2[1]);
long unixTime = Instant.now().getEpochSecond();
imageName = unixTime + ".png";
String uploadFolder = "cafeAdmin/cafeProfile/upload/" + imageName;
ServletContext context = getServletContext();
String uploadPath = context.getRealPath(uploadFolder);
BufferedImage bufImg = ImageIO.read(new ByteArrayInputStream(decodeBytes));
ByteArrayOutputStream baos = new ByteArrayOutputStream();
ImageIO.write(bufImg, "png", baos);
ImageIO.write(bufImg, "png", new File(uploadPath));
baos.flush();
byte[] imageInByteArray = baos.toByteArray();
baos.close();
String b64 = javax.xml.bind.DatatypeConverter.printBase64Binary(imageInByteArray);

%>
<img src="data:image/jpg;base64, <%=b64%>" class="img-thumbnail" /> 
<input type="hidden" id="imageData" value="<%=request.getContextPath()%>/<%=uploadFolder%>">
