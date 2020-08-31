class Auth::Google < Auth::Base
  
  attr_reader :guard

  def initialize(option={})
    @guard = Auth::GuardValidation.new
  end

  def call(auth_token)
    # Guard
    guard.validate_google(auth_token)

    # perform
    ## Authentication from facebook
    user_detail = auth_google(auth_token)
    
    # save user
    user = get_or_initialize_user(user_detail["sub"], "google")
    user = update_user(
      user,
      auth_token,
      user_detail["email"],
      user_detail["name"],
      user_detail["given_name"],
      user_detail["family_name"]
    )

    # return
    [user, jwt_encoder(user)]
  end

  def auth_google(auth_token)
    url           = "https://oauth2.googleapis.com/tokeninfo?id_token=#{auth_token}"
    response      = request(url)
    response_hash = JSON.parse(response)
    guard.validate_request_auth_google(response_hash)

    response_hash
  end

end

