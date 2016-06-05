<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,java.util.*,java.util.regex.*" errorPage="" %>
<%@ include file="/settings.jsp" %>
<%

Class.forName(driverName);
Connection conn=DriverManager.getConnection(conStr, dbUser, dbPwd);
PreparedStatement ps = null;
ResultSet rs = null;
Pattern p = null;

String query = "";

String name = "", nameErr = "";
String companyType = "";
String industry = "";
String contactPerson = "", contactPersonErr = "";
String address = "";
String city = "";
String state = "";
String country = "";
String pin = "";
String mobile = "", mobileErr = "";
String emailid = "", emailidErr = "";
String pwd = "", pwdErr = "";

boolean valid = false;

if("create".equals(request.getParameter("action")) || "update".equals(request.getParameter("action"))) {
	name = (String)request.getParameter("name");
	companyType = (String)request.getParameter("name");
	industry = (String)request.getParameter("name");
	contactPerson = (String)request.getParameter("contact-person");
	address = (String)request.getParameter("name");
	city = (String)request.getParameter("name");
	state = (String)request.getParameter("name");
	country = (String)request.getParameter("name");
	pin = (String)request.getParameter("name");
	mobile = (String)request.getParameter("mobile");
	emailid = (String)request.getParameter("name");
	pwd = (String)request.getParameter("name");
	
	p = Pattern.compile("[^a-z\\s]+", Pattern.CASE_INSENSITIVE);
	if("".equals(name.trim())){
		nameErr = "Company name is empty";
	} else if(p.matcher(name.trim()).find()) {
		nameErr = "Company name should only have alphabet & space.";
	}
	if("".equals(contactPerson.trim())){
		contactPersonErr = "Name is empty";
	} else if(p.matcher(contactPerson.trim()).find()) {
		contactPersonErr = "Name should only have alphabet & space.";
	}
	
	p = Pattern.compile("[^0-9\\s+-]+", Pattern.CASE_INSENSITIVE);
	if("".equals(mobile.trim())){
		mobileErr = "Mobile number is empty";
	} else if(p.matcher(mobile.trim()).find()) {
		mobileErr = "Mobile number should only have numbers, +, - & space";
	}
	
	
	// validate
	if("".equals(nameErr) && "".equals(contactPersonErr) && "".equals(mobileErr) && "".equals(emailidErr) && "".equals(pwdErr)) {
		valid = true;
	}
	
} else if("edit".equals(request.getParameter("action"))) {
	// fetch & assign

}

if(valid) {
	// save
}


