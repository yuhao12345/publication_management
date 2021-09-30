from bottle import Bottle, route, post, get, HTTPResponse, request, response, template, redirect
import bottle
import os
import sys
import psycopg2 as pg
import logging
import argparse


#The logging level to control what messages are shown (skipping debug)
logging.basicConfig(level=logging.INFO)

#Our bottle app, using the default. We can store variables in app
app = bottle.default_app()


### function (0).  title is wildcard search
@route("/")
def search():
    return template('mainPage',page_name='Article search')
    
@route('/',method='POST')
def do_search():
    title=request.forms.get('title')
    article_id=request.forms.get('article_ID')
    subject=request.forms.get('Subject')
    redirect('/searchresult?title=%s&article_id=%s&subject=%s'%(title,article_id,subject))


### function (1)
@route('/searchresult')
def list_article():
    title=request.query.title
    article_id=request.query.article_id
    subject=request.query.subject
    if not subject:
        if article_id=="" and title:
            cur.execute("select * from article where title like %s order by article_id limit 20",('%'+title+'%',))
        elif title=="" and article_id:
            cur.execute("select * from article where article_id = %s order by article_id limit 20",(article_id,))
        elif title=="" and article_id=="":
            cur.execute("select * from article order by article_id limit 20")
        else:
            cur.execute("select * from article where article_id = %s and title like %s order by article_id limit 20",(article_id,'%'+title+'%',))
    else:
        if article_id=="" and title:
            cur.execute("select * from article where title like %s and subject=%s order by article_id limit 20",('%'+title+'%',subject,))
        elif title=="" and article_id:
            cur.execute("select * from article where article_id = %s and subject=%s order by article_id limit 20",(article_id,subject,))
        elif title=="" and article_id=="":
            cur.execute("select * from article where subject=%s order by article_id limit 20",(subject,))
        else:
            cur.execute("select * from article where article_id = %s and title like %s and subject=%s order by article_id limit 20",(article_id,'%'+title+'%',subject,))
    result=cur.fetchall()
    # in template 'list_article', when result is empty, display "No valid result is found!"
    return template('list_article',rows=result,page_name='Article List')


### function (2): view and edit article
@route('/articles')
def view_article():
    article_id=request.query.article_id
    cur.execute("select * from article where article_id = %s",(article_id,))
    row = cur.fetchone()
    return template('view_article',article_id=row[0],title=row[1],
                subject=row[2],length=row[3],page_name='view Article')

### update or insert article based on whether article_id is ''. Both function (2) and (6) will come here
@route('/articles',method='POST')
def edit_article():
    article_id=request.query.article_id
    title=request.forms.get('title')
    subject=request.forms.get('Subject')
    length=request.forms.get('Length')
    # error handling for insert or update article
    # title cannot be empty, length must be integer
    if title=='':
        return "Error: The updated title is empty"
    try:
        int(length)
    except:
        return "Error: length is not an integer number."
    # update article
    if article_id != '':
        cur.execute("update article set title=%s,subject=%s,length=%s \
                        where article_id=%s",(title,subject,length,article_id,))
    # insert article
    else:
        if length=='': length=None
        if subject=='': subject=None
        cur.execute("insert into article(title, subject, length) values(%s,%s,%s)",(title,subject,length,))
    app.db_connection.commit()
    return template('edit_article_complete',subject=subject,article_id=article_id,page_name='Complete Updating Article')


### function (3): delete an article
@route('/articles/delete')   
def delete_article():
    article_id=request.query.article_id
    cur.execute("delete from article where article_id=%s",(article_id,))
    app.db_connection.commit()
    return template('delete_article_complete',article_id=article_id,page_name='Complete Deleting Article')
    

### function (4): show list of authors coreesponding to the given article
@route('/authors')  
def view_author():
    article_id=request.query.article_id
    cur.execute("select author_ID,first_name,last_name,email\
                from (select * from writing where article_id = %s) as tmp\
                inner join author\
                using(author_ID) order by author_ID",(article_id,))
    result=cur.fetchall()
    return template('view_author',article_id=article_id,rows=result,page_name='view Author')

