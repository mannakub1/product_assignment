class Auth::JwtDecode < ApplicationService

  def call(token, data_key = nil)
    Auth::GuardValidation.new.validate_decode(token)

    decoded_token = JWT.decode(token, Settings.jwt.secret, true)
    data_key.nil? ? decoded_token : decoded_token[0]['data'][data_key]
  end
  
end