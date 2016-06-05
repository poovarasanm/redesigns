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
String joins = " FROM agentregistration";
String countQuery = "SELECT COUNT(agentid)";

query += "agentid, agentcode, username, agentname, emailid, phoneno, mobileno";
query += ", address, state, city, zipcode, addeddate";
query += ", typeof, fromdate, todate, loginstatus";

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

query += " ORDER BY agentid DESC LIMIT " + start + ", " + perPage;

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
        Agents
        <small>All</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-university"></i>Home</a></li>
		<li><a class="active" href="admin/agents.jsp">Agents</a></li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
		<form action="/admin/agents.jsp" method="post" name="search">
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
		<% if(rs != null){ %>
		<% while(rs.next()){ %>
			<div class="row company" id="company<%=rs.getString(1)%>" style="border-bottom: 2px ridge #E6D7D7; padding: 8px 12px; margin: 8px">
				<div class="col-md-4">
					<div class="row">
						<span class="col-md-4">Agent name</span>
						<span class="col-md-8"><%= rs.getString("agentname") %></span>
					</div>
					<div class="row">
						<span class="col-md-4">Username</span>
						<span class="col-md-8"><%= rs.getString("username") %></span>
					</div>
					<div class="row">
						<span class="col-md-4">Email id</span>
						<span class="col-md-8"><%= rs.getString("emailid") %></span>
					</div>				
				</div>
				<div class="col-md-4">
					<div class="row">
						<span class="col-md-4">Contact nos</span>
						<span class="col-md-8">
							<% out.print(rs.getString("phoneno") == null ? "" : rs.getString("phoneno"));  %>
							<% out.print(rs.getString("mobileno") == null ? "" : "," + rs.getString("mobileno")); %>
						</span>
					</div>
					<div class="row">
						<span class="col-md-4">Address</span>
						<span class="col-md-8" style="overflow: scroll">
						<% out.print(rs.getString("address") == null ? "" : rs.getString("address")); %>
						<% out.print(rs.getString("city") == null ? "" : ",<br/>" + rs.getString("city")); %>
						<% out.print(rs.getString("state") == null ? "" : ",<br/>" + rs.getString("state")); %>
						<% out.print(rs.getString("zipcode") == null ? "" : ",<br/>" + rs.getString("zipcode")); %>
						</span>
					</div>
				</div>
				<div class="col-md-2">
					<div class="row">
						<span class="col-md-4">Active date</span>
						<span class="col-md-8">
						<% out.println(rs.getString("fromdate") != null ? rs.getString("fromdate") : ""); %>
						<% out.println(rs.getString("todate") != null ? " - "+rs.getString("todate") : ""); %>
						</span>
					</div>
					<div class="row">
						<span class="col-md-4">Status</span>
						<span class="col-md-8"><% out.println(rs.getInt("loginstatus") == 1 ? "Active" : "Inactive"); %></span>
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