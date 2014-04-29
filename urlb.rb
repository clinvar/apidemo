# Aux for url building
# @Author Xin Feng
# @Email xinf@bcm.edu
# @Date 04/15/2014

require 'auth'

def buildURL(genbHost,gbLogin, usrPass,rsrcPath, propPath,  detailed)
  http        = 'http://'
  uri         = http + genbHost + rsrcPath + propPath + detailed
  authToken   = buildAuthToken(uri, gbLogin, usrPass)
  return uri + authToken
end
