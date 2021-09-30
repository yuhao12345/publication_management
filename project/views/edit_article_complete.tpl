% include('header.tpl')
<!-- Main content should go here-->
<h1>Edit Article status</h1>  

<table class="table table-striped">
    <tr>
    <td> Article {{article_id}} belongs to Subject:{{subject}} is updated</td>
    </tr>
    <tr>
    <td> <a href="/searchresult?subject={{subject}}">View updated list of articles in Subject: {{subject}}</a> </td>
    </tr>


</table>

% include('footer.tpl')