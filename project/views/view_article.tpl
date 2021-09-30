% include('header.tpl')

<!-- Main content should go here-->
<h1>Article View/Edit</h1>
<tr> ID:{{article_id}}</tr>

<form action="/articles?article_id={{article_id}}" method="post">
    Title:<br> <input type="text" name="title" value={{title}}> <Br>
	Subject: <br><select name="Subject"> 
		<option>{{subject}}</option>
		<option>cs</option>
		<option>phys</option>
		<option>chem</option>
		<option>geom</option>
		<option>biol</option>
		<option>math</option>
		<option>engl</option>
		<option>stat</option>
	</select></br>
    Article length:<br> <input type="text" name="Length" value={{length}}><br>
    <br>
    <input type="submit" value="Update Article">
</form>
% include('footer.tpl')
