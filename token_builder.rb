# app to build the security token
# @Author Xin Feng 
# @Email xinf@bcm.edu
# @Date 05/08/2014
#

require 'auth'

if ARGV.length < 3
  $stderr.puts "Usage: ruby #{$0} url username password"
  exit
end

# Credentials
url, gbLogin, usrPass = [ARGV[0], ARGV[1], ARGV[2]] 

token = buildAuthToken(url, gbLogin, usrPass)

puts token

