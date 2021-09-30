% include('header.tpl')
<!-- Main content should go here-->
<h1>Add Author for Article {{article_id}}</h1>  

<form action="/add_author?article_id={{article_id}}" method="post">
    First Name:<br> <input type="text" name="first_name"> <br>
    Last Name:<br> <input type="text" name="last_name"> <br>
    Email:<br> <input type="text" name="email"> <br>
    <input type="submit" value="Add New Author">
</form>
% include('footer.tpl')