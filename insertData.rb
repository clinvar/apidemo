# An example usage of the clingendb API
# to insert a document
# @Author Xin Feng 
# @Email xinf@bcm.edu
# @Date 04/15/2014
#

require 'rest'
require 'urlb'
require 'up'

if ARGV.length < 1 
  $stderr.puts "Usage: ruby #{$0} json.doc"
  exit
end

dataFile = ARGV[0]
dataDoc = JSON.parse( File.read( dataFile ) )

# docID must be the same ID of the dataFile
# #must have the gsub part!
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
puts "URI:" + page.uri.to_s
