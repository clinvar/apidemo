# An example usage of the clingendb API
# to get all document ids of a collection
# @Author Xin Feng 
# @Email xinf@bcm.edu
# @Date 06/15/2015
#

require 'rest'
require 'urlb'
require 'up'

if ARGV.length < 2
  $stderr.puts "Usage: ruby #{$0} collection.name kb.name"
  $stderr.puts "Example: ruby #{$0} test0.1 test"
  exit
end
# Credentials
gbLogin, usrPass = getUP 

# Query configuration 
collName  = ARGV[0].to_s

# Database configuration
kbName = ARGV[1]
grpName   = 'acmg-apiTest'

$stderr.puts "Config info:"
$stderr.puts "KB:#{kbName}"
$stderr.puts "Collection:#{collName}"
$stderr.puts "Group:#{grpName}"


# Url building process
http        = 'http://'
genbHost    = 'genboree.org'
detailed    = '&detailed=false' # Enable full JSON report

rsrcPath    = "/REST/v1/grp/#{grpName}/kb/#{kbName}/coll/#{collName}/docs?"
propPath    = ""


url = buildURL(genbHost, gbLogin, usrPass, rsrcPath, propPath, detailed)

api_get_with_diag(url)
