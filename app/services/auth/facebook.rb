class Auth::Facebook < Auth::Base
  require 'net/http'

  def call(auth_token)
    # Guard
    Auth::GuardValidation.new.validate_facebook(auth_token)

    # perform
    ## Authentication from facebook
    access_token = ENV['FACEBOOK_APP_ACCESS_TOKEN']
    url          = "https://graph.facebook.com/debug_token?input_token=#{auth_token}&access_token=#{access_token}"

    # get user
    response   = request(url)
    account_id = JSON.parse(response)["data"]["user_id"] 

    ## Get user detail from facebook
    url           = "https://graph.facebook.com/#{account_id}?fields=id,name,email,first_name,last_name&access_token=#{auth_token}"
    response      = request(url)
    response_hash = JSON.parse(response)

    email         = response_hash["email"]
    name          = response_hash["name"]
    first_name    = response_hash["first_name"]
    last_name     = response_hash["last_name"]

    # save user
    user            = get_user(account_id, "facebook")
    user.attributes = { 
      token:      auth_token,
      email:      email,
      name:       name,
      first_name: first_name,
      last_name:  last_name
    }
    user.save!

    # return
    [user, jwt_encoder(user)]
  end

end

