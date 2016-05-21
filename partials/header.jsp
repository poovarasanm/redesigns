<%
String username = "";
if(session.getAttribute("usernamesession") != null) { 
	username = (String)session.getAttribute("usernamesession");
}
%>
<header class="main-header">
<!-- Logo -->
<a href="index2.html" class="logo">
  <!-- mini logo for sidebar mini 50x50 pixels -->
  <span class="logo-mini"><b>JJ</b>Ind</span>
  <!-- logo for regular state and mobile devices -->
  <span class="logo-lg"><b>JobJunction</b>India</span>
</a>
<!-- Header Navbar: style can be found in header.less -->
<nav class="navbar navbar-static-top">
  <!-- Sidebar toggle button-->
  <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
	<span class="sr-only">Toggle navigation</span>
  </a>

  <div class="navbar-custom-menu">
	<ul class="nav navbar-nav">
	  
	  <!-- User Account: style can be found in dropdown.less -->
	  <li class="dropdown user user-menu">
		<a href="#" class="dropdown-toggle" data-toggle="dropdown">
		  <span class="hidden-xs"><%= username %></span>
		</a>
		<ul class="dropdown-menu">
		  <!-- User image -->
		  <li class="user-header">

			<p>
			  <%= username %>
			  <small>&nbsp;</small>
			</p>
		  </li>
		  <!-- Menu Body -->
		  <li class="user-body">
		  </li>
		  <!-- Menu Footer-->
		  <li class="user-footer">
			<div class="pull-left">
			  <a href="#" class="btn btn-default btn-flat">Profile</a>
			</div>
			<div class="pull-right">
			  <a href="#" class="btn btn-default btn-flat">Sign out</a>
			</div>
		  </li>
		</ul>
	  </li>
	</ul>
  </div>
</nav>
</header>