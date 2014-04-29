
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

Get variants from ClinGenDb
---------------------------
Variants can be obtained by issuing http GET requests. Responses are returned asJSON documents that contains both the data and servers status codes. 
```ruby
# An example usage of the clingendb API 
# @Author Xin Feng 
# @Email xinf@bcm.edu
# @Date 03/19/2014
#

if ARGV.length < 2
  $stderr.puts "Usage: ruby #{$0} query.path query.value"
  exit
end

# Credentials
gbLogin, usrPass = getUP 

# Database configuration
kbName    = 'acmg-Test'
grpName   = 'acmg-apiTest'
collName  = 'acmg-lit'

# Query configuration 
qryVal = ARGV[1].to_s
props  = ARGV[0].to_s

# Url building process
http        = 'http://'
genbHost    = 'genboree.org'
detailed    = '&detailed=true' # Enable full JSON report

rsrcPath    = "/REST/v1/grp/#{grpName}/kb/#{kbName}/coll/#{collName}/docs?"
propPath    = "matchProps=#{props}&matchValue=#{qryVal}"

url = buildURL(genbHost, gbLogin, usrPass, rsrcPath, propPath,  detailed)

page = get(url)

$stderr.puts "Query url:#{page.uri.to_s}"  

$stderr.puts page.body

# Parse the output and output a table-like document
ga= JSON.parse(page.body)
statusCode=ga["status"]["statusCode"]
if statusCode == "OK"
  $stderr.puts "Queried value: #{ARGV[0]}"
  $stderr.puts "Got #{ga["data"].length} variants"
  ga["data"].each do |val|
    doc = val["documentID"]["properties"]
    vals = doc["location"]["properties"]
    print "#{vals["chromosome"]["value"]}\t"
    print "#{vals["startOfGenomicLocus"]["value"]}\t"
    print "#{vals["endOfGenomicLocus"]["value"]}\t"
    print doc["variantNucleotideSequence"]["value"]+ "\t"
    puts doc["referenceNucleotideSequence"]["value"]
  end
end
```

Upload variants to ClinGenDb
---------------------------
Variants can be obtained by issuing http PUT requests. The data file to be uploaded should also be json files that follow a pre-defined data model. An example snippt of codes is:

```ruby
# An example usage of the clingendb API
# to insert a document
# @Author Xin Feng 
# @Email xinf@bcm.edu
# @Date 04/15/2014
#

if ARGV.length < 1 
  $stderr.puts "Usage: ruby #{$0} json.doc"
  exit
end

dataFile = ARGV[0]
dataDoc = JSON.parse( File.read( dataFile ) )
#docID must be the same ID of the dataFile
docID = CGI.escape(dataDoc['documentID']['value']).gsub(/\+/,'%20')

# Credentials
gbLogin, usrPass = getUP 

# Database configuration
kbName    = 'acmg-Test'
grpName   = 'acmg-apiTest'
collName  = 'acmg-lit'

# Url building process
http     = 'http://'
genbHost = 'genboree.org'

rsrcPath = "/REST/v1/grp/#{grpName}/kb/#{kbName}/coll/#{collName}/doc/#{docID}?"
propPath = '' 
detailed = '' 

url = buildURL(genbHost, gbLogin, usrPass, rsrcPath, propPath,  detailed)
page = put(url,dataDoc.to_json)
puts page.body
puts page.uri.to_s
```

Server responses codes
-----------------------
The API is equipped with data validation as well as access control. Invalid documents or URIs will be raised by the server and error codes will be reported. For a list of common error codes, please refer to the attached files.

Genboree Commons for other information
----------------
Please visit Genboree Commons to reach other information and start followup
discussions. You could reach the commons at: http://genboree.org/theCommons/projects
