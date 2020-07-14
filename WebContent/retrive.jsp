<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.sun.org.apache.xerces.internal.impl.dv.util.Base64"%>
<%@page import="javax.crypto.SecretKey"%>
<%@page import="javax.crypto.KeyGenerator"%>
<%
String skey2=request.getParameter("skey");
if(skey2.equals("Requested"))
{
	KeyGenerator keyGen = KeyGenerator.getInstance("AES");
	keyGen.init(128);
	SecretKey secretKey = keyGen.generateKey();
	byte[] be = secretKey.getEncoded();//encoding secretkey
	String skey = Base64.encode(be);
	JOptionPane.showMessageDialog(null, "Your Session Key Is "+skey);
	String url="send.jsp?skey="+skey;
	response.sendRedirect(url);
}
else
{
	JOptionPane.showMessageDialog(null, "Please Put Request For KGC");
	String url="send.jsp?skey=";
	response.sendRedirect(url);
}

%>