# An example usage of the clingendb API
# to query a collection
#
# @Author Xin Feng 
# @Email xinf@bcm.edu
# @Date 11/14/2014
#

require 'rest'
require 'urlb'
require 'up'

if ARGV.length < 2
  $stderr.puts "Usage: ruby #{$0} collection.name property.path property.query.value"
  $stderr.puts "Example: ruby #{$0} GeorgetownUniProt-0.1 DocumentID.Protein RINT1"
  exit
end


# Credentials
gbLogin, usrPass = getUP 

# Database configuration
kbName    = 'acmg-Test'
grpName   = 'acmg-apiTest'

# Query configuration 
qryVal = ARGV[2].to_s
props  = ARGV[1].to_s
collName  = ARGV[0].to_s

# Url building process
http     = 'http://'
genbHost = 'genboree.org'

rsrcPath = "/REST/v1/grp/#{grpName}/kb/#{kbName}/coll/#{collName}/docs?"
propPath = "matchProps=#{props}&matchValue=#{qryVal}"
 detailed = '' # Use this if you only want doc IDs 
#detailed    = '&detailed=true' # Enable full JSON report
url = buildURL(genbHost, gbLogin, usrPass, rsrcPath, propPath, detailed)

api_get_with_diag(url)
