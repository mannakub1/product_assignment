class Auth::Facebook < Auth::Base

  attr_reader :guard

  def initialize(option={})
    @guard = Auth::GuardValidation.new
  end

  def call(auth_token)
    # Guard
    guard.validate_facebook(auth_token)

    # perform
    ## Authentication from facebook
    account_id  = auth_facebook(auth_token)
    user_detail = get_user_detail_from_facebook(account_id, auth_token)
  
    # save user
    user = get_or_initialize_user(account_id, "facebook")
    user = update_user(
      user, 
      auth_token,
      user_detail["email"],
      user_detail["name"],
      user_detail["first_name"],
      user_detail["last_name"]
    )
  
    # return
    [user, jwt_encoder(user)]
  end

  def auth_facebook(auth_token)
    access_token  = ENV['FACEBOOK_APP_ACCESS_TOKEN']
    url           = "https://graph.facebook.com/debug_token?input_token=#{auth_token}&access_token=#{access_token}"
    response      = request(url)
    response_hash = JSON.parse(response)
    guard.validate_request_auth_facebook(response_hash)
    
    response_hash["data"]["user_id"] 
  end

  def get_user_detail_from_facebook(account_id, auth_token)
    url           = "https://graph.facebook.com/#{account_id}?fields=id,name,email,first_name,last_name&access_token=#{auth_token}"
    response      = request(url)
    response_hash = JSON.parse(response)
    guard.validate_request_profile_facebook(response_hash)

    response_hash
  end

end

