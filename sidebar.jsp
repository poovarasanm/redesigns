<!-- Left side column. contains the logo and sidebar -->
<%
String currentUri = request.getRequestURI();
 %>
<aside class="main-sidebar">
<!-- sidebar: style can be found in sidebar.less -->
<section class="sidebar">
  <!-- sidebar menu: : style can be found in sidebar.less -->
  <ul class="sidebar-menu">
	<li class="header">MAIN NAVIGATION</li>
	<li class="active treeview">
	  <a href="#">
		<i class="fa fa-graduation-cap"></i> <span>Candidates</span> <i class="fa fa-angle-left pull-right"></i>
	  </a>
	  <ul class="treeview-menu">
		<li class="<%= (currentUri.indexOf("admin/search_candidates") > -1 || currentUri.indexOf("admin/candidates") > -1 ) ? "active" : "" %>"><a href="/admin/search_candidates.jsp">
			<i class="fa fa-circle-o"></i>Search</a>
		</li>
		<li><a href="index.html"><i class="fa fa-circle-o"></i>Rs. 600/- Candidates</a></li>
	  </ul>
	</li>
	<li class="treeview">
	  <a href="#">
		<i class="fa fa-university"></i>
		<span>Companies</span>
		<span class="label label-primary pull-right">4</span>
	  </a>
	  <ul class="treeview-menu">
		<li><a href="pages/layout/top-nav.html"><i class="fa fa-circle-o"></i>Search</a></li>
		<li><a href="pages/layout/boxed.html"><i class="fa fa-circle-o"></i>Free Companies</a></li>
		<li><a href="pages/layout/boxed.html"><i class="fa fa-circle-o"></i>Paid Companies</a></li>
		<li><a href="pages/layout/top-nav.html"><i class="fa fa-circle-o"></i>Add</a></li>		
		<li><a href="pages/layout/top-nav.html"><i class="fa fa-circle-o"></i>Add an Employee</a></li>
		<li><a href="pages/layout/top-nav.html"><i class="fa fa-circle-o"></i>Employees</a></li>
	  </ul>
	</li>
	<li class="treeview">
	  <a href="#">
		<i class="fa fa-pie-chart"></i>
		<span>Agents</span>
		<i class="fa fa-angle-left pull-right"></i>
	  </a>
	  <ul class="treeview-menu">
		<li><a href="pages/charts/chartjs.html"><i class="fa fa-circle-o"></i> Add</a></li>
		<li><a href="pages/charts/morris.html"><i class="fa fa-circle-o"></i> List</a></li>
	  </ul>
	</li>
	<li class="treeview">
	  <a href="#">
		<i class="fa fa-pie-chart"></i>
		<span>Franchise</span>
		<i class="fa fa-angle-left pull-right"></i>
	  </a>
	  <ul class="treeview-menu">
		<li><a href="pages/charts/chartjs.html"><i class="fa fa-circle-o"></i> Add</a></li>
		<li><a href="pages/charts/morris.html"><i class="fa fa-circle-o"></i> List</a></li>
	  </ul>
	</li>
	<li class="treeview">
	  <a href="#">
		<i class="fa fa-pie-chart"></i>
		<span>Jobs</span>
		<i class="fa fa-angle-left pull-right"></i>
	  </a>
	  <ul class="treeview-menu">
		<li><a href="pages/charts/chartjs.html"><i class="fa fa-circle-o"></i> Add</a></li>
		<li><a href="pages/charts/morris.html"><i class="fa fa-circle-o"></i> List</a></li>
	  </ul>
	 </li>
	 <li class="header">MASTER DATABASE</li>
	 <li class="treeview">
	  <a href="#">
		<i class="fa fa-pie-chart"></i>
		<span>State</span>
		<i class="fa fa-angle-left pull-right"></i>
	  </a>
	  <ul class="treeview-menu">
		<li><a href="pages/charts/chartjs.html"><i class="fa fa-circle-o"></i>Add</a></li>
		<li><a href="pages/charts/morris.html"><i class="fa fa-circle-o"></i> List</a></li>
	  </ul>
	 </li>
	 <li class="treeview">
	  <a href="#">
		<i class="fa fa-pie-chart"></i>
		<span>City</span>
		<i class="fa fa-angle-left pull-right"></i>
	  </a>
	  <ul class="treeview-menu">
		<li><a href="pages/charts/chartjs.html"><i class="fa fa-circle-o"></i>Add</a></li>
		<li><a href="pages/charts/morris.html"><i class="fa fa-circle-o"></i> List</a></li>
	  </ul>
	 </li>
	 <li class="treeview">
	  <a href="#">
		<i class="fa fa-pie-chart"></i>
		<span>Functional Ara</span>
		<i class="fa fa-angle-left pull-right"></i>
	  </a>
	  <ul class="treeview-menu">
		<li><a href="pages/charts/chartjs.html"><i class="fa fa-circle-o"></i>Add</a></li>
		<li><a href="pages/charts/morris.html"><i class="fa fa-circle-o"></i> List</a></li>
	  </ul>
	 </li>
	 <li class="treeview">
	  <a href="#">
		<i class="fa fa-pie-chart"></i>
		<span>Industrial Area</span>
		<i class="fa fa-angle-left pull-right"></i>
	  </a>
	  <ul class="treeview-menu">
		<li><a href="pages/charts/chartjs.html"><i class="fa fa-circle-o"></i>Add</a></li>
		<li><a href="pages/charts/morris.html"><i class="fa fa-circle-o"></i> List</a></li>
	  </ul>
	 </li>
	 <li class="treeview">
	  <a href="#">
		<i class="fa fa-pie-chart"></i>
		<span>University</span>
		<i class="fa fa-angle-left pull-right"></i>
	  </a>
	  <ul class="treeview-menu">
		<li><a href="pages/charts/chartjs.html"><i class="fa fa-circle-o"></i>Add</a></li>
		<li><a href="pages/charts/morris.html"><i class="fa fa-circle-o"></i> List</a></li>
	  </ul>
	 </li>
	 <li class="treeview">
	  <a href="#">
		<i class="fa fa-pie-chart"></i>
		<span>Qualification</span>
		<i class="fa fa-angle-left pull-right"></i>
	  </a>
	  <ul class="treeview-menu">
		<li><a href="pages/charts/chartjs.html"><i class="fa fa-circle-o"></i>Add</a></li>
		<li><a href="pages/charts/morris.html"><i class="fa fa-circle-o"></i> List</a></li>
	  </ul>
	 </li>
  </ul>
</section>
<!-- /.sidebar -->
</aside>