<%@page import="action.decryption"%>

<%@page import="java.io.BufferedReader"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.util.Random"%>
<%@ page import="java.sql.*,DBCon.*,java.math.*" %>
<% 
int uid=(Integer)session.getAttribute("uid");
int fid=Integer.parseInt(request.getParameter("fid"));
String ukey=request.getParameter("ukey");
String skey=request.getParameter("skey");
String fname=null,fdata=null;
try{
Connection con =databasecon.getconnection();
Statement st=con.createStatement();
Statement st2=con.createStatement();
Statement st3=con.createStatement();
ResultSet rs2=null,rs3=null;String url=null;
ResultSet rs=st.executeQuery("select * from user where uid='"+uid+"'");
if(rs.next())
{  
	if(rs.getString(7).equals(ukey))
	{
		
	   rs2=st2.executeQuery("select * from files where fid='"+fid+"'");
	  if(rs2.next())
	   {
		  if(rs2.getString(5).endsWith(skey)){
			  
			  rs3=st3.executeQuery("SELECT TIMESTAMPDIFF(SECOND,'"+rs2.getString(8)+"',now())");
			 if(rs3.next()){
			  if(rs3.getInt(1)<=120){
			  
			  fname=rs2.getString(4);
			String  ciphertext=rs2.getString(7);
			
			String content = new decryption().decrypt(ciphertext, rs2.getString(6));
		      response.setHeader("Content-Disposition", "attachment;filename=\"" + fname + "\"");
	          out.write(content.trim());
			  }else
			  {
				  JOptionPane.showMessageDialog(null, "File Session is Expaired");
					url="user.jsp";
					response.sendRedirect(url);
			  }}
	    }
		  else
	     {
			  JOptionPane.showMessageDialog(null, "Invalid Session Key");
				url="download.jsp?fid="+fid;
				response.sendRedirect(url);
	     }
	   }else
	   {
		   JOptionPane.showMessageDialog(null, "Session Expaired");
			url="user.jsp";
			response.sendRedirect(url);
	   }
	}else{
		 
		JOptionPane.showMessageDialog(null, "Invalid User Key");
		url="download.jsp?fid="+fid;
		response.sendRedirect(url);
	}
	
}

}catch(Exception e){System.out.println(e);}
%>