### function (5): add new author to an article
@route('/add_author')  #add author for a given article
def add_author():
    article_id=request.query.article_id
    return template('add_author',article_id=article_id,page_name='add Author')


### check of the added author is in the original author table, then redirect to the page /add_author_status
@route('/add_author',method='POST')  #add author for a given article
def do_add_author():
    article_id=request.query.article_id
    first_name=request.forms.get('first_name')
    last_name=request.forms.get('last_name')
    email=request.forms.get('email')
    # check if this author exists in the current author table
    cur.execute("select exists(select 1 from author where first_name=%s and last_name=%s)",(first_name,last_name,))
    ExistingAuthorOrNot=cur.fetchone()[0]   # If the added author is already in author table

    redirect('/add_author_status?article_id=%s&ExistingAuthorOrNot=%s&first_name=%s&last_name=%s&email=%s'%(article_id,ExistingAuthorOrNot,first_name,last_name,email))

### if the author is already in the author table, just update the writing relation between author and article
### if the author is new, then add author to the author table, obtain the id of this new author, then update the wrting relation
@route('/add_author_status')
def show_added_author_status():
    article_id=request.query.article_id
    ExistingAuthorOrNot=request.query.ExistingAuthorOrNot
    first_name=request.query.first_name
    last_name=request.query.last_name
    email=request.query.email
    if ExistingAuthorOrNot=="True":
        #get ID of the inserted author in the old author table
        cur.execute("select author_ID from author where first_name=%s and last_name=%s",(first_name,last_name,))
        author_id=cur.fetchone()[0]  # new author ID
        #update writing relation
        cur.execute("insert into writing(article_ID,author_ID) values (%s, %s)",(article_id,author_id))
        app.db_connection.commit()

    else:
        #update author table
        cur.execute("insert into author(first_name,last_name,email) values (%s, %s, %s)",\
                    (first_name,last_name,email))
        #get the ID of new author
        cur.execute("select author_ID from author where first_name=%s and last_name=%s",(first_name,last_name,))
        author_id=cur.fetchone()[0]  # new author ID
        #update writing relation
        cur.execute("insert into writing(article_ID,author_ID) values (%s, %s)",(article_id,author_id))
        app.db_connection.commit()
    return template('add_author_complete',\
                    page_name='Complete Adding Author',first_name=first_name,last_name=last_name,\
                        article_id=article_id,ExistingAuthorOrNot=ExistingAuthorOrNot)


### function (6): create new record of article, share template view_article  with function (2)
@route('/article_insert')
def insert_article():
    return template('view_article',article_id='',title='',
                subject='',length='',page_name='view Article')



#The main function to start the server
if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-c","--config",
        help="The path to the .conf configuration file.",
        default="server.conf"
    )
    parser.add_argument(
        "--host",
        help="Server hostname (default localhost)",
        default="localhost"
    )
    parser.add_argument(
        "-p","--port",
        help="Server port (default 53001)",
        default=53001,
        type=int
    )
    parser.add_argument(
        "--nodb",
        help="Disable DB connection on startup",
        action="store_true"
    )

    #Get the arguments
    args = parser.parse_args()
    if not os.path.isfile(args.config):
        logging.error("The file \"{}\" does not exist!".format(args.config))
        sys.exit(1)

    app.config.load_config(args.config)

    # Below is how to connect to a database. We put a connection in the default bottle application, app
    if not args.nodb:
        try:
            app.db_connection = pg.connect(
                dbname = app.config['db.dbname'],
                user = app.config['db.user'],
                password = app.config.get('db.password'),
                host = app.config['db.host'],
                port = app.config['db.port']
            )
            
            cur=app.db_connection.cursor()
            cur.execute("select * from author limit 5")
            rows=cur.fetchall()
            rows
            
        except KeyError as e:
            logging.error("Is your configuration file ({})".format(args.config) +
                        " missing options?")
            raise

    try:
        logging.info("Starting Bottle Web Server")
        app.run(host=args.host, port=args.port, debug=True)
    finally:
        #Ensure that the connection opened is closed 
        if not args.nodb:
            app.db_connection.close()

