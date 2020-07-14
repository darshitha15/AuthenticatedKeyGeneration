<%@ include file="uhead.jsp" %>
<div style="position: absolute; top:200px; left:480px;">
<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.util.Random"%>
<%@ page import="java.sql.*,DBCon.*,java.math.*" %>
<% 
int uid=(Integer)session.getAttribute("uid");

try{
Connection con =databasecon.getconnection();
Statement st=con.createStatement();
Statement st2=con.createStatement();
ResultSet rs2=null;String url=null;
ResultSet rs=st.executeQuery("select * from user where uid='"+uid+"'");
if(rs.next())
{
	rs2=st2.executeQuery("select * from files where email='"+rs.getString(3)+"'");%>
	<center><h2>RECEIVER</h2></center>
	<table border=1><tr><th>File ID</th><th>From</th><th>File Name</th><th>Date</th><th>Download</th></tr>
	<%while(rs2.next())
	{
	url="download.jsp?fid="+rs2.getInt(1);
	%>
		<tr><td><%=rs2.getInt(1)%></td><td><%=rs.getString(2)%></td><td><%=rs2.getString(4)%></td><td><%=rs2.getString(8)%></td><td><a href="<%=url%>">Download</a></td></tr>
	<%}%>
</table>
<%}

}catch(Exception e){System.out.println(e);}
%>