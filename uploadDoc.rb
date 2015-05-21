# An example usage of the clingendb API
# to upload a document into a collection
#
# @Author Xin Feng 
# @Email xinf@bcm.edu
# @Date 11/10/2014
#

require 'rest'
require 'urlb'
require 'up'
require 'json'
require 'cgi'
if ARGV.length < 3
  $stderr.puts "Usage: ruby #{$0} collection.name json.doc kb.name"
  exit
end

dataFile = ARGV[1]
dataDoc = JSON.parse( File.read( dataFile ) )

# docID must be the same ID of the dataFile
# Must have the gsub part!
if dataDoc['DocumentID'].nil?
  $stderr.puts "Please rename the root item to \"DocumentID\""
  exit
end
docID = CGI.escape(dataDoc['DocumentID']['value']).gsub(/\+/,'%20') 

# Credentials
gbLogin, usrPass = getUP 

# Database configuration
kbName = ARGV[2]
grpName   = 'acmg-apiTest'
collName  = ARGV[0]

$stderr.puts "Config info:"
$stderr.puts "KB:#{kbName}"
$stderr.puts "Collection:#{collName}"
$stderr.puts "Group:#{grpName}"
# Url building process
http     = 'http://'
genbHost = 'genboree.org'

rsrcPath = "/REST/v1/grp/#{grpName}/kb/#{kbName}/coll/#{collName}/doc/#{docID}?"
propPath = '' 
detailed = '' 

url = buildURL(genbHost, gbLogin, usrPass, rsrcPath, propPath, detailed)

api_put_with_diag(url,dataDoc.to_json)
