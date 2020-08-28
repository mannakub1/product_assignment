class Auth::Google < Auth::Base
  require 'net/http'

  def call(auth_token)
    # Guard
    guard = Auth::GuardValidation.new
    guard.validate_google(auth_token)

    # perform
    url = "https://oauth2.googleapis.com/tokeninfo?id_token=#{auth_token}"

    # get user
    response      = request(url)
    response_hash = JSON.parse(response)
    guard.validate_request_auth_google(response_hash)
    
    account_id    = response_hash["sub"]
    email         = response_hash["email"]
    name          = response_hash["name"]
    first_name    = response_hash["given_name"]
    last_name     = response_hash["family_name"]
    
    # save user
    user = get_or_initialize_user(account_id, "google")
    user = update_user(user, auth_token, email, name, first_name, last_name)

    # return
    [user, jwt_encoder(user)]
  end

end

