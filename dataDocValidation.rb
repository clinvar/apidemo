# An example usage of the clingendb API
# to validate a document against an existing collection
#
# @Author Xin Feng 
# @Email xinf@bcm.edu
# @Date 11/10/2014
#

require 'rest'
require 'urlb'
require 'up'

if ARGV.length < 2
  $stderr.puts "Usage: ruby #{$0} collection.name json.doc"
  $stderr.puts "Example: ruby #{$0} GeorgetownUniProt-0.1 UPD000001.json"
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
kbName    = 'acmg-Test'
grpName   = 'acmg-apiTest'
collName  = ARGV[0]

# Url building process
http     = 'http://'
genbHost = 'genboree.org'

rsrcPath = "/REST/v1/grp/#{grpName}/kb/#{kbName}/coll/#{collName}/doc/#{docID}?"
propPath = '' 
detailed = '' 

url = buildURL(genbHost, gbLogin, usrPass, rsrcPath, propPath, detailed)

api_put_with_diag(url,dataDoc.to_json)
