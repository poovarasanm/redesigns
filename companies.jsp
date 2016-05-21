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
String conds = "";
String joins = " FROM company_registration";
String countQuery = "SELECT COUNT(CR_code_id)";

query += "CR_code_id, CR_code, CR_name, CR_industry_type, CR_contact_person, CR_Address, CR_email_id";
query += ", CR_phone_no, CR_mobile_no, CR_Website, CR_username, CR_payment_type";
query += ", CR_deleted_flag, CR_act_deact, CR_date_time, CR_City, CR_State, CR_Country, CR_Zipcode";

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

query += " ORDER BY CR_code_id DESC LIMIT " + start + ", " + perPage;

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
        Companies
        <small>All</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-university"></i>Home</a></li>
        <li><a href="admin/search_candidate.jsp">Search Candidates</a></li>
		<li><a class="active" href="admin/companies.jsp">Companies</a></li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
		<form action="/admin/companies.jsp" method="post" name="search">
		
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
						<span class="col-md-4">Name</span>
						<span class="col-md-8"><%= rs.getString("CR_name") %></span>
					</div>
					<div class="row">
						<span class="col-md-4">Industry</span>
						<span class="col-md-8"><%= rs.getString("CR_industry_type") %></span>
					</div>
					<div class="row">
						<span class="col-md-4">Website</span>
						<span class="col-md-8"><%= rs.getString("CR_Website") %></span>
					</div>
					<div class="row">
						<span class="col-md-4">Email id</span>
						<span class="col-md-8"><%= rs.getString("CR_email_id") %></span>
					</div>					
				</div>
				<div class="col-md-4">
					<div class="row">
						<span class="col-md-4">Contact person</span>
						<span class="col-md-8"><%= rs.getString("CR_contact_person") %></span>
					</div>
					<div class="row">
						<span class="col-md-4">Username</span>
						<span class="col-md-8"><%= rs.getString("CR_username") %></span>
					</div>
					<div class="row">
						<span class="col-md-4">Contact nos</span>
						<span class="col-md-8">
						<% out.print(rs.getString("CR_phone_no") == null ? "" : rs.getString("CR_phone_no"));  %>
						<% out.print(rs.getString("CR_mobile_no") == null ? "" : "," + rs.getString("CR_mobile_no")); %>
						</span>
					</div>
					
				</div>
				<div class="col-md-2">
					<div class="row">
						<span class="col-md-4">Address</span>
						<span class="col-md-8" style="overflow: scroll">
						<% out.print(rs.getString("CR_Address") == null ? "" : rs.getString("CR_Address")); %>
						<% out.print(rs.getString("CR_City") == null ? "" : ",<br/>" + rs.getString("CR_City")); %>
						<% out.print(rs.getString("CR_State") == null ? "" : ",<br/>" + rs.getString("CR_State")); %>
						</span>
					</div>
				</div>
				<div class="col-md-2 actions">
					<%
					String pType = rs.getString("CR_payment_type");
					String status = rs.getString("CR_act_deact");
					String typeIconName = "";
					String statusIconName = "";
					String typeTitle = "";
					String statusTitle = "";
					if(pType != null) {
						if("2".equals(pType)) {
						typeIconName = "inr";
						typeTitle = "Paid Company";
					} else if("1".equals(pType)) {
							typeIconName = "gift";
							typeTitle = "Free Company";
						}
					}
					
					if(status != null) {
						if("2".equals(status)) {
						statusIconName = "close";
						statusTitle = "Inactive";
					} else if("1".equals(status)) {
							statusIconName = "check";
							statusTitle = "Active";
						}
					}
					%>
					<i class="fa fa-<%= typeIconName %>" title="<%= typeTitle %>"></i>
					<i class="fa fa-<%= statusIconName %>" title="<%= statusTitle %>"></i>
					<% if(rs.getString("CR_deleted_flag") != null) { %>
					<i class="fa fa-trash" title="Deleted"></i>
					<% } %>
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