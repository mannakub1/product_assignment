class Auth::Facebook < Auth::Base
  require 'net/http'

  def call(auth_token)
    # Guard
    guard = Auth::GuardValidation.new
    guard.validate_facebook(auth_token)

    # perform
    ## Authentication from facebook
    access_token = ENV['FACEBOOK_APP_ACCESS_TOKEN']
    url          = "https://graph.facebook.com/debug_token?input_token=#{auth_token}&access_token=#{access_token}"

    # get user
    response      = request(url)
    response_hash = JSON.parse(response)
    guard.validate_request_auth_facebook(response_hash)
  
    account_id    = response_hash["data"]["user_id"] 

    ## Get user detail from facebook
    url           = "https://graph.facebook.com/#{account_id}?fields=id,name,email,first_name,last_name&access_token=#{auth_token}"
    response      = request(url)
    response_hash = JSON.parse(response)
    guard.validate_request_profile_facebook(response_hash)

    email         = response_hash["email"]
    name          = response_hash["name"]
    first_name    = response_hash["first_name"]
    last_name     = response_hash["last_name"]

    # save user
    user = get_or_initialize_user(account_id, "facebook")
    user = update_user(user, auth_token, email, name, first_name, last_name)
  
    # return
    [user, jwt_encoder(user)]
  end

end

