<%@ include file="uhead.jsp" %>
<div style="position: absolute; top:200px; left:525px;">
<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.util.Random"%>
<%@ page import="java.sql.*,DBCon.*,java.math.*" %>
<% 
int fid=Integer.parseInt(request.getParameter("fid"));
%>
<form action="download1.jsp">
<center><h2>SESSION VERIFICATION</h2></center>
<table border="1">
<tr><td>File ID</td><td><input type=text name=fid value="<%=fid%>" readonly></td></tr>
<tr><td>Enter Session key</td><td><input type=text name=skey required Title="Plese Enter Session key"></td></tr>
<tr><td>Enter User key</td><td><input type=text name=ukey required Title="Plese Enter User key"></td></tr>
<tr><td></td><td><input type=submit value=Verify></td></tr>
</table>
</form>