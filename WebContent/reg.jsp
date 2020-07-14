<%@ include file="mhead.jsp" %>
<div style="position: absolute; top:200px; left:525px;">
<%@page import="java.net.InetAddress" %>
<%
String ip=null;
InetAddress inetAddress = InetAddress.getLocalHost();
ip = inetAddress.getHostAddress();
%>
<form action="reg1.jsp">
<center><h2>NEW USER REGISTRATION</h2></center>
<table>
<tr><td>Name</td><td><input type=text name=name placeholder="Enter Name" required Title="Please Enter Name"></td></tr>
<tr><td>Email</td><td><input type=email name=email placeholder="Enter Email ID" required Title="Please Email ID"></td></tr>
<tr><td>Password</td><td><input type=password name=pass placeholder="Enter password" required Title="Please Enter Password"></td></tr>
<tr><td>IP Address</td><td><input type=text name=ip readonly value="<%=ip%>"></td></tr>
<tr><td>Port Number</td><td><input type=text name=port placeholder="Enter Port Number" required Title="Please Enter Port Number"></td></tr>
<tr><td></td><td><input type=submit value="REGISTER"></td></tr>
</table>
</form>
