
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

The ruby gem/packge mechanize also needs to be installed.
```ruby
gem install mechanize
```

And please add the path to this folder to your ruby_path:
```ruby
export RUBYLIB=$RUBYLIB:/PATH/TO/THIS/FOLDER
```

Data document validation
-----------------------
To get started, the method requires a valid existing collection and a data document in JSON format.

Assume we have a collection with the document model defined in 

```ruby
data/validation/model.json
```
And the collection's name is raj103020140.1.

To run this example:
```ruby
ruby dataDocValidation.rb raj103020140.1 data/validation/bad_docs/wrong_name.json acmg-Test
```
The file wrong_name.json intentionally spelled "properties" as "property"

Server responses
-----------------

If the data document is invalid, the server response may look like:

```ruby
{"status":{"msg":"DOC_REJECTED: your document was rejected because validation failed. Validation complained that: ERROR: the document does not match the data model schema for the raj103020140.1 collection! Specifically:\n  - ERROR: The root property of a document can only have 'properties' or 'value' as keys and nothing else. You have: propertie\n  - ERROR: there are some missing required sub-properties under the \"DocumentID\" property. Specifically, the model says the following sub-properties are required, but they are not present in the doc: \"dateOfLitSearch\", \"diseaseID\", \"numIndependentClinicalReports\", \"numReturnedSearchResults\", \"pubmedSearchQuery\", \"timeToComplete\"","relatedJobIds":[],"statusCode":"Not Acceptable"},"data":{}}
```
The "msg" section describes the specific reasons for the failure.
In comparison, for a valid document, the server will respond like:
```ruby
{
  "data": {
   .... # Details omitted
   },
  "status": {
  "msg": "OK",
  "statusCode": "OK"
   }
}
```

The API is equipped with data validation as well as access control. Invalid documents or URIs will be raised by the server and error codes will be reported. For a list of common error codes, please refer to the attached files in doc folder.

Genboree Commons for other information
----------------
Please visit Genboree Commons to reach other information and start followup
discussions. You could reach the commons at: http://genboree.org/theCommons/projects
