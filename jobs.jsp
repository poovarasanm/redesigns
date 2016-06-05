<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,java.util.Date,java.io.*,java.text.SimpleDateFormat" errorPage="" %>
<%@ include file="/settings.jsp" %>
<%

Class.forName(driverName);
Connection conn=DriverManager.getConnection(conStr, dbUser, dbPwd);
PreparedStatement ps = null;
ResultSet rs = null;

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
String conds = " WHERE 1=1";
String joins = " FROM admin_vaccancy";
String countQuery = "SELECT COUNT(AV_ID)";

query += "av_keyword, av_candidatereq_experience_from, av_candidatereq_city, av_candidatereq_salaryofferedfrom, av_candidatereq_functionalarea";
query += ", av_contact_company_name, AV_ID, av_contact_person, av_contact_address, av_contact_city, av_contact_state, av_contact_country, av_contact_phoneno";
query += ", av_contact_mobileno, av_contact_emailid, av_contact_website, av_contact_refid, av_opening_position, av_opening_jobdesc";
query += ", av_opening_candi_pro, av_opening_com_pro, av_candidatereq_posted, av_candidatereq_ind_type, av_candidatereq_state";
query += ", av_candidatereq_country, av_contact_pincode, av_candidatereq_gender, av_candidatereq_salaryofferedto, av_candidatereq_experience_to";
query += ", av_candidatereq_qualification, av_candidatereq_desiredjob, av_company_id, av_user_id, av_company_expire_date";
query += ", av_expire_flag, av_deleted_flag, av_status_flag, av_approved_by, av_company_name, av_company_contact_person";
query += ", av_company_address, av_company_emailid, av_company_mobile_no, av_company_phone_no, av_company_contact_city, av_company_contact_state";
query += ", av_company_contact_coutry, av_candidatereq_qualification_major, post_type";

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

query += " ORDER BY AV_ID DESC LIMIT " + start + ", " + perPage;

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
        Jobs
        <small>All</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-university"></i>Home</a></li>
		<li><a class="active" href="admin/jobs.jsp">Jobs</a></li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
		<form action="/admin/jobs.jsp" method="post" name="search">
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
				<button class="btn btn-default" id="activate">Activate</button>
				<button class="btn btn-default" id="deactivate">Deactivate</button>
				<button class="btn btn-default" id="copyMail">Delete</button>
			</div>
		</div>
		<div class="row">
		</form>
		<div class="table-responsive">
		<table class="table">
		<tbody>
		<tr>
			<th>Id</th>
			<th>Company</th>
			<th>Contact person</th>
			<th>Job</th>
			<th>Experience</th>
			<th>Salary</th>
			<th>Qualification</th>
			<th>Actions</th>
		</tr>
		<% if(rs != null){
			String qualificationShort="";
			String qualification="";
		%>
		<% while(rs.next()){
			qualification = rs.getString("av_candidatereq_qualification") + rs.getString("av_candidatereq_qualification_major");
			qualificationShort = qualification;
			if(qualification.length() > 40) {
				qualificationShort = qualification.substring(0, 39) + "...";
			}
		%>
			<tr>
			<td><%= rs.getString("AV_ID") %></td>
			<td><%= rs.getString("av_contact_company_name") %></td>
			<td><%= rs.getString("av_contact_person") %></td>
			<td><%= rs.getString("av_opening_position") %></td>
			<td><%= rs.getString("av_candidatereq_experience_from") %> - <%= rs.getString("av_candidatereq_experience_to") %></td>
			<td><%
			if("Negotiable".equals(rs.getString("av_candidatereq_salaryofferedfrom"))) {
				out.print(rs.getString("av_candidatereq_salaryofferedfrom"));
			} else {
				out.print(rs.getString("av_candidatereq_salaryofferedfrom") + " - " + rs.getString("av_candidatereq_salaryofferedto"));
			}
			%></td>
			<td title = "<%= qualification %>"><%= qualificationShort %></td>
		</tr>
		<% } %>
		</tbody>
		</table>
		</div>
		<% } if(rows == 0) { %>
		<b>No records found.</b>
		<% } %>
		
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