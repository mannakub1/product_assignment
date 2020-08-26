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
    http.request(req)
  end

  def get_user(account_id, token, token_type)
    Auth::GuardValidation.new.validate_get_user(account_id, token, token_type)
    
    user = User.find_or_initialize_by(account_id: account_id, token: token, token_type: token_type)
    user.save!

    user
  end

  def jwt_encoder(user)
    Auth::GuardValidation.new.validate_encode(user)

    payload = {
      data: { 
        user_id: user.id
      }
    }

    JWT.encode(payload, Settings.jwt.secret)
  end

  def jwt_decoder(token, data_key = nil)
    Auth::GuardValidation.new.validate_decode(token)

    decoded_token = JWT.decode(token, Settings.jwt.secret, true)
    data_key.nil? ? decoded_token : decoded_token[0]['data'][data_key]
  end
end