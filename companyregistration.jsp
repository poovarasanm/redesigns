<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,java.util.Date,java.io.*,java.text.SimpleDateFormat"   errorPage="" %>
<%@ include file="settings.jsp" %>
<%
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
   int pageNo = 0;
   int row = 0;
    int size =0;
	int i = 0;
	int count = 0;
	String page_no = request.getParameter("pageNo");
	String submit = request.getParameter("Submit");
	
Class.forName(driverName);
Connection conn=DriverManager.getConnection(conStr, dbUser, dbPwd);
PreparedStatement ps13=conn.prepareStatement("select AIA_Industrial_Area_Code,AIA_Industrial_Area from admin_industrial_area order by AIA_Industrial_Area");
			  ResultSet rs13=ps13.executeQuery();
			  PreparedStatement ps9=conn.prepareStatement("select AS_State_Code,AS_State_Name from admin_state order by AS_State_Name");
			  ResultSet rs9=ps9.executeQuery();
			  
			  PreparedStatement ps10=conn.prepareStatement("select ACT_City_Code ,ACT_City_Name   from admin_city order by ACT_City_Name");
			  ResultSet rs10=ps10.executeQuery();
			  PreparedStatement ps11=conn.prepareStatement("select AC_Country_Code,AC_Country_Name from admin_country order by AC_Country_Name");
				ResultSet rs11=ps11.executeQuery();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Company Registration Page</title>
<link rel="stylesheet" href="/style.css" type="text/css" />
<script type="text/javascript" src="/script.js"></script>
<script language="javascript" type="text/javascript">
function GetSelectedItem() {

chosen = ""
len = document.registration.type1.length

for (i = 0; i <len; i++) {
if (document.registration.type1[i].checked) {
chosen = document.registration.type1[i].value
}
}

if (chosen == "") {
alert("Payment type is not choosen")
return false;
}
return true;
}
</script>

</head>

<body>

