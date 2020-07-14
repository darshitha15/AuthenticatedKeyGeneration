
<%@page import="com.sun.org.apache.xerces.internal.impl.dv.util.Base64"%>
<%@page import="action.Mail"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.math.BigInteger"%>
<%@page import="action.encryption"%>
<%@page import="action.Conv"%>
<%@page import="com.oreilly.servlet.*,java.sql.*,DBCon.*,java.util.*,java.io.*,javax.servlet.*, javax.servlet.http.*"%>
<%@page import=" java.security.MessageDigest"%>
<%@page import=" java.security.*"%>
<%@page import="javax.crypto.*"%>
<html>
<head>
</head>
<body>
<%
Thread.sleep(100);
ArrayList list = new ArrayList();
		ServletContext context = getServletContext();

		String dirName =context.getRealPath("\\uploads\\");
		String paramname=null;
	     int id=0;
		String image=null,skey=null;
		  File file1 = null;
			String emails[];
		    emails=new String[100];
		try {
			 
			MultipartRequest multi = new MultipartRequest(request, dirName,	10 * 1024 * 1024); // 10MB

			Enumeration params = multi.getParameterNames();
			while (params.hasMoreElements()) 
			{
				paramname = (String) params.nextElement();
				
				
				if(paramname.equalsIgnoreCase("emails"))
				{
				   String emails2[]=multi.getParameterValues(paramname);
				   emails=new String[emails2.length];
				   for(int i=0;i<emails2.length;i++)
				   {
					   emails[i]=emails2[i];
				   }
				}
				
				if(paramname.equalsIgnoreCase("skey"))
				{
					skey=multi.getParameter(paramname);
				}
				

				if(paramname.equalsIgnoreCase("image"))
				{
					image=multi.getParameter(paramname);
				}
			}

			
						int f = 0;
	Enumeration files = multi.getFileNames();	
	while (files.hasMoreElements()) 
	{
		paramname = (String) files.nextElement();
		if(paramname.equals("d1"))
		{
			paramname = null;
		}
		
		if(paramname != null)
		{
			f = 1;
			image = multi.getFilesystemName(paramname);
			String fPath = context.getRealPath("\\uploads\\"+image);
			file1 = new File(fPath);
			FileInputStream fs = new FileInputStream(file1);
			list.add(fs);
		}		
	}

	        FileInputStream fs1 = null;
            
			Connection con=databasecon.getconnection(); 
            Statement st=con.createStatement();
            PreparedStatement ps=null;
            
         BigInteger plaintext;
            BigInteger ciphertext ;
            String text1;
            String a;
          
            fs1 = (FileInputStream)list.get(0);
            
            BufferedReader br = null;
      		StringBuilder sb = new StringBuilder();

      		String line;
      		try {

      			br = new BufferedReader(new InputStreamReader(fs1));
      			while ((line = br.readLine()) != null) {
      				sb.append(line);
      			}

      		} catch (Exception e) {
      			e.printStackTrace();
      		}
      	     	a=sb.toString();
      	     	text1 =a;
      	      /*  
      	      plaintext = new BigInteger(text1.getBytes());
      	      ciphertext = rsa.encrypt(plaintext);
      	    
      	      */
      	      
      	    KeyGenerator keyGen = KeyGenerator.getInstance("AES");
              keyGen.init(128);
              SecretKey secretKey = keyGen.generateKey();
              System.out.println("secret key:" + secretKey);
              //converting secretkey to String
              byte[] be = secretKey.getEncoded();//encoding secretkey
              String skey2 = Base64.encode(be);
              System.out.println("converted secretkey to string:" + skey2);
              String cipherText = new encryption().encrypt(a, secretKey);
              
      	      
      	   
      	      
      	      
       	for(int j=0;j<emails.length;j++)
            	{
             ps=con.prepareStatement("insert into files(uid,email,fname,skey,skey2,file,datee) values(?,?,?,?,?,'"+cipherText+"',now())");
             ps.setInt(1,(Integer)session.getAttribute("uid"));
             ps.setString(2,emails[j]);
			 ps.setString(3,image);	
			 ps.setString(4,skey);	
			 ps.setString(5,skey2);	
		 //    ps.setString(5,ciphertext.toString());
		   	ps.executeUpdate();
		   	String msg="The Session Key for the file "+image+" is "+skey;
		   	Mail.secretMail(msg,emails[j], emails[j]);
            	}
            JOptionPane.showMessageDialog(null, "File Sent Successfully");
            response.sendRedirect("send.jsp");
        } 
		catch (Exception e) 
		{   
			System.out.println(e);
		}
	
 %>
</body>
</html>