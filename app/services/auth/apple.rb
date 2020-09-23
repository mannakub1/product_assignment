class Auth::Apple < Auth::Base
  
  attr_reader :guard

  def initialize(option={})
    @guard = Auth::GuardValidation.new
  end

  def call(auth_token, first_name, last_name, email)
    # Guard
    guard.validate_apple(auth_token)

    # perform
    ## Authentication from facebook
    user_detail = auth_apple(auth_token)
    
    # save user
    user = get_or_initialize_user(user_detail["sub"], "apple")
    user = update_user(
      user,
      auth_token,
      email,
      first_name + last_name,
      first_name,
      last_name
    )

    # return
    [user, jwt_encoder(user)]
  end

  def auth_apple(auth_token)
    client_id     = Settings.apple.client_id
    redirect_url  = Settings.apple.redirect_url
    client_secret = gen_client_secret()
    grant_type    = "authorization_code"

    params = "client_id=#{client_id}&client_secret=#{client_secret}&grant_type=#{grant_type}&redirect_uri=#{redirect_url}&code=#{auth_token}"

    url           = "https://appleid.apple.com/auth/token"
    response      = post_request(url, params)
    response_hash = JSON.parse(response)
    guard.validate_request_auth_apple(response_hash)
    
    jwt_decode_id_token(response_hash["id_token"])
  end

  def gen_client_secret
    team_id   = Settings.apple.team_id
    client_id = Settings.apple.client_id
    key_id    = Settings.apple.key_id
    key_file  = Settings.apple.key_file

    ecdsa_key = OpenSSL::PKey::EC.new IO.read key_file
    header = { kid: key_id }
    claims = {
    	'iss' => team_id,
    	'iat' => Time.now.to_i,
    	'exp' => Time.now.to_i + 86400*179,
    	'aud' => 'https://appleid.apple.com',
    	'sub' => client_id,
    }

    token = JWT.encode claims, ecdsa_key, 'ES256', header

    token
  end

  def jwt_decode_id_token(id_token)
    JWT.decode(id_token, nil, false)[0]
  end

end