<% if(read1==1 && add1==1 && update1==1 && delete1==1)
   {
   %>
   <% if(username!=null && password!=null)
{
%>
<form action="/admin/companyregistrationaction.jsp" name="registration" onsubmit="return GetSelectedItem();">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td><table width="100%" border="0">
          <tr>
		  
            <td>
              <div align="left">
                <table width="100%" border="0">
				<tr><td colspan="2" align="left"><strong>Welcome:<%=username%></strong></td>
				  <td align="left
				  "><strong>Date:<%=finalformat%></strong></td>
				    
				 <td align="right"><a href="/admin/logout.jsp" style="text-decoration:none">sign out</a></td>
				  </tr>
                  <tr>
                    <td width="14%" height="90"><img src="/images/JobJunctionLogo.jpg" width="130" height="88" /></td>
                    <td width="20%">&nbsp;</td>
                    <td width="39%"><img src="/images/JobJunctionName.jpg" width="400" height="88" /></td>
                    <td width="27%"><img src="/images/SideImage.jpg" width="260" height="88" /></td>
                  </tr>
                </table>
              </div></td>
          </tr>
		  
          <tr >
            <td height="30" ><table width="100%" height="27%" border="0" cellpadding="0" cellspacing="0">
            <tr>
  
              <td height="30" ><table width="100%" border="0">
                <tr>
                  <td width="9%"><a  href="/admin/home2.jsp" style="text-decoration: none;"><font  size="4" color="#ffffff" ><b>Home</b></font></a>&nbsp;&nbsp;</td>
                 
                 <ul class="menu" id="menu">
	<li>
	  <div align="center"><a href="#" class="menulink">SearchType</a>
	    <ul>
	      <li><a href="/admin/ResumeSearch.jsp">Search&nbsp;Resume</a></li>
	      <li>
	        <a href="/admin/ResumeSearchBymail.jsp" >SearchBy&nbsp;Mail</a>
	        
          </li>
	      <li>
	        <a href="/admin/ResumeSearchbyphoneno.jsp" >SearchBy&nbsp;Phoneno</a>
	        
          </li>
          <li>
	        <a href="/admin/ResumeSearchbyname.jsp" >SearchBy&nbsp;Name</a>
	        
          </li>
	      
        </ul>
      </div>
	</li>
	<li>
	  <div align="center"><a href="#" class="menulink">Masters</a>
	    <ul>
	      <li><a href="/admin/Country.jsp">Country</a></li>
	      <li><a href="/admin/State.jsp" >State</a></li>      
           <li><a href="/admin/City.jsp">City</a></li>
	      <li><a href="/admin/FunctionalArea.jsp" >FunctionalArea</a></li>  
	       <li><a href="/admin/IndustrialArea.jsp">IndustrialArea</a></li>
	      <li><a href="/admin/University.jsp" >University</a></li>  
	       <li><a href="/admin/Qualification.jsp">Qualification</a></li>
	      <li><a href="/admin/QualificationMajor.jsp" >QualificationMajor</a></li>  
		  <li><a href="/admin/ServiceType.jsp">ServiceType</a></li>
	      <li><a href="/admin/Desiredjob.jsp" >DesiredJob</a></li>  
		  <li><a href="/admin/postjobbyjobjunctionfree.jsp">PostJobFree</a></li>
	      <li><a href="/admin/postjobbyjobjunctionpaid.jsp" >PostJobPaid</a></li>  
		  <li><a href="/admin/currentweekopenings.jsp">CurrentWeek</a></li>
	      <li><a href="/admin/SourceForm.jsp">Source of jobjunction</a></li>
        </ul>
      </div>
	</li>
	<li>
		<div align="center"><a href="#" class="menulink">Approval</a>
		    <ul>
		      <li><a href="/admin/Newopeningspaid.jsp">NewOpenings/paid</a></li>
		      <li>
		        <a href="/admin/Newopeningsfree.jsp" >NewOpenings/free</a></li>
		        <li>
		        <a href="/admin/Resumeview.jsp" >Registered Candidate</a></li>
	          <li>
		        <a href="/admin/editcurrentweekopenigs.jsp" >Edit current week openings</a></li>
<li>
		        <a href="/admin/selectjobposting.jsp" >Edit job posting</a></li>
	      </ul>
	  </div>
	</li>
	<li>
		<div align="center"><a href="#" class="menulink">Activiation</a>
		    <ul>
		      <li><a href="/admin/Companyactanddeactpaid.jsp">Company Paid A/D</a></li>
		      <li><a href="/admin/Companyactanddeactfree.jsp">Company Free A/D</a></li>
		      <li><a href="/admin/companyregistration.jsp">Company Registration</a></li>
		      <li><a href="/admin/userregistration.jsp">Employee Registration</a></li>
		      <li><a href="/admin/agentregistration.jsp">Agent Registration</a></li>
		      <li><a href="/admin/Userpermission.jsp">Franchise/Company registration</a></li>
              <li><a href="/admin/franchiseactanddeact.jsp">Franchise A/D</a></li>
              <li><a href="/admin/Agentandcompanyactdeact.jsp">Agent Company A/D</a></li>
              <li><a href="/admin/employeeactdeact.jsp">Employee A/D</a></li>
	      </ul>
	  </div>
	</li>
</ul>

<script type="text/javascript">
	var menu=new menu.dd("menu");
	menu.init("menu","menuhover");
</script>
                </tr>
              </table></td>
            </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
<table align="center">
<caption ><font size="+1" color="#CC3366">Company Registration</font></caption>
<tr ><td width="117">Company Name:</td>
<td width="219"><input type="text" name="companyname" id="companyname" value=""  width="160"/></td></tr>
<tr><td width="117">Industry Type:</td>
<td width="219"><select name="industry" class="ComboBox" style="width:160px">
            <option value="">Select</option>
			<%   while(rs13.next()){%>
			<option value="<%=rs13.getString("AIA_Industrial_Area")%>"><%=rs13.getString("AIA_Industrial_Area")%></option>
			
			<%}%> 
        </select></td></tr>
<tr><td width="117">Contact Person:</td>
<td width="219"><input type="text" name="contactperson" id="contactperson" value=""  width="160"/></td></tr>
<tr><td height="40">Address:</td>
<td><textarea name="address" id="address" rows="3" cols="25"></textarea></td></tr>
<tr>
    <td >City <font color="#FF0000">*</font> </td>
    <td ><select name="city" class="ComboBox" style="width:150px">
            <option value="">Select</option>
			<%   while(rs10.next()){%>
			<option value="<%=rs10.getString("ACT_City_Name")%>"><%=rs10.getString("ACT_City_Name")%></option>
			
			<%}%> 
      </select></td>
  </tr>
  <tr>
    <td >State <font color="#FF0000">*</font> </td>
    <td><select name="state" class="ComboBox" style="width:150px">
            <option value="">Select</option>
			 
			<%   while(rs9.next()){%>
			<option value="<%=rs9.getString("AS_State_Name")%>"><%=rs9.getString("AS_State_Name")%></option>
			
			<%}%> 
      </select></td>
  </tr>
  
   <tr>
    <td >Country <font color="#FF0000">*</font> </td>
    <td ><select name="country" class="ComboBox" style="width:150px">
            <option value="">Select</option>
			<%   while(rs11.next()){%>
			<option value="<%=rs11.getString("AC_Country_Name")%>"><%=rs11.getString("AC_Country_Name")%></option>
			
			<%}%> 
			
      </select></td>
  </tr>
  <tr>
     <td align="center">Zip code or Pin Code</td>
	 <td><input type="text" name="pincode" size="25" /></td>
  <tr>
<tr><td>EmailID:</td><td><input type="text" name="emailid" id="emailid" value="" width="160"/></td></tr>
<tr><td>Phone No:</td><td><input type="text" name="phoneno" id="phoneno" value="" width="160"/></td></tr>
<tr><td>Mobile No:</td><td><input type="text" name="mobileno" id="mobileno" value="" width="160"/></td></tr>
<tr><td>Website(url):</td><td><input type="text" name="website" id="website" value="" width="160"/></td></tr>
<tr><td>Username:</td><td><input type="text" name="username" id="username" value="" width="160"/></td></tr>
<tr><td>Password:</td><td><input type="password" name="password" id="password" value="" width="160"/></td></tr>
<tr><td>Payment Type:</td><td><input type="radio" name="type1" value="1" id="1"/><font size="-2">Payment</font>&nbsp;<input type="radio" name="type1" value="2" id="2"/><font size="-2">Free</font></td></tr>
<tr><td></td><td></td></tr></table>

<table align="center">
  <tr><td><input name="submit" type="submit" id="submit" value="Submit" onclick="return validate();"/></td><td><input type="reset" value="Cancel" id="cancel"/></td></tr>
</table>
</form>
 <%}%>
	<%}%>

</body>
</html>
<%conn.close();%> 
