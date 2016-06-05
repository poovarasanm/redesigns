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
String joins = " FROM admin_employeer_login";
String countQuery = "SELECT COUNT(Admin_Employer_login_id)";

query += "Admin_Employer_login_id, admin_emp_desired_job, admin_emp_city, admin_emp_from_date, admin_to_date, admin_emp_status, admin_emp_username";
query += ", amin_emp_comp_name, admin_emp_alloted, loginstatus, mobileno, emailid";
query += ", download_count";

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

query += " ORDER BY Admin_Employer_login_id DESC LIMIT " + start + ", " + perPage;

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
        Franchises
        <small>All</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-university"></i>Home</a></li>
		<li><a class="active" href="admin/franchises.jsp">Franchises</a></li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
		<form action="/admin/agents.jsp" method="post" name="search">
		<%@ include file="./partials/pagination-form-part.jsp" %>
		<div class="row btn-group">
			<div class="col-md-12">
				<button class="btn btn-default" id="activate">Activate</button>
				<button class="btn btn-default" id="deactivate">Deactivate</button>
				<button class="btn btn-default" id="copyMail">Delete</button>
			</div>
		</div>
		<div class="row">
		</form>
		<% if(rs != null){ %>
		<% while(rs.next()){ %>
			<div class="row company" id="company<%=rs.getString(1)%>" style="border-bottom: 2px ridge #E6D7D7; padding: 8px 12px; margin: 8px">
				<div class="col-md-4">
					<div class="row">
						<span class="col-md-4">Company name</span>
						<span class="col-md-8"><%= rs.getString("amin_emp_comp_name") %></span>
					</div>
					<div class="row">
						<span class="col-md-4">Username</span>
						<span class="col-md-8"><%= rs.getString("admin_emp_username") %></span>
					</div>
					<div class="row">
						<span class="col-md-4">Email id</span>
						<span class="col-md-8"><%= rs.getString("emailid") %></span>
					</div>				
				</div>
				<div class="col-md-4">
					<div class="row">
						<span class="col-md-4">Contact no</span>
						<span class="col-md-8">
							<% out.print(rs.getString("mobileno") == null ? "" : rs.getString("mobileno"));  %>
						</span>
					</div>
					<div class="row">
						<span class="col-md-4">Desired job to search</span>
						<span class="col-md-8" style="overflow: scroll">
						<% out.print(rs.getString("admin_emp_desired_job") == null ? "" : rs.getString("admin_emp_desired_job")); %>
						</span>
					</div>
					<div class="row">
						<span class="col-md-4">Desired city to search</span>
						<span class="col-md-8" style="overflow: scroll">
						<% out.print(rs.getString("admin_emp_city") == null ? "" : rs.getString("admin_emp_city")); %>
						</span>
					</div>
				</div>
				<div class="col-md-2">
					<div class="row">
						<span class="col-md-4">Download count</span>
						<span class="col-md-8" style="overflow: scroll">
						<% out.print(rs.getString("download_count") == null ? "" : rs.getString("download_count")); %>
						</span>
					</div>
					<div class="row">
						<span class="col-md-4">Active date</span>
						<span class="col-md-8">
						<% out.println(rs.getString("admin_emp_from_date") != null ? rs.getString("admin_emp_from_date") : ""); %>
						<% out.println(rs.getString("admin_to_date") != null ? " - "+rs.getString("admin_to_date") : ""); %>
						</span>
					</div>
					<div class="row">
						<span class="col-md-4">Status</span>
						<span class="col-md-8"><% out.println(rs.getInt("admin_emp_status") == 1 ? "Active" : "Inactive"); %></span>
					</div>
				</div>
				<div class="col-md-2 actions">
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