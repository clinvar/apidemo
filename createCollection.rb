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
require 'json'

if ARGV.length < 3
  $stderr.puts "Usage: ruby #{$0} collection.name model.in.json kb.name"
  $stderr.puts "Example: ruby #{$0} test0.1 example_collections/simple.model.json"
  exit
end

dataFile = ARGV[1]
dataDoc = JSON.parse( File.read( dataFile ) )


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

rsrcPath = "/REST/v1/grp/#{grpName}/kb/#{kbName}/coll/#{collName}/model?"
propPath = '' 
detailed = '' 

url = buildURL(genbHost, gbLogin, usrPass, rsrcPath, propPath, detailed)

code,resp = api_put(url,dataDoc.to_json)
if code.to_i > 300
  $stderr.puts "Request failed"
end
puts resp

