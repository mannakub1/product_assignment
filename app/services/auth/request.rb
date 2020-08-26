class Auth::Request < ApplicationService
  require 'net/http'
  require 'fileutils'

  def call(url_path)    
    url  = URI.parse(url_path)
    req  = Net::HTTP::Get.new(url.request_uri)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.open_timeout = 3 # in seconds
    http.read_timeout = 3 # in seconds
    http.request(req)
  end
end