require 'net/http'
require 'uri'

def get(url)
  ag = Mechanize.new
  genboreeAPI = url
  page = ag.get genboreeAPI
end

def put(url, entity, headers={})
  ag = Mechanize.new
  ag.put(url, entity, headers)
end

def api_delete(url)
  uri = URI.parse(url)

  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Delete.new(uri.request_uri)

  response = http.request(request)

  return response.code, response.body
end

def api_delete_with_diag(url)
  respcode, respbody = api_delete(url)
  if respcode.to_i > 300
    $stderr.puts "Request failed at #{url}"
  else
    $stderr.puts "Request succeeded at #{url}"
  end
  $stderr.puts "Server response code:\n#{respcode}"
  $stderr.puts "Server response msg:\n#{respbody}"
end


def api_get(url)
  uri = URI.parse(url)

  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Get.new(uri.request_uri)

  response = http.request(request)

  return response.code, response.body
end

def api_get_with_diag(url)
  respcode, respbody = api_get(url)
  if respcode.to_i > 300
    $stderr.puts "Request failed at #{url}"
  else
    $stderr.puts "Request succeeded at #{url}"
  end
  $stderr.puts "Server response code:\n#{respcode}"
  $stderr.puts "Server response msg:\n#{respbody}"
end

def api_put_with_diag_quiet(url, entity, headers={})
  respcode, respbody = api_put(url, entity, headers)
  if respcode.to_i > 300
    $stderr.puts "Request failed at #{url}"
  else
    $stderr.puts "Request succeeded at #{url}"
  end
  return respcode, respbody
end

def api_put_with_diag(url, entity, headers={})
  respcode, respbody = api_put(url, entity, headers)
  if respcode.to_i > 300
    $stderr.puts "Request failed at #{url}"
  else
    $stderr.puts "Request succeeded at #{url}"
  end
  $stderr.puts "Server response code:\n#{respcode}"
  $stderr.puts "Server response msg:\n#{respbody}"
end

def api_put(url, entity, headers={}, timeout=500)
  uri = URI.parse(url)

  http = Net::HTTP.new(uri.host, uri.port)
  http.read_timeout = 1800
  request = Net::HTTP::Put.new(uri.request_uri)
  request.body = entity

  response = http.request(request)

  return response.code, response.body
end
