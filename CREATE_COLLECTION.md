
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

Create new collections
-----------------------
To get started, the method needs a name for the new collection and a JSON file which defines the document model for the new collection.

A example JSON document model is:

```ruby
{
  "name": "DocumentID",
    "identifier": true,
    "description": "Document ID",
    "required": true,
    "domain": "regexp(UPD[0-9]{6})"
}
```

An example ruby program to call the API:

```ruby
# An example usage of the clingendb API
# to create a new collection
#
# @Author Xin Feng 
# @Email xinf@bcm.edu
# @Date 10/21/2014
#

require 'rest'
require 'urlb'
require 'up'

if ARGV.length < 2
$stderr.puts "Usage: ruby #{$0} collection.name model.in.json"
$stderr.puts "Example: ruby #{$0} test0.1 example_collections/simple.model.json"
exit
end

  dataFile = ARGV[1]
dataDoc = JSON.parse( File.read( dataFile ) )


# Credentials
  gbLogin, usrPass = getUP 

# Database configuration
  kbName    = 'acmg-Test'
  grpName   = 'acmg-apiTest'
  collName  = ARGV[0]

# Url building process
  http     = 'http://'
  genbHost = 'genboree.org'

  rsrcPath = "/REST/v1/grp/#{grpName}/kb/#{kbName}/coll/#{collName}/model?"
  propPath = '' 
  detailed = '' 

url = buildURL(genbHost, gbLogin, usrPass, rsrcPath, propPath, detailed)

code,resp = api_put(url,dataDoc.to_json)
  if code.to_i > 300
  $stderr.puts "Request failed"
  end
  puts resp
```

To run this example:
```ruby
ruby createCollection.rb test0.1 example_collections/simple.model.json
```

Server responses 
-----------------------
If the job went well, the response may look like:
 ```ruby
{
  "status": {
    "statusCode": "Created",
      "msg": "NEW_DOC_MODEL: your new model document was saved."
  },
    "data": {
    }
}
```

If a collection with the same name exisits, the response may look like:
```ruby
{
  "status": {
    "statusCode": "Bad Request",
      "msg": "BAD_REQUEST: A model document for the collection test0.2 already exists. Updating an exising model is currently not allowed since changing the model inappropriately can lead to all the documents in a collection becoming invalid."
  },
    "data": {
    }
}
```

If the JSON document model has errors in it, the response will explain the errors:
```ruby
{
  "status": {
   "statusCode": "Unsupported Media Type",
     "msg": "BAD_MODEL_DOC: The model you provided does not match the GenboreeKB specifications:\n\nERROR: the root property is missing the required 'name' field or it doesn't have a value."
   },
    "data": {
    }
}
```
The API is equipped with data validation as well as access control. Invalid documents or URIs will be raised by the server and error codes will be reported. For a list of common error codes, please refer to the attached files in doc folder.

Genboree Commons for other information
----------------
Please visit Genboree Commons to reach other information and start followup
discussions. You could reach the commons at: http://genboree.org/theCommons/projects
