<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.util.Random"%>
<%@ page import="java.sql.*,DBCon.*,java.math.*" %>
<% 
String name=request.getParameter("name");
String email=request.getParameter("email");
String pass=request.getParameter("pass");
String ip=request.getParameter("ip");
String port=request.getParameter("port");

int x=(int)(Math.random()*10000);
String ukey=Integer.toString(x);
try{
	
Connection con =databasecon.getconnection();
Statement st=con.createStatement();
int i=st.executeUpdate("insert into user(name,email,pass,ip,port,ukey)values('"+name+"','"+email+"','"+pass+"','"+ip+"','"+port+"','"+ukey+"')");
if(i!=0)
{
	JOptionPane.showMessageDialog(null, "Node Registered Successfully");
	JOptionPane.showMessageDialog(null, "Your User Key is:  " +ukey);
	response.sendRedirect("index.jsp");

}else
{
	JOptionPane.showMessageDialog(null, "Node Registration Fails");
	response.sendRedirect("index.jsp");


}
}catch(Exception e){System.out.println(e);}









%>