require 'digest/sha1'

def buildAuthToken(rsrcURI, gbLogin, userPassword, gbTime = Time.now.to_i)
  gbToken = getgbToken rsrcURI, gbLogin, userPassword, gbTime
  return "&gbLogin=#{gbLogin}&gbTime=#{gbTime}&gbToken=#{gbToken}".strip
end

def getgbToken(rsrcURI, gbLogin, userPassword, gbTime = Time.now.to_i)
  credential = Digest::SHA1.hexdigest gbLogin + userPassword
  Digest::SHA1.hexdigest rsrcURI + credential + gbTime.to_s 
end

