<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,java.util.Date,java.io.*,java.text.SimpleDateFormat" errorPage="" %>
<%@ include file="/settings.jsp" %>
<!DOCTYPE html>
<%
int add=-1;
int read=-1;
int delete=-1;
try {
	if(session.getAttribute("sessionadd") != null) {
		add = Integer.parseInt((String)session.getAttribute("sessionadd"));
	}
}catch(Exception e){
}
try {
	if(session.getAttribute("sessionread") != null) {
		read = Integer.parseInt((String)session.getAttribute("sessionread"));
	}
}catch(Exception e){
}
try {
	if(session.getAttribute("sessiondelete") != null) {
		delete = Integer.parseInt((String)session.getAttribute("sessiondelete"));
	}
}catch(Exception e){
}

Class.forName(driverName);
Connection conn=DriverManager.getConnection(conStr, dbUser, dbPwd);
PreparedStatement ps=null;
ResultSet rs=null;

%>
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
        <small>Search candidates</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-graduation-cap"></i> Home</a></li>
        <li><a href="#">Candidates</a></li>
		<li><a class="active" href="admin/search_candidate.jsp">Search</a></li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
		<form class="" action="/admin/candidates.jsp" method="post" style="margin: 0 auto; width: 55%">
			<div class="row">
				<label class="control-label col-md-4">Name</label>
				<div class="col-md-6">
					<input name="name" type="text" id="name"  class="form-control"/>
				</div>
			</div>
			<div class="row">
				<label class="control-label col-md-4">Mobile #</label>
				<div class="col-md-6">
					<input name="mobileno" type="text" id="mobileno"  class="form-control"/>
				</div>
			</div>
			<div class="row" style="padding-bottom: 6px; border-bottom: 1px solid;">
				<label class="control-label col-md-4">Email id</label>
				<div class="col-md-6">
					<input name="emailid" type="text" id="emailid"  class="form-control"/>
				</div>
			</div>
			<div class="row">
				<label class="control-label col-md-4">Key words</label>
				<div class="col-md-6">
					<input name="skillSets" type="text" id="skillSets"  class="form-control" placeholder="Seperated by comma"/>
				</div>
			</div>
			<div class="row">
				<label class="control-label col-md-4">Key words</label>
				<div class="col-md-6">
					<input name="skillSets" type="text" id="skillSets"  class="form-control" placeholder="Seperated by comma"/>
				</div>
			</div>
			<div class="row">
				<label class="control-label col-md-4">Location</label>
				<div class=" col-md-8">
					<select class="form-control"  name="location" id="location">
						<option value="Select">Select</option>
						<%
							try{
							ps = conn.prepareStatement("select ACT_City_Code ,ACT_City_Name   from admin_city order by ACT_City_Name");
							rs = ps.executeQuery();
							if(rs != null) {
						%>
						<%   while(rs.next()){ %>
						<option value="<%=rs.getString("ACT_City_Code")%>"><%=rs.getString("ACT_City_Name")%></option>
						<%	}
						}
						}catch(Exception e){
						} finally {
						rs.close();
						ps.close();
						}
						%>
					</select>
				</div>
			</div>
			<div class="row">
				<label class="control-label col-md-4">Experience</label>
				<div class="col-md-6">
					<div class="row">
						<label class="col-md-2">from</label>
						<div class="col-md-4">
							<select class="form-control" name="expFrom" id="expFrom">
								<% for(int i=0;i<=50;i++)
								{%>
								<option value="<%=i%>"><%=i%></option>
								<%}%>
							</select>
						</div>
						<label class="col-md-2">to</label>
						<div class="col-md-4">
							<select class="form-control" name="expTo" id="expTo">
								<option value="Select">Select</option>
								<% for(int i=0;i<=50;i++)
								{%>
								<option value="<%=i%>"><%=i%></option>
								<%}%>
							</select>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<label class="control-label col-md-4">Functional area</label>
				<div class=" col-md-8">
					<select class="form-control" name="functionalArea" id="functionalArea">
						<option value="Select">Select</option>
						<%
							try{
							ps = conn.prepareStatement("select AFA_Functional_Code,AFA_Functional_Area from admin_functional_area order by AFA_Functional_Area");
							rs = ps.executeQuery();
							if(rs != null) {
						%>
						<%   while(rs.next()){ %>
						<option value="<%=rs.getString("AFA_Functional_Code")%>"><%=rs.getString("AFA_Functional_Area")%></option>
						<%	}
						}
						}catch(Exception e){
						} finally {
						rs.close();
						ps.close();
						}
						%>
					</select>
				</div>
			</div>
			<div class="row">
				<label class="control-label col-md-4">Industrial area</label>
				<div class=" col-md-8">
					<select class="form-control" name="industryPrefered" id="industryPrefered">
						<option value="Select">Select</option>
						<%
							try{
							ps = conn.prepareStatement("select  AIA_Industrial_Area_Code,AIA_Industrial_Area  from admin_industrial_area order by AIA_Industrial_Area");
							rs = ps.executeQuery();
							if(rs != null) {
						%>
						<%   while(rs.next()){ %>
						<option value="<%=rs.getString("AIA_Industrial_Area_Code")%>"><%=rs.getString("AIA_Industrial_Area")%></option>
						<%	}
						}
						}catch(Exception e){
						} finally {
						rs.close();
						ps.close();
						}
						%>
					</select>
				</div>
			</div>
			<div class="row">
				<label class="control-label col-md-4">Desired job</label>
				<div class=" col-md-8">
					<select class="form-control" name="desiredJob">
						<option value="Select">Select</option>
						<%
							try{
							ps = conn.prepareStatement("select ADJ_id,ADJ_Admin_Desired_Job from admin_desired_job order by ADJ_Admin_Desired_Job");
							rs = ps.executeQuery();
							if(rs != null) {
						%>
						<%   while(rs.next()){ %>
						<option value="<%=rs.getString("ADJ_id")%>"><%=rs.getString("ADJ_Admin_Desired_Job")%></option>
						<%	}
						}
						}catch(Exception e){
						} finally {
						rs.close();
						ps.close();
						}
						%>
					</select>
				</div>
			</div>
			<div class="row">
				<label class="control-label col-md-4">Qualification</label>
				<div class=" col-md-8">
					<select class="form-control" name="qualification" id="qualification">
						<option value="Select">Select</option>
						<%
							try{
							ps = conn.prepareStatement("select  AQT_Qualification_Code,AQT_Qualification from admin_qualification order by AQT_Qualification");
							rs = ps.executeQuery();
							if(rs != null) {
						%>
						<%   while(rs.next()){ %>
						<option value="<%=rs.getString("AQT_Qualification_Code")%>"><%=rs.getString("AQT_Qualification")%></option>
						<%	}
						}
						}catch(Exception e){
						} finally {
						rs.close();
						ps.close();
						}
						%>
					</select>
				</div>
			</div>
			<div class="row">
				<label class="control-label col-md-4">Major</label>
				<div class=" col-md-8">
					<select class="form-control"  name="major" id="major">
						<option value="Select">Select</option>
						<%
							try{
							ps = conn.prepareStatement("select AQM_Qualification_Major_Code,AQM_Qualification_Major_Name  from admin_qualification_major order by AQM_Qualification_Major_Name ");
							rs = ps.executeQuery();
							if(rs != null) {
						%>
						<%   while(rs.next()){ %>
						<option value="<%=rs.getString("AQM_Qualification_Major_Code")%>"><%=rs.getString("AQM_Qualification_Major_Name")%></option>
						<%	}
						}
						}catch(Exception e){
						} finally {
						rs.close();
						ps.close();
						}
						%>
					</select>
				</div>
			</div>
			<div class="row">
				<label class="control-label col-md-4">Gender</label>
				<div class=" col-md-8">
					<select class="form-control" name="gender" id="major">
						<option value="Select">Select</option>
						<option value="1">Male</option>
						<option value="2">Female</option>
					</select>
				</div>
			</div>
			<div class="row">
				<label class="control-label col-md-4">Service type</label>
				<div class=" col-md-8">
					<select class="form-control" name="serviceType" id="serviceType">
						<option value="Select">Select</option>
						<%
							try{
							ps = conn.prepareStatement("select AST_Service_Type_Code,AST_Service_Type   from admin_service_type order by AST_Service_Type");
							rs = ps.executeQuery();
							if(rs != null) {
						%>
						<%   while(rs.next()){ %>
						<option value="<%=rs.getString("AST_Service_Type_Code")%>"><%=rs.getString("AST_Service_Type")%></option>
						<%	}
						}
						}catch(Exception e){
						} finally {
						rs.close();
						ps.close();
						}
						%>
					</select>
				</div>
			</div>
			
			<div class="button-group">
				<button type="" class="btn btn-primary">Search</button>
			</div>
			
		</form>
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  
  <%@ include file="./partials/footer.jsp" %>
  
</div>
<!-- ./wrapper -->

<%@ include file="./partials/scripts.jsp" %>

</body>
</html>
<%
try{
	conn.close();
}
catch(Exception e){}
%>