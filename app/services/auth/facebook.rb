class Auth::Facebook < ApplicationService
  require 'net/http'

  def call(auth_token)
    # Guard
    Auth::GuardValidation.new.validate_facebook(auth_token)

    # perform
    access_token = ENV['FACEBOOK_APP_ACCESS_TOKEN']
    url          = "https://graph.facebook.com/debug_token?input_token=#{auth_token}&access_token=#{access_token}"

    # get user
    response   = Auth::Request.new.call(url)
    account_id = JSON.parse(response.body)["data"]["user_id"]  
    user       = Auth::GetUser.new.call(account_id, auth_token, "facebook")

    # return
    Auth::JwtEncode.new.call(user)
  end

end

