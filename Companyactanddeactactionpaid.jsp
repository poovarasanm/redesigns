<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,java.util.Date,java.io.*,java.text.SimpleDateFormat"   errorPage="" %>
<%@ include file="settings.jsp" %>
<%
Class.forName(driverName);
Connection conn=DriverManager.getConnection(conStr, dbUser, dbPwd);
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
          PreparedStatement ps=conn.prepareStatement(" update company_registration set CR_act_deact=1 where CR_code_id='"+id[j]+"'"            );
		  ps.execute();
		  String success="The Selected id's activated Successfully";
		  request.setAttribute("message",success);
		  ps.close();
		  }catch(Exception e){}
          }
	    
	  
	  }
	  if(companyact.equals("Deactivate"))
      {
	   id=request.getParameterValues("compid");
	   for(int j=0;j<id.length;j++)
          {
		  try{
          PreparedStatement ps1=conn.prepareStatement(" update company_registration set CR_act_deact=0 where CR_code_id='"+id[j]+"'"            );
		  ps1.execute();
		  String success="The Selected id's Deactivated Successfully";
		  request.setAttribute("message",success);
		  ps1.close();
		  }catch(Exception e){}
          }
	    
	  
	  }
	  if(companyact.equals("Delete"))
      {
	   id=request.getParameterValues("compid");
	   for(int j=0;j<id.length;j++)
          {
		  try{
          PreparedStatement ps1=conn.prepareStatement(" delete from company_registration  where CR_code_id='"+id[j]+"'"            );
		  ps1.execute();
		  String success="The Selected id's Deleted Successfully";
		  request.setAttribute("message",success);
		  ps1.close();
		  }catch(Exception e){}
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
<% if(companyact.equals("Userlist"))
    {
	int i=1;
	%>
	<form>
     <table width="100%" border="1">
	 <tr>
	   <td colspan="7"><a href="/admin/Companyactanddeactpaid.jsp">Click here to go back to paid Company act/deact page</a></td>
	 </tr>
        <tr>
	   <td width="5%">SL.No</td>
       <td width="19%">Company Name</td>
	   <td width="19%">Company Address</td
	   ><td width="17%">Contact Person</td>
	   <td width="12%">Phone No</td>
	   <td width="11%">Mobile No</td>
	   <td width="14%">Email Id</td>
	   </tr>
	   <%
	     id=request.getParameterValues("compid");
	      for(int j=0;j<id.length;j++)
          {
          PreparedStatement ps2=conn.prepareStatement(" select CR_name ,CR_industry_type ,CR_contact_person ,CR_Address ,CR_email_id ,CR_phone_no ,CR_mobile_no ,CR_Website ,CR_username ,CR_password ,CR_payment_type,CR_date_time,CR_act_deact,CR_code_id,CR_Address from company_registration  where CR_code_id='"+id[j]+"'" );
		  ResultSet rs2=ps2.executeQuery();
	
	   
	    while(rs2.next())
		  {
		  
		  %>
    <tr>
    
    <td width="5%" ><%=i%></td>
	 
    <td width="19%" ><%=rs2.getString("CR_name")%></td>
   
	<td width="17%"><%=rs2.getString("CR_Address")%></td>
	
	<td width="17%"><%=rs2.getString("CR_contact_person")%></td>
 
    <td width="12%" ><%=rs2.getString("CR_phone_no")%></td>
	
	<td width="11%" ><%=rs2.getString("CR_mobile_no")%></td>
	
	<td width="14%" ><%=rs2.getString("CR_email_id")%></td>
			
  </tr>
   
   <%
       
          }
		  
    %>
	<%
	   i=i+1;
	   }
	%>

</table>

</form>


<%}
else
      {%>
	  
	  <form>
  <table width="100%" border="0">
  <% 
  
    String result=(String)request.getAttribute("message");
	
  
  %>
  
  
  <tr>
    <td> <%=result%></td>
  </tr>
  
  
  <tr>
     
    <td><a href="/admin/Companyactanddeactpaid.jsp">Click here to go back to Company View List page</a></td>
  </tr>
</table>
</form>
<%}%>
</body>
</html>
