% include('header.tpl')
<!-- Main content should go here-->
<h1>Add Author status</h1>  

<table class="table table-striped">
%if ExistingAuthorOrNot=="True":
    <tr>
    <td>Author {{first_name}} {{last_name}} is in the original author table </td>  
    </tr>
%else:
    <tr>
    <td>Author {{first_name}} {{last_name}} is inserted into author table </td>  
    </tr>
%end
    <tr>
    <td>Author-List of Article {{article_id}} is updated</td>
    </tr>
    <tr>
    <td> <a href="/authors?article_id={{article_id}}">View updated author-list of Article {{article_id}}</a> </td>
    </tr>


</table>

% include('footer.tpl')