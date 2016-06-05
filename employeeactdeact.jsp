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

    int k=1;
	int count = 0;
    int j=1;
	String page_no = request.getParameter("pageNo");
	String submit = request.getParameter("Submit");
	
	if (page_no == null)
		{
			pageNo = 1;
		}
		else
		{
			pageNo = Integer.parseInt(page_no);
		}
		if (submit == null)
		{}
		else if (submit.equals(">>"))
		{
			pageNo = pageNo + 1;
		}
		else if (submit.equals("<<"))
		{
			if (pageNo == 1)
			{}
			else
			{
				pageNo = pageNo - 1;	
			}
		}
   
 Class.forName(driverName);
Connection conn=DriverManager.getConnection(conStr, dbUser, dbPwd);
PreparedStatement ps=conn.prepareStatement("select AUR_user_code_id,AUR_employee_name,AUR_user_name,AUR_password,AUR_employee_email_id,AUR_employee_phone_no,AUR_employee_mobile_no,AUR_read,AUR_add,AUR_update,AUR_delete,AUR_act_deact from admin_user_registration");
ResultSet rs1=ps.executeQuery();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Company Activation/Deactivation</title>
<script language="javascript" type="text/javascript">
function checkAll(){
	for (var i=0;i<document.forms[0].elements.length;i++)
	{
		var e=document.forms[0].elements[i];
		if ((e.name != 'allbox') && (e.type=='checkbox'))
		{
			e.checked=document.forms[0].allbox.checked;
		}
	}
}
</script>
<script language="javascript" type="text/javascript">



function queryAction() {

var confirmmessage = "Are you sure you want to Delete the selected company details?";
var goifokay = "/admin/employeeactdeactaction.jsp";
var cancelmessage = "Action Cancelled";

if (confirm(confirmmessage)) {

document.companyactanddeact.action=goifokay;

} else {

alert(cancelmessage);

}
return true;
}

function deactivate() {

var confirmmessage = "Are you sure you want to Deactivate the selected company details?";
var goifokay = "/admin/employeeactdeactaction.jsp";
var cancelmessage = "Action Cancelled";

if (confirm(confirmmessage)) {

document.companyactanddeact.action=goifokay;

} else {

alert(cancelmessage);

}
return true;
}

function activate() {

var confirmmessage = "Are you sure you want to Activate the selected company details?";
var goifokay = "/admin/employeeactdeactaction.jsp";
var cancelmessage = "Action Cancelled";

if (confirm(confirmmessage)) {

document.companyactanddeact.action=goifokay;

} else {

alert(cancelmessage);

}
return true;
}
function userlist() {

var confirmmessage = "do you sure you want userlist";
var goifokay = "/admin/employeeactdeactaction.jsp";
var cancelmessage = "Action Cancelled";

if (confirm(confirmmessage)) {

document.companyactanddeact.action=goifokay;

} else {

alert(cancelmessage);

}
return true;
}

</script>
<link rel="stylesheet" href="/style.css" type="text/css" />
<script type="text/javascript" src="/script.js"></script>
<style type="text/css">
<!--
.style2 {font-size: 18px}
-->
</style>
</head>


<body>

