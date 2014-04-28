# An example usage of the clingendb API
# to insert a document
# @Author Xin Feng 
# @Email xinf@bcm.edu
# @Date 04/15/2014
#

require 'rest'
require 'urlb'

dataFile = ARGV[0]
dataDoc = JSON.parse( File.read( dataFile ) )
#docID must be the same ID of the dataFile
docID = CGI.escape(dataDoc['documentID']['value']).gsub(/\+/,'%20') #must have the gsub part!
#
# Credentials
gbLogin   = 'xin'
usrPass   = '123456'

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
