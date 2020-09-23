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

  def post_request(url_path, params)    
    url  = URI.parse(url_path)
    https = Net::HTTP.new(url.host, url.port);
    https.use_ssl = true
    request = Net::HTTP::Post.new(url)
    request["Content-Type"] = "application/x-www-form-urlencoded"
    request.body = params

    response = https.request(request)

    response.body
  end

  def get_or_initialize_user(account_id, token_type)
    Auth::GuardValidation.new.validate_get_or_initialize_user(account_id, token_type)
    User.find_or_initialize_by(account_id: account_id, token_type: token_type)
  end

  def update_user(user, auth_token, email, name, first_name, last_name)
    Auth::GuardValidation.new.validate_update_user(user, auth_token, email, name, first_name, last_name)
    user.attributes = { 
      token:      auth_token,
      email:      email,
      name:       name,
      first_name: first_name,
      last_name:  last_name
    }
    user.save!
    user
  end

end