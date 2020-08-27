class Auth::Base < ApplicationService

  require 'net/http'
  require 'fileutils'


  def request(url_path)    
    url  = URI.parse(url_path)
    req  = Net::HTTP::Get.new(url.request_uri)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.open_timeout = 3 # in seconds
    http.read_timeout = 3 # in seconds
    http.request(req).body
  end

  def get_user(account_id, token, token_type)
    Auth::GuardValidation.new.validate_get_user(account_id, token, token_type)
    
    user = User.find_or_initialize_by(account_id: account_id, token_type: token_type)
    user.attributes = { token: token}
    user.save!

    user
  end
end