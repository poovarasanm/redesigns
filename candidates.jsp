<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,java.util.Date,java.io.*,java.text.SimpleDateFormat" errorPage="" %>
<%@ include file="/settings.jsp" %>
<%

Class.forName(driverName);
Connection conn=DriverManager.getConnection(conStr, dbUser, dbPwd);
PreparedStatement ps = null;
ResultSet rs = null;

String keywords = null;
String location = null;
String expFrom = null;
String expTo = null;
String functionalArea = null;
String industrialArea = null;
String desiredJob = null;
String qualification = null;
String major = null;
String gender = null;
String serviceType = null;

int rows = 0;
int perPage = 20;
int pageNo = 0;
int pages = 0;
int start = 1;

if(request.getParameter("page") != null){
	try{
		pageNo = Integer.parseInt(request.getParameter("page"));
	}catch(Exception e){
		pageNo = 0;
	}
}
start = pageNo * perPage;

String query = "SELECT ";
String joins = " FROM postresume p";
String conds = "";
String countQuery = "SELECT COUNT(postresume_id)";

query += " p.postresume_id, p.username, p.qualification_id, p.major_id, p.university_id, p.percentage, p.gender, p.exp_years, p.exp_months, p.salary_lacs, p.salary_thousands,";
query += " p.functional_area, p.industrial_code, p.keyskills, p.resumeheadline, p.servicetype, p.resumeurl, p.fullname, p.address, p.city, p.zipcode,";
query += " p.phonenumber, p.mobilenumber, p.country, p.DOB, p.emailid, p.registereddate, p.desiredjob, p.state, p.year_passing, p.reference,";
query += " p.refstate, p.refagent, p.sourceofjobjunction, p.domain, p.current_job, ";
query += " c.ACT_City_Name, ";
query += " m.AM_Major_Name, ";
query += " f.AFA_Functional_Area, ";
query += " i.AIA_Industrial_Area, ";
query += " st.AST_Service_Type, ";
query += " j.ADJ_Admin_Desired_Job, ";
query += " q.AQT_Qualification, ";
query += " s.AS_State_Country_Code ";

joins += " JOIN admin_qualification q on p.qualification_id = q.AQT_Qualification_Code";
joins += " JOIN admin_city c ON c.ACT_City_Code = p.city";
joins += " JOIN admin_major m ON p.major_id = m.AM_Major_Code";
joins += " JOIN admin_functional_area f ON p.functional_area = f.AFA_Functional_Code";
joins += " JOIN admin_industrial_area i ON p.industrial_code = i.AIA_Industrial_Area_Code";
joins += " JOIN admin_service_type st ON p.servicetype = st.AST_Service_Type_Code";
joins += " JOIN admin_desired_job j ON p.desiredjob = j.ADJ_id";
joins += " JOIN admin_state s ON p.state = s.AS_State_Code";

if(request.getParameter("skillSets") != null && !"Select".equals((String)request.getParameter("skillSets"))){
	try{
		String[] skills = ((String)request.getParameter("skillSets")).split(",");
		if(skills.length > 0){
			conds += " AND ( ";
			for(int i=0; i < skills.length; i++){
				if( i !=0){
					conds += " OR ";
				}
				conds += " p.keyskills LIKE '%" + skills[i].trim() + "'";
			}
			conds += " ) ";
		}
	}catch(Exception e){}
}
if(request.getParameter("location") != null && !"Select".equals((String)request.getParameter("location"))){
	conds += " AND p.city = " + request.getParameter("location");
}
if(request.getParameter("expFrom") != null && !"Select".equals((String)request.getParameter("expFrom"))){
	conds += " AND p.exp_years >= '" + request.getParameter("expFrom") + "'";
}
if(request.getParameter("expTo") != null && !"Select".equals((String)request.getParameter("expTo"))){
	conds += " AND p.exp_years <= '" + request.getParameter("expTo") + "'";
}
if(request.getParameter("functionalArea") != null && !"Select".equals((String)request.getParameter("functionalArea"))){
	conds += " AND p.functional_area = " + request.getParameter("functionalArea");
}
if(request.getParameter("industryPrefered") != null && !"Select".equals((String)request.getParameter("industryPrefered"))){
	conds += " AND p.industrial_code = " + request.getParameter("industryPrefered");
}
if(request.getParameter("desiredJob") != null && !"Select".equals((String)request.getParameter("desiredJob"))){
	conds += " AND p.desiredjob = " + request.getParameter("desiredJob");
}
if(request.getParameter("qualification") != null && !"Select".equals((String)request.getParameter("qualification"))){
	conds += " AND p.qualification_id = " + request.getParameter("qualification");
}
if(request.getParameter("major") != null && !"Select".equals((String)request.getParameter("major"))){
	conds += " AND p.major_id = " + request.getParameter("major");
}
if(request.getParameter("serviceType") != null && !"Select".equals((String)request.getParameter("serviceType"))){
	conds += " AND p.servicetype = " + request.getParameter("serviceType");
}
if(request.getParameter("gender") != null && !"Select".equals((String)request.getParameter("gender"))){
	conds += " AND p.gender = " + request.getParameter("gender");
}

