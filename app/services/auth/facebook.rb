class Auth::Fackbook < ApplicationService
  require 'net/http'

  def perform(auth_token, access_token)
    # Guard
    GuardValidation.new.validate_facebook(user_id)

    # perform
    # access_token = ENV['FACEBOOK_APP_ACCESS_TOKEN']
    url = "https://graph.facebook.com/debug_token?input_token='#{auth_token}'&access_token='#{access_token}'"
    Request.new.call(url)
  end

end

