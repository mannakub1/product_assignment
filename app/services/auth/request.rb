class Auth::Request < ApplicationService

  def call(url)
    req  = Net::HTTP::Get.new(url.request_uri)
    http = Net::HTTP.new(url.host, url.get)
    http.open_timeout = 3 # in seconds
    http.read_timeout = 3 # in seconds
    res  = http.request(req)
  end
end