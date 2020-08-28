class Auth::Google < ApplicationService
  require 'net/http'

  def call(auth_token)
    # Guard
    GuardValidation.new.validate_facebook(user_id)

    # perform
    url = "https://oauth2.googleapis.com/tokeninfo?id_token='#{auth_token}'"

    # get user
    response   = request(url)
    account_id = JSON.parse(response)["data"]["user_id"]  
    user       = get_user(account_id, auth_token, "google")

    # return
    [user, jwt_encoder(user)]
  end

end

