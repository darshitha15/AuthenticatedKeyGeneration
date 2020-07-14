<script>
function validation()
{
var a=document.s.skey.value;
if(a=="null")
{
alert("Please Put Request For KGC And Retrive The Session Key");
document.s.skey.focus();
return false;
}
if(a=="Requested")
{
alert("Please Retrive The Session Key");
document.s.skey.focus();
return false;
}
}
</script>
<%@ include file="uhead.jsp" %>
<div style="position: absolute; top:200px; left:525px;">
<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.util.Random"%>
<%@ page import="java.sql.*,DBCon.*,java.math.*" %>
<% 
String skey=null;
String url2=null;

int uid=(Integer)session.getAttribute("uid");
skey=request.getParameter("skey");
url2="retrive.jsp?skey="+skey;
try{
Connection con =databasecon.getconnection();
Statement st=con.createStatement();
ResultSet rs=st.executeQuery("select * from user where uid!='"+uid+"'");%>
<form action="upload.jsp" method=post ENCTYPE="multipart/form-data" name="s" onsubmit="return validation();">
<center><h2>TRANSMISSION</h2></center>
<table>
<tr><td>Destination</td><td><select name="emails" multiple="multiple" required Title="Empty Users list">
<% while(rs.next()){ %>
<option value="<%=rs.getString(3)%>"><%=rs.getString(2)%></option>
<%} %>
</select></td></tr>
<tr><td>Key</td><td><input type=text name=skey placeholder="Enter Session Key" value="<%=skey%>" readonly></td></tr>
<tr><td>File</td><td><input type=file name=image required Title="Please Select File to Send"></td></tr>
<tr><td><input type=reset value="Clear"></td><td><input type=submit value="Send File"></td></tr>
</form>
<tr><td><a href="request.jsp"><input type=button value="Request"></a></td><td><a href="<%=url2 %>"><input type=button value="Retrive Session Key"></a></td></tr>
</table>
<%
}catch(Exception e){System.out.println(e);}

%>
