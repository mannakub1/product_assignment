class Auth::Google < ApplicationService
  require 'net/http'

  def perform(auth_token)
    # Guard
    GuardValidation.new.validate_facebook(user_id)

    # perform
    url = "https://oauth2.googleapis.com/tokeninfo?id_token='#{auth_token}'"
    Request.new.call(url)
  end

end

