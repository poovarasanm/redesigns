<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,java.text.SimpleDateFormat,java.util.Date" errorPage="" %>
<%@ include file="settings.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
</head>
<body>
<%
String companyname=request.getParameter("companyname");
String industry=request.getParameter("industry");
String contactperson=request.getParameter("contactperson");
String address=request.getParameter("address");
String emailid=request.getParameter("emailid");
String phoneno=request.getParameter("phoneno");
String mobileno=request.getParameter("mobileno");
String website=request.getParameter("website");
String username=request.getParameter("username");
String password=request.getParameter("password");
String type1=request.getParameter("type1");
System.out.println(""+type1);
int act=1;
java.util.Date now = new java.util.Date();
String DATE_FORMAT = "yyyy-MM-dd hh-mm-ss a";
SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
String currentTime = sdf.format(now);
%>
<%
Class.forName(driverName);
Connection conn=DriverManager.getConnection(conStr, dbUser, dbPwd);
PreparedStatement ps=conn.prepareStatement("insert into company_registration(CR_name ,CR_industry_type ,CR_contact_person ,CR_Address ,CR_email_id ,CR_phone_no ,CR_mobile_no ,CR_Website ,CR_username ,CR_password ,CR_payment_type,CR_date_time,CR_act_deact) values ('"+companyname+"','"+industry+"','"+contactperson+"','"+address+"','"+emailid+"','"+phoneno+"','"+mobileno+"','"+website+"','"+username+"','"+password+"','"+type1+"','"+currentTime+"','"+act+"')");
ps.execute();
PreparedStatement ps1=conn.prepareStatement("select CR_code_id from company_registration where CR_username='"+username+"'");
ResultSet rs1=ps1.executeQuery();
if(rs1.next())
 {
   String code=rs1.getString(1);
  PreparedStatement ps2=conn.prepareStatement("insert into   company_change_password(CCP_company_code,CCP_new_password,CCP_changed_date_time) values('"+code+"','"+password+"','"+currentTime+"')");
  ps2.execute();
  rs1.close();
  ps2.close();
  }

%>
<table width="627" height="149" border="0" align="center">
  <tr>
    <td width="220">Company Registration:</td>
    <td width="175">Registered Successfully</td>
  </tr>
  <tr>
    <td><a href="/admin/companyregistration.jsp">Click  here to go back to company registration</a></td>
    <td>&nbsp;</td>
  </tr>
</table>

</body>
</html>
<%

conn.close();%>