if(request.getParameter("name") != null && !"".equals(((String)request.getParameter("name")).trim())){
	conds += " AND p.fullname LIKE '" + request.getParameter("name") + "%'";
}
if(request.getParameter("mobileno") != null && !"".equals(((String)request.getParameter("mobileno")).trim())){
	conds += " AND p.mobilenumber LIKE '" + request.getParameter("mobileno") + "%'";
}
if(request.getParameter("emailid") != null && !"".equals(((String)request.getParameter("emailid")).trim())){
	conds += " AND p.emailid LIKE '" + request.getParameter("emailid") + "%'";
}
countQuery += (joins + conds);
query += (joins + conds);

//out.println(countQuery);

try {
	ps = conn.prepareStatement(countQuery);
	rs = ps.executeQuery();
	if(rs != null){
		while(rs.next()){
			rows = rs.getInt(1);
			break;
		}
	}
}catch(Exception e){
	ps.close();
	rs.close();
}

pages = rows/perPage % perPage == 0 ? rows/perPage : rows/perPage + 1;

//out.println("Rows="+rows + ", pages = " + pages+"=======================================");

query += " ORDER BY p.postresume_id DESC LIMIT " + start + ", " + perPage;

//out.println(query);

try {
	if(rows > 0) {
		ps = conn.prepareStatement(query);
		rs = ps.executeQuery();
	}
}catch(Exception e){
	ps.close();
	rs.close();
}

%>
<!DOCTYPE html>
<html>
<head>
  <%@ include file="./partials/head.jsp" %>
