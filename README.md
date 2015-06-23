If you are here for ClinVar data, please visit: https://github.com/clingendb/clinvar_xml_pipe for more details.

Getting Started
===============
If you have any questions regarding this tutorial, please contact Xin Feng at: xinf@bcm.edu.

This tutorial demostrates example usage of the ClinGenDb API.
Before trying the codes, please register via http://genboree.org. Please follow this FAQ if you have problems signing up: http://genboree.org/theCommons/ezfaq/show/public-commons?faq_id=493

ClinGenDb API follows typical REST API styles. Querying and uploading
variants can be acomplished by visiting coressponding URIs. The following
part contains two sections that illustrates the use of http GET and PUT.

The ClinGenDb UI
----------------
Although not directly related to API, the UI may help visualize the data structure and validate uploaded documents. Please view the prototype of UI at: http://genboree.org/genboreeKB/genboree_kbs?project_id=acmg-apitest

Autherization process
---------------------
ClinGenDb uses a token-based authorization procedure. A security token is 
calculated and properly attached to the query URL to pass the user validation 
process. Before you could access the database and visit any URIs, you will need to first register via genboree.org.

The details of calculating the proper tokens can be found in the attached ppts.

Setup
-----------------
Before running these commands, please edit
```ruby
up.rb
```
to include your credentials:
```ruby
def getUP
  ["username","password"] #Provide your credentials here
end
```


And please add the path to this folder to your ruby_path:
```ruby
export RUBYLIB=$RUBYLIB:/PATH/TO/THIS/FOLDER
```

Example codes
------------------------
Purpose | Script | 
--- | --- | 
Upload a document to an existing collection | https://github.com/clinvar/apidemo/blob/master/uploadDoc.rb 
Search/Get a specific document in collection | https://github.com/clinvar/apidemo/blob/master/genericQuery.rb  
Delete specific record in a collection |  https://github.com/clinvar/apidemo/blob/master/deleteDoc.rb
Create a new collection for storing documents in ClinGenDB | https://github.com/clinvar/apidemo/blob/master/createCollection.rb

Server responses codes
-----------------------
  The API is equipped with data validation as well as access control. Invalid documents or URIs will be raised by the server and error codes will be reported. For a list of common error codes, please refer to the attached files in doc folder.

Genboree Commons for other information
----------------
  Please visit Genboree Commons to reach other information and start followup
  discussions. You could reach the commons at: http://genboree.org/theCommons/projects