<% if(read1==1 && add1==1 && update1==1 && delete1==1)
   {
   %>
   <% if(username!=null && password!=null)
{
%>
<form name="companyactanddeact">
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
	      <li>
	        <a href="/admin/ResumeSearchnew.jsp" >SearchResume&nbsp;New</a>
	        
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
	   <%
if (rs1 != null) 
	{
		for(int i=1 ; rs1.next(); i++)
		{
			count = count + 1;
		}
  		rs1.beforeFirst();
  		rs1.last();
  		size = rs1.getRow();
		rs1.beforeFirst();
		//System.out..println("Sizeeee" + count);
	}
	//System.out..println(" Pageno " + pageNo);
	if(pageNo!=1)
	  {
	 	for(  j =1; j <= (pageNo-1) * 20; j++)
	   {
		if (rs1 != null)
		{
			//System.out..println("JJ I " + j);
			rs1.next();
		}
	}

  }
%>
	  
	  <table width="100%" border="0">
	   <tr>
	     <td width="9%"><input type="submit" name="companyact" value="Activate" onclick="return activate();"/></td><td width="9%"><input type="submit" name="companyact" value="Delete" onclick="return queryAction();"/></td><td width="10%"><input type="submit" name="companyact" value="Deactivate" onclick="return deactivate();"/></td>
	   </tr>
	  </table>
	  
	 <table width="100%" border="1">
	 <tr><td colspan="10"><div align="center" class="style1 style2"><strong>Employee activation/deactivation/delete </strong></div></td>
	 </tr>
	 <tr>
	   <td width="5%">SL.No</td>
	   <td width="9%"><input type="checkbox" name="allbox" onclick="checkAll();"/>Select All</td>
	   <td width="19%">Employee Name </td>
	   <td width="17%">User Name</td>
	   <td width="12%">Password</td>
	   <td width="5%">Mail ID</td>
	     <td width="5%">Phone No</td>
		 <td width="5%">Mobile No</td>
		 <td width="5%">Search</td>
		 <td width="5%">Add</td>
		 <td width="5%">Update</td>
		 <td width="5%">Delete</td>
		<td width="11%">Login Status</td>
	  
	  
	 </tr>
	 
	 <% 

int count1=0;
while(rs1.next())
   {
     count1++;
	//System.out..println("Inside");
	if ( j <= (pageNo * 20))
	{
		//System.out..println("Inside1");
%>
	  
   <tr>
    
    <td width="5%" ><%=j%></td>
	
  
	<td width="9%" ><input type="checkbox" name="compid" value="<%=rs1.getString(1)%>" /></td>
   
    <td width="19%" ><%=rs1.getString(2)%></td>
   
	<td width="17%"><%=rs1.getString(3)%></td>
 
    <td width="12%" ><%=rs1.getString(4)%></td>
	
	<td width="11%" ><%=rs1.getString(5)%></td>
	
	<td width="14%" ><%=rs1.getString(6)%></td>
	<td width="14%" ><%=rs1.getString(7)%></td>
	<td width="14%" >
       <% String searchper=rs1.getString(8);%>
       <%if(searchper.equals("1")){%><%="Yes"%><%}else{%><%="No"%><%}%></td>
    <td width="14%" ><% String addper=rs1.getString(9);%>
       <%if(addper.equals("1")){%><%="Yes"%><%}else{%><%="No"%><%}%></td>
	<td width="14%" ><% String updateper=rs1.getString(10);%>
       <%if(updateper.equals("1")){%><%="Yes"%><%}else{%><%="No"%><%}%></td>
	<td width="14%" ><% String deleteper=rs1.getString(11);%>
       <%if(deleteper.equals("1")){%><%="Yes"%><%}else{%><%="No"%><%}%></td>
	<td width="5%"><%String st=rs1.getString(12);
	                 
	                    %>
	<%if(st.equals("1")){%><%="Active"%><%}else{%><%="Deactive"%><%}%></td>
	
  </tr>
   
    <% 
     
	  }
j=j+1;

} %>
</table>
<%
  out.print("Prev<<");
    String pa="next";
	row = size / 20;
    
	if (size % 20>0)
	{
		row =row+1;
	}
	if( pageNo > 10||pa=="next")
	{  
	
		for( k=pageNo-5; k<=pageNo+5; k++)
		{  
            
		    if(row>=k)
			if (k == pageNo)
			{
%>


<%
				out.print("|"+k);
			}
			else if(k>=1)
			{
%>


				|<a style="text-decoration:none" href="/admin/employeeactdeact.jsp?pageNo=<%= k %>"> <%= k %></a>
<%
			}
			out.write(" "); 
           }
		out.write(">>Next");
         out.write(" ");
         out.write("<font color=red>Total Page:</font>"+row);		
	}

	else 
	{
		for(k=1;k<=row;k++)
		{
            
			if (k == pageNo)
              
			{
              
				out.print(k);
			}
			else
			{
%>
		<a  style="text-decoration:none" href="/admin/employeeactdeact.jsp?pageNo=<%= k %>"> <%= k %></a>	
<%				
			}
			out.write(" "); 
		}
	}	
%>
<% if(count==0){
                 %>
         <table border="1" bgcolor="#92A2E2" align="center"><tr><td align="center"><p><font size="5">Sorry there is no job found as per your search creteria.</font></p><p><font size="5">Please refine your search creteria or try later</font></p></td></tr></table>
	<%}%>
	


</form>
	 <%}%>
	<%}%>


</body>
</html>
<%
try{
rs1.close();
ps.close();
conn.close();
}catch(Exception e){}
%>
