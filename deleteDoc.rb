# An example usage of the clingendb API
# to DELETE a document into a collection
#
# @Author Xin Feng 
# @Email xinf@bcm.edu
# @Date 11/10/2014
#

require 'rest'
require 'urlb'
require 'up'

if ARGV.length < 3
  $stderr.puts "Usage: ruby #{$0} collection.name doc.id kb.name"
  $stderr.puts "Example: ruby #{$0} GeorgetownUniProt-0.1 UPD000001 acmg-Test"
  exit
end

docID = ARGV[1]

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

api_delete_with_diag(url)