</head>
<body class="hold-transition skin-red sidebar-mini">
<div class="wrapper">

  <%@ include file="./partials/header.jsp" %>
  
  <%@ include file="./partials/sidebar.jsp" %>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Dashboard
        <small>Candidates</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-graduation-cap"></i>Home</a></li>
        <li><a  href="admin/search_candidate.jsp">Search Candidates</a></li>
		<li><a class="active" href="admin/candidates.jsp">Candidates</a></li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
		<form action="/admin/candidates.jsp" method="post" name="search">
		<input type="hidden" name="name" value="<%= request.getParameter("name") %>"/>
		<input type="hidden" name="mobileno" value="<%= request.getParameter("mobileno") %>"/>
		<input type="hidden" name="emailid" value="<%= request.getParameter("emailid") %>"/>
		<input type="hidden" name="skillSets" value="<%= request.getParameter("skillSets") %>"/>
		<input type="hidden" name="location" value="<%= request.getParameter("location") %>"/>
		<input type="hidden" name="expFrom" value="<%= request.getParameter("expFrom") %>"/>
		<input type="hidden" name="expTo" value="<%= request.getParameter("expTo") %>"/>
		<input type="hidden" name="functionalArea" value="<%= request.getParameter("functionalArea") %>"/>
		<input type="hidden" name="industryPrefered" value="<%= request.getParameter("industryPrefered") %>"/>
		<input type="hidden" name="desiredJob" value="<%= request.getParameter("desiredJob") %>"/>
		<input type="hidden" name="qualification" value="<%= request.getParameter("qualification") %>"/>
		<input type="hidden" name="major" value="<%= request.getParameter("major") %>"/>
		<input type="hidden" name="gender" value="<%= request.getParameter("gender") %>"/>
		<input type="hidden" name="serviceType" value="<%= request.getParameter("serviceType") %>"/>
		<input type="hidden" name="page" value="<% out.print(request.getParameter("page") == null ? "0" : request.getParameter("page"));  %>"/>
		<% if(pages > 1) { %>
		<div class="row">
			<div class="col-md-8 btn-group" role="group">
				<button type="submit" value="0" <% out.print((0==pageNo) ? "disabled":""); %> class="btn btn-default" onclick="document.search.page.value=0;">&lt;&lt;</button>
				<button type="submit" <% out.print((0==pageNo) ? "disabled":""); %> onclick="document.search.page.value=<%= pageNo-1 %>;" class="btn btn-default">&lt;</button>
				<% boolean dotDone = false; %>
				<% for(int i=0; i < pages; i++) { %>
					<% if(i < 4 || i >= pages - 4) { %>
					<button type="submit" value="<%= pageNo %>" onclick="document.search.page.value=<%= i %>;" class="btn btn-default" <% out.print((i==pageNo) ? "disabled":""); %>><% out.print(i+1); %></button>
					<% } else if(!dotDone) { %>
					<% dotDone = true; %>
					<button disabled class="btn btn-default">...</button>
					<% } %>
				<% }%>
				<button type="submit" class="btn btn-default" onclick="document.search.page.value=<%= pageNo+1 %>;"
				<% out.print((pages-1==pageNo) ? "disabled":""); %>>&gt;</button>
				<button type="submit" class="btn btn-default" onclick="document.search.page.value=<%= pages-1 %>;"
				<% out.print((pages-1==pageNo) ? "disabled":""); %> >&gt;&gt;</button>
				<input type="text" class="btn btn-default" id="goto" style="width: 59px" placeholder="page#"/>
				<button class="btn btn-default" onclick="document.search.page.value=document.getElementById('goto').value-1;">Go</button>
			</div>
		</div>
		<% } %>
		<div class="row btn-group">
			<div class="col-md-12">
				<button class="btn btn-default" id="selectAll">Select All</button>
				<button class="btn btn-default" id="deselectAll">Deselect All</button>
				<button class="btn btn-default" id="copyMail">Copy Email Ids</button>
				<button class="btn btn-default" id="copyMobile">Copy Mobile nos</button>
			</div>
		</div>
		<div class="row">
		</form>
		<% if(rs != null){ %>
		<% while(rs.next()){ %>
			<div class="row candidate" id="candidate_<%=rs.getString(1)%>" style="border-bottom: 2px ridge #E6D7D7; padding: 8px 12px; margin: 8px">
				<div class="col-md-4">
					<div class="row">
						<span class="col-md-4">Name</span>
						<span class="col-md-8">
							<a class="name" href="javascript:void(0)" onclick="window.open('/admin/detailresume.jsp?ResumeId=<%=rs.getString(1)%>','detail','width=600, height=320,scrollbars=yes, resizable=yes');return false" style="text-decoration: none;"><%= rs.getString(18) %></a>
						</span>
					</div>
					<div class="row">
						<span class="col-md-4">Experience</span>
						<span class="col-md-8"><b><%= rs.getString(8) %></b> Years <b><%= rs.getString(9) %> </b>Months</span>
					</div>
					<div class="row">
						<span class="col-md-4">Key skills</span>
						<span class="col-md-8"><%= rs.getString(14) %></span>
					</div>
				</div>
				<div class="col-md-3">
					<div class="row">
						<span class="col-md-4">Qualification</span>
						<span class="col-md-8"><%= rs.getString(43) %> - <%= rs.getString(38) %></span>
					</div>
					<div class="row">
						<span class="col-md-4">CTC</span>
						<span class="col-md-8"><%= rs.getString(10) %> Lakhs & <%= rs.getString(11) %> Thousands</span>
					</div>
					<div class="row">
						<span class="col-md-4">Location</span>
						<span class="col-md-8"><%= rs.getString(37) %></span>
					</div>
				</div>
				<div class="col-md-4">
					<div class="row">
						<span class="col-md-4">Mobile #</span>
						<span class="col-md-8 mobileno"><%= rs.getString(23) %></span>
					</div>
					<div class="row">
						<span class="col-md-4">Email id</span>
						<span class="col-md-8 emailid"><%= rs.getString(26) %></span>
					</div>
					<div class="row">
						<span class="col-md-4">Resume</span>
						<span class="col-md-8">
							<a style="text-decoration:none" href="/download1.jsp?ResumeId=<%=rs.getString(1)%>">Download</a>
						</span>
					</div>
					<div class="row">
						<span class="col-md-4">Updated on</span>
						<span class="col-md-8">
							<%= (new SimpleDateFormat("dd-MM-yyyy")).format(rs.getDate("registereddate")) %>
						</span>
					</div>
				</div>
				<div class="col-md-1 actions">
					<input type="checkbox" class=""/>
				</div>
			</div>
		<% } %>
		<% } if(rows == 0) { %>
		<b>No records found.</b>
		<% } %>
		</div>
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  
  <%@ include file="./partials/footer.jsp" %>
  
</div>
<!-- ./wrapper -->

<%@ include file="./partials/scripts.jsp" %>
<script type="text/javascript">
 $().ready(function(){
	$('#selectAll').click(function(e){
		e.preventDefault();
		$('.candidate .actions input[type=checkbox]').prop('checked', true);
	});
	$('#deselectAll').click(function(e){
		e.preventDefault();
		$('.candidate .actions input[type=checkbox]').prop('checked', false);
	});
	$('#copyMail').click(function(e){
		e.preventDefault();
		var phnos=[];
		$('.candidate').each(function(){
			if($('.actions input[type=checkbox]', this).is(':checked')){
				var phno = $('.mobileno', this).text().trim();
				if(phno.length > 0){
					phnos.push(phno);
				}
			}
		});
		copy(phnos);
	});
	$('#copyMobile').click(function(e){
		e.preventDefault();
		var emails=[];
		$('.candidate').each(function(){
			if($('.actions input[type=checkbox]', this).is(':checked')){
				var email = $('.emailid', this).text().trim();
				if(email.length > 0){
					emails.push(email);
				}
			}
		});
		copy(emails);
	});
	function copy(data){
		if(data.length > 0){
			prompt("Copy to clipboard: Ctrl+C, Enter", data.toString());
		}
	}
 });
</script>

</body>
</html>
<%
try{
	
	conn.close();
}
catch(Exception e){}
%>