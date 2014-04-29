# An example usage of the clingendb API 
# @Author Xin Feng 
# @Email xinf@bcm.edu
# @Date 03/19/2014
#

require 'rest'
require 'urlb'
require 'auth'
require 'up'

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

$stderr.puts "Query url:\n#{page.uri.to_s}"  

$stderr.puts page.body

ga = JSON.parse(page.body)
statusCode=ga["status"]["statusCode"]
if statusCode == "OK"
  $stderr.puts "Queried property: #{ARGV[0]}, value: #{ARGV[1]}"
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
