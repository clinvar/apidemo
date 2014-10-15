# Aux for url building
# @Author Xin Feng
# @Email xinf@bcm.edu
# @Date 04/15/2014

require 'auth'
require 'up'

def buildURL(genbHost,gbLogin, usrPass,rsrcPath, propPath,  detailed)
  http        = 'http://'
  uri         = http + genbHost + rsrcPath + propPath + detailed
  authToken   = buildAuthToken(uri, gbLogin, usrPass)
  return uri + authToken
end

def getUrl(path, val)
  usr,pass=getUP
  return buildURL('genboree.org',
                  usr, pass,
                  "/REST/v1/grp/acmg-apiTest/kb/acmg-Test/coll/acmg-lit/docs?",
                  "matchProps=#{path}&matchValue=#{val}",'&detailed=true')
end

