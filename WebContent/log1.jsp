<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.util.Random"%>
<%@ page import="java.sql.*,DBCon.*,java.math.*" %>
<% 
String email=request.getParameter("email");
String pass=request.getParameter("pass");

try{
Connection con =databasecon.getconnection();
Statement st=con.createStatement();
ResultSet rs=st.executeQuery("select * from user where email='"+email+"' and pass='"+pass+"'");
if(rs.next())
{
	session.setAttribute("uid",rs.getInt(1));
	session.setAttribute("name",rs.getString(2));
	response.sendRedirect("user.jsp");
}else
{
	JOptionPane.showMessageDialog(null, "Invalid Login Details");
	response.sendRedirect("log.jsp");
}
}catch(Exception e){System.out.println(e);}









%>