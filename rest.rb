require 'mechanize'

def get(url)
  ag = Mechanize.new
  genboreeAPI = url
  page = ag.get genboreeAPI
end

def put(url, entity, headers={})
  ag = Mechanize.new
  ag.put(url, entity, headers)
end
