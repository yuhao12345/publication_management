% include('header.tpl')
<!-- Main content should go here-->
<h1>Articles</h1>

<table class="table table-striped">
    <tr> <td> <a href="/article_insert">Insert new article</a> </td> </Tr>
	<tr> <th>Article ID</th> <th>Title</th> <th>Operations</th> </Tr>
	
%if len(rows)==0:
    <td>No valid result is found!</td>
%end	

%for row in rows:
    <tr>
    <td>{{row[0]}}</td>  
    <td>{{row[1]}}</td>

    <td> <a href="/articles?article_id={{str(row[0])}}">View / Edit</a> </td>
    <td> <a href="/articles/delete?article_id={{str(row[0])}}">Delete</a></td> 
    <td> <a href="/authors?article_id={{str(row[0])}}">Show authors</a></td> 
    <td> <a href="/add_author?article_id={{str(row[0])}}">Add new author</a> </td>
    </tr>
%end

</table>

% include('footer.tpl')