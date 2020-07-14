<%@page import="javax.swing.JOptionPane"%>
<%
JOptionPane.showMessageDialog(null, "Requested to KGC");

String url="send.jsp?skey=Requested";
response.sendRedirect(url);

%>