<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,java.util.Date,java.io.*,java.text.SimpleDateFormat"   errorPage="" %>
<%@ include file="settings.jsp" %>
<%
Class.forName(driverName);
Connection conn=null;
PreparedStatement ps=null;
String[] id;
java.util.Date date= new java.util.Date();
String format="yyyy-MM-dd";
SimpleDateFormat formated=new SimpleDateFormat(format);
String finalformat=formated.format(date);
String username=(String)session.getAttribute("usernamesession");
String password=(String)session.getAttribute("passwordsession");
String add=(String)session.getAttribute("sessionadd");
int add1=Integer.parseInt(add);
String read=(String)session.getAttribute("sessionread");
int read1=Integer.parseInt(read);
String delete=(String)session.getAttribute("sessiondelete");
int delete1=Integer.parseInt(delete);
String update=(String)session.getAttribute("sessionupdate");
int update1=Integer.parseInt(update);
String companyact=request.getParameter("companyact");
System.out.println(companyact);
   if(companyact.equals("Activate"))
      {
	   id=request.getParameterValues("compid");
	   for(int j=0;j<id.length;j++)
          {
		  try{
		  conn=DriverManager.getConnection(conStr, dbUser, dbPwd); 
          ps=conn.prepareStatement(" update agentregistration set loginstatus=1 where agentid='"+id[j]+"'"            );
		  ps.execute();
		  ps.close();
		  conn.close();
		  }catch(Exception e){out.print(e);}
		  String success="The Selected id's activated Successfully";
		  request.setAttribute("message",success);
		  
          }
	    
	  
	  }
	  if(companyact.equals("Deactivate"))
      {
	   id=request.getParameterValues("compid");
	   for(int j=0;j<id.length;j++)
          {
		  try{
		  conn=DriverManager.getConnection(conStr, dbUser, dbPwd); 
          ps=conn.prepareStatement(" update agentregistration set loginstatus=0 where agentid='"+id[j]+"' "       );
		  ps.execute();
		  }
		  catch(Exception e){out.print(e);}
		  String success="The Selected id's Deactivated Successfully";
		  request.setAttribute("message",success);
          }
	    
	  
	  }
	  if(companyact.equals("Delete"))
      {
	   id=request.getParameterValues("compid");
	   for(int j=0;j<id.length;j++)
          {
		  try{
		  conn=DriverManager.getConnection(conStr, dbUser, dbPwd); 
          ps=conn.prepareStatement(" delete from agentregistration  where agentid='"+id[j]+"' ");
		  ps.execute();
		  ps.close();
		  conn.close();
		  }catch(Exception e){out.print(e);}
		  String success="The Selected id's Deleted Successfully";
		  request.setAttribute("message",success);
          }
	    
	  
	  }
	  
   
   
 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
</head>

<body>
<table>
<% 
  
    String result=(String)request.getAttribute("message");
	
  
  %>
  
  
  <tr>
    <td> <%=result%></td>
  </tr>
  <tr>
     
    <td><a href="/admin/Agentandcompanyactdeact.jsp">Click here to go back to Agent/Company View List page</a></td>
  </tr>
</table>
</body>
</html>