%>
<!DOCTYPE html>
<html>
<head>
  <%@ include file="/admin/partials/head.jsp" %>
  <link href="/admin/plugins/select2/select2.min.css" rel="stylesheet"/>
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
        Company
        <small>Create</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="/admin/companies.jsp"><i class="fa fa-university"></i>Companies</a></li>
		<li><a class="active" href="/admin/create_company.jsp">Create</a></li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
		<div class="row">
		<div class="col-md-8">
			<form action="/admin/create_company.jsp" method="post" name="create" role="form">
				<input type="hidden" name="action" value="create"/>
				<div class="form-group">
					<label for="type" class="control-label">Company type</label>
					<select id="type" name="type" class="form-control">
						<option value="2">Free</option>
						<option value="1">Paid</option>
					</select>
				</div>
				<div class="form-group <%= !"".equals(nameErr) ? "has-error": "" %>">
					<label for="name" class="control-label">Company name</label>
					<input type="text" id="name" name="name" class="form-control" value="<%= name %>"/>
					<% if(!"".equals(nameErr)){ %>
					<span class="help-block"><%= nameErr %></span>
					<% } %>
				</div>
				<div class="form-group">
					<label for="industry" class="control-label">Industry</label>
					
					<%
					try{
						ps = conn.prepareStatement("select AIA_Industrial_Area_Code,AIA_Industrial_Area from admin_industrial_area order by AIA_Industrial_Area");
						rs = ps.executeQuery();
					%>
					<select id="industry" name="industry" class="form-control">
					<% if(rs != null){
						while(rs.next()) {
					%>
					<option value="<%= rs.getString("AIA_Industrial_Area") %>"><%= rs.getString("AIA_Industrial_Area") %></option>
					<% 		}
						}
						rs.close();
						ps.close();
					}catch(Exception e){}
					%>
					</select>
				</div>
				<div class="form-group <%= !"".equals(contactPersonErr) ? "has-error": "" %>">
					<label for="contact-person" class="control-label">Contact person</label>
					<input type="text" id="contact-person" name="contact-person" class="form-control" value="<%= contactPerson %>"/>
					<% if(!"".equals(contactPersonErr)){ %>
					<span class="help-block"><%= contactPersonErr %></span>
					<% } %>
				</div>
				<div class="form-group">
					<label for="address" class="control-label">Address</label>
					<input type="text" id="address" name="address" class="form-control"/>
				</div>
				<div class="form-group">
					<label for="city" class="control-label">City</label>
					
					<%
					try{
						ps = conn.prepareStatement("select ACT_City_Code ,ACT_City_Name   from admin_city order by ACT_City_Name");
						rs = ps.executeQuery();
					%>
					<select id="city" name="city" class="form-control">
					<% if(rs != null){
						while(rs.next()) {
					%>
					<option value="<%= rs.getString("ACT_City_Name") %>"><%= rs.getString("ACT_City_Name") %></option>
					<% 		}
						}
						rs.close();
						ps.close();
					}catch(Exception e){}
					%>
					</select>
				</div>
				<div class="form-group">
					<label for="state" class="control-label">State</label>
					
					<%
					try{
						ps = conn.prepareStatement("select AS_State_Code,AS_State_Name from admin_state order by AS_State_Name");
						rs = ps.executeQuery();
					%>
					<select id="state" name="state" class="form-control">
					<% if(rs != null){
						while(rs.next()) {
					%>
					<option value="<%= rs.getString("AS_State_Name") %>"><%= rs.getString("AS_State_Name") %></option>
					<% 		}
						}
						rs.close();
						ps.close();
					}catch(Exception e){}
					%>
					</select>
				</div>
				<div class="form-group">
					<label for="country" class="control-label">Country</label>
					
					<%
					try{
						ps = conn.prepareStatement("select AC_Country_Code,AC_Country_Name from admin_country order by AC_Country_Name");
						rs = ps.executeQuery();
					%>
					<select id="country" name="country" class="form-control">
					<% if(rs != null){
						while(rs.next()) {
					%>
					<option value="<%= rs.getString("AC_Country_Name") %>"><%= rs.getString("AC_Country_Name") %></option>
					<% 		}
						}
						rs.close();
						ps.close();
					}catch(Exception e){}
					%>
					</select>
				</div>
				<div class="form-group">
					<label for="pin" class="control-label">Pin</label>
					<input type="text" id="pin" name="pin" class="form-control"/>
				</div>
				<div class="form-group <%= !"".equals(mobileErr) ? "has-error": "" %>">
					<label for="mobile" class="control-label">Mobile no</label>
					<input type="text" id="mobile" name="mobile" class="form-control" value="<%= mobile %>"/>
					<% if(!"".equals(mobileErr)){ %>
					<span class="help-block"><%= mobileErr %></span>
					<% } %>
				</div>
				<div class="form-group">
					<label for="emailid" class="control-label">Email id(Username)</label>
					<input type="text" id="emailid" name="emailid" class="form-control"/>
				</div>
				<div class="form-group">
					<label for="password" class="control-label">Password</label>
					<input type="password" id="password" name="password" class="form-control"/>
				</div>
				<div>
					<button type="submit" class="btn btn-default">Save</button>
				</div>
			</form>
		</div>
		<div>
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  
  <%@ include file="./partials/footer.jsp" %>
  
</div>
<!-- ./wrapper -->

<%@ include file="./partials/scripts.jsp" %>
<script type="text/javascript" src="/admin/plugins/select2/select2.full.min.js"></script>
<script type="text/javascript">
 $().ready(function(){
	$('select').select2();
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