<input type="hidden" name="page" value="<% out.print(request.getParameter("page") == null ? "0" : request.getParameter("page"));  %>"/>
		<% if(pages > 1) {
			int startPage = pageNo - 5;
			int endPage = pageNo + 5;
			int totalPages = pages;

			if (startPage <= 0) {
				endPage -= (startPage - 1);
				startPage = 1;
			}

			if (endPage > pages)
				endPage = pages;
		%>
		<div class="row">
			<div class="col-md-8 btn-group" role="group">
				<button type="submit" value="0" <% out.print((1==startPage) ? "disabled":""); %> class="btn btn-default" onclick="document.search.page.value=0;">&lt;&lt;</button>
				<button type="submit" <% out.print((1==startPage) ? "disabled":""); %> onclick="document.search.page.value=<%= pageNo-1 %>;" class="btn btn-default">&lt;</button>
				<% for(int i=startPage-1; i < endPage; i++) { %>
					<button type="submit" value="<%= pageNo %>" onclick="document.search.page.value=<%= i %>;" class="btn btn-default" <% out.print((i==pageNo) ? "disabled":""); %>><% out.print(i+1); %></button>
				<% }%>
				<button type="submit" class="btn btn-default" onclick="document.search.page.value=<%= pageNo+1 %>;"
				<% out.print((endPage==pages) ? "disabled":""); %>>&gt;</button>
				<button type="submit" class="btn btn-default" onclick="document.search.page.value=<%= pages-1 %>;"
				<% out.print((endPage==pages) ? "disabled":""); %> >&gt;&gt;</button>
				<input type="text" class="btn btn-default" id="goto" style="width: 59px" placeholder="page#"/>
				<button class="btn btn-default" onclick="document.search.page.value=document.getElementById('goto').value-1;">Go</button>
				Total <%= rows %> records.
			</div>
		</div>
		<% } %>