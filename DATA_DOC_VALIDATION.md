
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
Although not directly relatected to API, the UI may help visualize the data structure and validate uploaded documents. Please view the prototype of UI at: http://genboree.org/genboreeKB/genboree_kbs?project_id=acmg-apitest

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
ruby dataDocValidation.rb raj103020140.1 data/validation/bad_docs/wrong_name.json
```
The file wrong_name.json intentionally spelled "properties" as "property"

And the response looks like:

```ruby
{
  "data": {
    },
   "status": {
      "msg": "BAD_MODEL_DOC: The model you provided does not match the GenboreeKB specifications:\n\nERROR: the root property is missing the required 'name' field or it doesn't have a value.",
      "statusCode": "Unsupported Media Type"
   }
}
```

The API is equipped with data validation as well as access control. Invalid documents or URIs will be raised by the server and error codes will be reported. For a list of common error codes, please refer to the attached files in doc folder.

Genboree Commons for other information
----------------
Please visit Genboree Commons to reach other information and start followup
discussions. You could reach the commons at: http://genboree.org/theCommons/projects
