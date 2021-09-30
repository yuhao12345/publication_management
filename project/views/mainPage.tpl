% include('header.tpl')
<!-- Main content should go here-->
<h1>Article Search</h1>

<form action="/" method="post">
	Title*: <input type="text" name="title">
	ID: <input type="text" name="article_ID">
	Subject: <select name="Subject"> 
		<option></option>
		<option>cs</option>
		<option>phys</option>
		<option>chem</option>
		<option>geom</option>
		<option>biol</option>
		<option>math</option>
		<option>engl</option>
		<option>stat</option>
	</select>
    
	<input type="submit">
</form>
% include('footer.tpl')