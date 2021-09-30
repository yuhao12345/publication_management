% include('header.tpl')
<!-- Main content should go here-->
<h1>Authors for Article {{article_id}}</h1>

<table class="table table-striped">
    <tr> <th>Author ID</th> <th>First Name</th> <th>Last Name</th> <th>Email</th></Tr>
%for row in rows:
    <tr> 
    <td>{{row[0]}}</td> 
    <td>{{row[1]}}</td> 
    <td>{{row[2]}}</td>
    <td>{{row[3]}}</td>
    </tr>
%end
</table>

% include('footer.tpl')