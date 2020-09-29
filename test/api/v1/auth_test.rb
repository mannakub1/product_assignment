require 'test_helper'

class AuthTest < ActiveSupport::TestCase

  test "[GET]_auth_facebook_with_first_sign_in" do
  
    Auth::Base.any_instance.stubs(:request).returns(request_auth_facebook, request_profile_facebook)
    params = { auth_token: auth_token }
    
    get "/api/v1/auth/facebook", params

    assert_equal("success", response_body[:code])
    assert_equal([:user, :auth_token], response_body[:data].keys())
  end

  test "[GET]_auth_facebook_with_return_retirement" do

    Auth::Base.any_instance.stubs(:request).returns(request_auth_facebook, request_profile_facebook)
    user   = create(:user_facebook, 
                    account_id: facebook_account_id, 
                    token: auth_token,
                    retirement: {
                      goal: { a: 1},
                      salary: { a: 1},
                      social_security: { a: 1},
                      provident_fund: { a: 1},
                      saving: { a: 1},
                      post_retirement: { a: 1},
                    })
    params = { auth_token: auth_token }
    assert_equal(1, User.count)
    
    get "/api/v1/auth/facebook", params

    assert_equal(1, User.count)
    assert_equal("success", response_body[:code])
    assert_equal([:user, :auth_token], response_body[:data].keys())
    assert_equal([:goal, 
                  :salary, 
                  :social_security, 
                  :provident_fund, 
                  :saving, 
                  :post_retirement
                ], response_body[:data][:user][:retirement_data].keys())
  end

  test "[GET]_auth_facebook_error_auth" do
  
    Auth::Base.any_instance.stubs(:request).returns(request_auth_facebook_error)
    params = { auth_token: auth_token }
    
    get "/api/v1/auth/facebook", params

    assert_equal("validate_failed", response_body[:code])
    assert_equal("request auth facebook error", response_body[:message])
  end

  test "[GET]_auth_facebook_error_email_nil" do
  
    Auth::Base.any_instance.stubs(:request).returns(request_auth_facebook, request_profile_facebook_nil_email)
    params = { auth_token: auth_token }
    
    get "/api/v1/auth/facebook", params

    assert_equal("validate_failed", response_body[:code])
    assert_equal("ไม่มี params email", response_body[:message])
  end

  test "[GET]_auth_facebook_error_email_syntax" do
  
    Auth::Base.any_instance.stubs(:request).returns(request_auth_facebook, request_profile_facebook_email_syntax_error)
    params = { auth_token: auth_token }
    
    get "/api/v1/auth/facebook", params

    assert_equal("validate_failed", response_body[:code])
    assert_equal("syntax email error", response_body[:message])
  end

  test "[GET]_auth_facebook_error_profile" do
  
    Auth::Base.any_instance.stubs(:request).returns(request_auth_facebook, request_profile_facebook_error)
    params = { auth_token: auth_token }
    
    get "/api/v1/auth/facebook", params

    assert_equal("validate_failed", response_body[:code])
    assert_equal("request profile facebook error", response_body[:message])
  end

  test "[GET]_auth_google_with_first_sign_in" do
  
    Auth::Base.any_instance.stubs(:request).returns(request_auth_google)
    params = { auth_token: auth_token }
    
    get "/api/v1/auth/google", params

    assert_equal("success", response_body[:code])
    assert_equal([:user, :auth_token], response_body[:data].keys())
  end

  test "[GET]_auth_google_with_return_retirement" do

    Auth::Base.any_instance.stubs(:request).returns(request_auth_google)
    user   = create(:user_google, 
                    account_id: google_account_id, 
                    token: auth_token,
                    retirement: {
                      goal: { a: 1},
                      salary: { a: 1},
                      social_security: { a: 1},
                      provident_fund: { a: 1},
                      saving: { a: 1},
                      post_retirement: { a: 1},
                    })
    params = { auth_token: auth_token }
    assert_equal(1, User.count)
    
    get "/api/v1/auth/google", params

    assert_equal(1, User.count)
    assert_equal("success", response_body[:code])
    assert_equal([:user, :auth_token], response_body[:data].keys())
    assert_equal([:goal, 
                  :salary, 
                  :social_security, 
                  :provident_fund, 
                  :saving, 
                  :post_retirement
                ], response_body[:data][:user][:retirement_data].keys())
  end

  test "[GET]_auth_google_error_auth" do
  
    Auth::Base.any_instance.stubs(:request).returns(request_auth_google_error)
    params = { auth_token: auth_token }
    
    get "/api/v1/auth/google", params

    assert_equal("validate_failed", response_body[:code])
    assert_equal("request auth google error", response_body[:message])
  end

  test "[GET]_auth_google_error_nil_email" do
  
    Auth::Base.any_instance.stubs(:request).returns(request_auth_google_nil_email)
    params = { auth_token: auth_token }
    
    get "/api/v1/auth/google", params

    assert_equal("validate_failed", response_body[:code])
    assert_equal("ไม่มี params email", response_body[:message])
  end

  test "[GET]_auth_google_error_syntax_email" do
  
    Auth::Base.any_instance.stubs(:request).returns(request_auth_google_syntax_email_error)
    params = { auth_token: auth_token }
    
    get "/api/v1/auth/google", params

    assert_equal("validate_failed", response_body[:code])
    assert_equal("syntax email error", response_body[:message])
  end

  test "[GET]_auth_apple_error_grant" do
  
    Auth::Base.any_instance.stubs(:post_request).returns(request_auth_apple_error_grant)
    params = { 
      auth_token: auth_token,
      first_name: "nanthipath",
      last_name:  "pholberdee",
      email:      "omliler_man@hotmail.com"
    }
    
    get "/api/v1/auth/apple", params

    assert_equal("validate_failed", response_body[:code])
    assert_equal("request auth apple error by invalid_grant", response_body[:message])
  end

  def request_auth_facebook
    "{\"data\":{\"app_id\":\"784845042320958\",\"type\":\"USER\",\"application\":\"savvy calculator\",\"data_access_expires_at\":1606286581,\"expires_at\":1603689752,\"is_valid\":true,\"issued_at\":1598505752,\"metadata\":{\"auth_type\":\"rerequest\",\"sso\":\"chrome_custom_tab\"},\"scopes\":[\"email\",\"public_profile\"],\"user_id\":\"3386394381382928\"}}"
  end

  def request_auth_facebook_error
    "{\"data\":{\"error\":{\"code\":190,\"message\":\"Invalid OAuth access token.\"},\"is_valid\":false,\"scopes\":[]}}"
  end

  def request_profile_facebook_nil_email
    "{\"id\":\"3386394381382928\",\"name\":\"Nasatit Teeka\",\"first_name\":\"Nasatit\",\"last_name\":\"Teeka\"}"
  end

  def request_profile_facebook_email_syntax_error
    "{\"id\":\"3386394381382928\",\"name\":\"Nasatit Teeka\",\"email\":\"i.am.em\",\"first_name\":\"Nasatit\",\"last_name\":\"Teeka\"}"
  end

  def request_profile_facebook
    "{\"id\":\"3386394381382928\",\"name\":\"Nasatit Teeka\",\"email\":\"i.am.em\\u0040hotmail.co.th\",\"first_name\":\"Nasatit\",\"last_name\":\"Teeka\"}"
  end

  def request_profile_facebook_error
    "{\"error\":{\"message\":\"Malformed access token EAALJzZCnzhj4BAGLBPrEJV2SruV5ZBau36HpZBTJ1KzPXcaZCxdzl0NHMKCz4K8xTzTdMvpagpihK8rWpnZApFDuL9ZBJLDLMnV6ZAx2ShPlZARXb90C0vBtDVpI7IQdgfZBQyAZAMdNp8FbTHjujrsskVUNZBfwnZCo65ezRYfL5oIFbQZCDwyE8u26IosKafOkut8Yi6KT0ppnzWaUJwmxQ7AWIhAJeBEyiebGo7d171ZBawKQZDZDaa\",\"type\":\"OAuthException\",\"code\":190,\"fbtrace_id\":\"ABzhPX5xeWMaTz18LNCHEj2\"}}"
  end

  def request_auth_google
    "{\n  \"iss\": \"https://accounts.google.com\",\n  \"azp\": \"52353301948-9sjv97415kcocefjhc8e2hi0ern8b7ap.apps.googleusercontent.com\",\n  \"aud\": \"52353301948-9sjv97415kcocefjhc8e2hi0ern8b7ap.apps.googleusercontent.com\",\n  \"sub\": \"115363107190727590527\",\n  \"email\": \"titsanatk@gmail.com\",\n  \"email_verified\": \"true\",\n  \"at_hash\": \"M5et_UDMszufH9_4S5UblA\",\n  \"nonce\": \"Dq5N858UMTxcrHBgwCN2Lkc8WnrAXRpoJTyr5hKo0Ok\",\n  \"name\": \"\xE0\xB8\x98\xE0\xB8\xB4\xE0\xB8\xA9\xE0\xB8\x93\xE0\xB8\xB0 \xE0\xB8\x97\xE0\xB8\xB5\xE0\xB8\x86\xE0\xB8\xB0\xE0\xB8\x9A\xE0\xB8\xB8\xE0\xB8\x95\xE0\xB8\xA3\",\n  \"picture\": \"https://lh3.googleusercontent.com/a-/AOh14GghscwW3eNV3Og8AqyCBWyUU7EmnpwrdFgm9VEN=s96-c\",\n  \"given_name\": \"\xE0\xB8\x98\xE0\xB8\xB4\xE0\xB8\xA9\xE0\xB8\x93\xE0\xB8\xB0\",\n  \"family_name\": \"\xE0\xB8\x97\xE0\xB8\xB5\xE0\xB8\x86\xE0\xB8\xB0\xE0\xB8\x9A\xE0\xB8\xB8\xE0\xB8\x95\xE0\xB8\xA3\",\n  \"locale\": \"th\",\n  \"iat\": \"1598608363\",\n  \"exp\": \"1598611963\",\n  \"alg\": \"RS256\",\n  \"kid\": \"0a7dc12664590c957ffaebf7b6718297b864ba91\",\n  \"typ\": \"JWT\"\n}\n"
  end

  def request_auth_google_nil_email
    "{\n  \"iss\": \"https://accounts.google.com\",\n  \"azp\": \"52353301948-9sjv97415kcocefjhc8e2hi0ern8b7ap.apps.googleusercontent.com\",\n  \"aud\": \"52353301948-9sjv97415kcocefjhc8e2hi0ern8b7ap.apps.googleusercontent.com\",\n  \"sub\": \"115363107190727590527\",\n  \"email_verified\": \"true\",\n  \"at_hash\": \"M5et_UDMszufH9_4S5UblA\",\n  \"nonce\": \"Dq5N858UMTxcrHBgwCN2Lkc8WnrAXRpoJTyr5hKo0Ok\",\n  \"name\": \"\xE0\xB8\x98\xE0\xB8\xB4\xE0\xB8\xA9\xE0\xB8\x93\xE0\xB8\xB0 \xE0\xB8\x97\xE0\xB8\xB5\xE0\xB8\x86\xE0\xB8\xB0\xE0\xB8\x9A\xE0\xB8\xB8\xE0\xB8\x95\xE0\xB8\xA3\",\n  \"picture\": \"https://lh3.googleusercontent.com/a-/AOh14GghscwW3eNV3Og8AqyCBWyUU7EmnpwrdFgm9VEN=s96-c\",\n  \"given_name\": \"\xE0\xB8\x98\xE0\xB8\xB4\xE0\xB8\xA9\xE0\xB8\x93\xE0\xB8\xB0\",\n  \"family_name\": \"\xE0\xB8\x97\xE0\xB8\xB5\xE0\xB8\x86\xE0\xB8\xB0\xE0\xB8\x9A\xE0\xB8\xB8\xE0\xB8\x95\xE0\xB8\xA3\",\n  \"locale\": \"th\",\n  \"iat\": \"1598608363\",\n  \"exp\": \"1598611963\",\n  \"alg\": \"RS256\",\n  \"kid\": \"0a7dc12664590c957ffaebf7b6718297b864ba91\",\n  \"typ\": \"JWT\"\n}\n"
  end

  def request_auth_google_syntax_email_error
    "{\n  \"iss\": \"https://accounts.google.com\",\n  \"azp\": \"52353301948-9sjv97415kcocefjhc8e2hi0ern8b7ap.apps.googleusercontent.com\",\n  \"aud\": \"52353301948-9sjv97415kcocefjhc8e2hi0ern8b7ap.apps.googleusercontent.com\",\n  \"sub\": \"115363107190727590527\",\n  \"email\": \"titsanatk\",\n  \"email_verified\": \"true\",\n  \"at_hash\": \"M5et_UDMszufH9_4S5UblA\",\n  \"nonce\": \"Dq5N858UMTxcrHBgwCN2Lkc8WnrAXRpoJTyr5hKo0Ok\",\n  \"name\": \"\xE0\xB8\x98\xE0\xB8\xB4\xE0\xB8\xA9\xE0\xB8\x93\xE0\xB8\xB0 \xE0\xB8\x97\xE0\xB8\xB5\xE0\xB8\x86\xE0\xB8\xB0\xE0\xB8\x9A\xE0\xB8\xB8\xE0\xB8\x95\xE0\xB8\xA3\",\n  \"picture\": \"https://lh3.googleusercontent.com/a-/AOh14GghscwW3eNV3Og8AqyCBWyUU7EmnpwrdFgm9VEN=s96-c\",\n  \"given_name\": \"\xE0\xB8\x98\xE0\xB8\xB4\xE0\xB8\xA9\xE0\xB8\x93\xE0\xB8\xB0\",\n  \"family_name\": \"\xE0\xB8\x97\xE0\xB8\xB5\xE0\xB8\x86\xE0\xB8\xB0\xE0\xB8\x9A\xE0\xB8\xB8\xE0\xB8\x95\xE0\xB8\xA3\",\n  \"locale\": \"th\",\n  \"iat\": \"1598608363\",\n  \"exp\": \"1598611963\",\n  \"alg\": \"RS256\",\n  \"kid\": \"0a7dc12664590c957ffaebf7b6718297b864ba91\",\n  \"typ\": \"JWT\"\n}\n"
  end

  def request_auth_google_error
    "{\n  \"error\": \"invalid_token\",\n  \"error_description\": \"Invalid Value\"\n}\n"
  end

  def request_auth_apple_error_grant
    "{ \"error\": \"invalid_grant\" }"
  end

  def facebook_account_id
    "3386394381382928"
  end

  def google_account_id
    "115363107190727590527"
  end

  def auth_token
    "token_test"
  end

end