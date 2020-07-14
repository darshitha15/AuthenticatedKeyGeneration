<%@ include file="uhead.jsp" %>
<div style="position: absolute; top:250px; left:480px;">
<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.util.Random"%>
<%@ page import="java.sql.*,DBCon.*,java.math.*" %>
<% 
int uid=(Integer)session.getAttribute("uid");

try{
Connection con =databasecon.getconnection();
Statement st=con.createStatement();
ResultSet rs=st.executeQuery("select ukey from user where uid='"+uid+"'");
while(rs.next())
{%>
	<div class="key">Your User Key is : <%=rs.getString(1)%></div>
<%}
}catch(Exception e){System.out.println(e);}









%>