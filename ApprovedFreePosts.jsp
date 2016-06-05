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
	
String flag="new";
int comptype=2;

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
		
Connection conn=DriverManager.getConnection(conStr, dbUser, dbPwd);
  PreparedStatement ps1=conn.prepareStatement("select av_contact_company_name,av_contact_address,av_status_flag,av_contact_mobileno,av_contact_phoneno,av_contact_state,av_contact_city,av_id,av_contact_country from admin_vaccancy  where av_status_flag not like '"+flag+"' order by AV_ID desc");
  ResultSet rs1=ps1.executeQuery();
  

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Job Openings</title>
<link rel="stylesheet" href="/style.css" type="text/css" />
<script type="text/javascript" src="/script.js"></script>
<style type="text/css">
<!--
.style1 {
	font-size: 18px;
	font-weight: bold;
}
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
<form >
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
		<div align="center"><a href="#" class="menulink">Approved</a>
		  <ul>
		      <li><a href="/admin/ApprovedFreePosts.jsp">Free posts</a></li>
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
    <li><div class="menulink">
     <a href="/admin/999candidates.jsp">Rs. 999 Candidates</a></div>
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
		for(i=1 ; rs1.next(); i++)
		{
			count = count + 1;
		}
  		rs1.beforeFirst();
  		rs1.last();
  		size = rs1.getRow();
		rs1.beforeFirst();
		System.out.println("Sizeeee" + count);
	}
	System.out.println(" Pageno " + pageNo);
	for(i = 0; i <= (pageNo-1) * 20; i++)
	{
		if (rs1 != null)
		{
			System.out.println("JJ I " + i);
			rs1.next();
		}
	}
%>

	  
	 <table border="1"  style="font-size:14px" width="100%">
	 <tr><td colspan="10"><div align="center" class="style1">Job approval page for free posting</div></td>
	 </tr>
	
	 <tr>
	   <td>Company name</td>
	   <td>Contact address</td>
	   <td>City</td>
	   <td>State</td>
	   <td>Country</td>
	   <td>Phone no</td>
	   <td>Mobile no</td>
	   <td>Status</td>
	   <td>Options</td>
 
	 </tr>
	<% 
i= 1;
while(rs1.next())
   {
	System.out.println("Inside");
	if ( i < (pageNo * 20))
	{
		System.out.println("Inside1");
%>
	  
   <tr>
    
    <td ><%=rs1.getString("av_contact_company_name")%></td>
  
	<td ><%=rs1.getString("av_contact_address")%></td>
   
    <td ><%=rs1.getString("av_contact_city")%></td>
   
	<td><%=rs1.getString("av_contact_state")%></td>
 
    <td ><%=rs1.getString("av_contact_country")%></td>
	
	<td ><%=rs1.getString("av_contact_phoneno")%></td>
	
	<td ><%=rs1.getString("av_contact_mobileno")%></td>
	
	<td ><%=rs1.getString("av_status_flag")%></td>
	<td><a href="/admin/editjobfree.jsp?id=<%=rs1.getString("av_id")%>">Edit</a>&nbsp;<a href="/admin/ContactsHideShow.jsp?id=<%=rs1.getString("av_id")%>">Customize</a></td>
	
  </tr>
<% 
	}
i = i + 1;
System.out.println("IIIIIIII" + i);
} %>
</table>
<%
	row = size / 20;
	if (row == 0)
	{
		row = 1;
	}
	System.out.println("Roww " + row);
	if( pageNo > 10)
	{
		for(i=pageNo-5; i<=pageNo+5 && i <= row+1; i++)
		{
			if (i == pageNo)
			{
				out.print(i);
			}
			else
			{
%>


				<a style="text-decoration:none" href="/admin/Newopeningsfree.jsp?pageNo=<%= i %>&amp;"> <%= i %></a>
<%
			}
			out.write(" "); 
		}		
	}
	else
	{
		for(i=1;i<=row+1;i++)
		{
			if (i == pageNo)
			{
				out.print(i);
			}
			else
			{
%>

		<a  style="text-decoration:none" href="/admin/Newopeningsfree.jsp?pageNo=<%= i %>"> <%= i %></a>	
<%				
			}
			out.write(" "); 
		}
	}	
%>

	

<ul><input type=submit name="Submit" value="<<" class="pgdes" ><input type=submit name="Submit" value=">>" class="pgdes" ></ul>
<input type="hidden" name="pageNo" value="<%= pageNo %>" />
</form>

	 <%}%>
	<%}%>