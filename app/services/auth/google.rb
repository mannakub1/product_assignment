class Auth::Google < Auth::Base
  require 'net/http'

  def call(auth_token)
    # Guard
    Auth::GuardValidation.new.validate_google(auth_token)

    # perform
    url = "https://oauth2.googleapis.com/tokeninfo?id_token=#{auth_token}"

    # get user
    response      = request(url)
    response_hash = JSON.parse(response)

    account_id    = response_hash["sub"]
    email         = response_hash["email"]
    name          = response_hash["name"]
    first_name    = response_hash["given_name"]
    last_name     = response_hash["family_name"]
    
    # save user
    user            = get_user(account_id, "google")
    user.attributes = { 
      token: auth_token,
      email: email,
      name: name,
      first_name: first_name,
      last_name: last_name
    }
    user.save!

    # return
    [user, jwt_encoder(user)]
  end

end

