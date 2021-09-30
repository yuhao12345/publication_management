function (0):  title uses wildcard search.  We can search any combination of Title, ID, Subject.

Eg: 

	search  Title: rj    ID: 3     return "No valid result is found!"

	search Title: rj               return one article

	No input                       return the whole list of articles



function (5): after insert an author to the given article, 
the return page will show whether the author already exists or new author will be inserted into the author table.
In either case, the writing relation between author and artcle will be updated.

Eg:  Add a new author to Article 1.

Input:

First Name: Suzanne

Last Name: Mitchell

The author is already in table author.

Return : 

	Author Suzanne Mitchell is in the original author table; 

	Author-List of Article 1 is updated


Input:

First Name:sdg

Last Name: bgf

The author is new.

Return: 

	Author sdg bgf is inserted into author table; 

	Author-List of Article 1 is updated