require 'test_helper'

class AuthTest < ActiveSupport::TestCase

  test "[GET]_auth_facebook_with_first_sign_in" do
  
    Auth::Base.any_instance.stubs(:request).returns(data_facebook)
    params = { auth_token: auth_token }
    
    get "/api/v1/auth/facebook", params

    assert_equal("success", response_body[:code])
    assert_equal([:user, :auth_token], response_body[:data].keys())
  end

  test "[GET]_auth_facebook_with_return_retirement" do

    Auth::Base.any_instance.stubs(:request).returns(data_facebook)
    user   = create(:user_facebook, 
                    account_id: account_id, 
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

  def data_facebook
    "{\"data\":{\"app_id\":\"784845042320958\",\"type\":\"USER\",\"application\":\"savvy calculator\",\"data_access_expires_at\":1606286581,\"expires_at\":1603689752,\"is_valid\":true,\"issued_at\":1598505752,\"metadata\":{\"auth_type\":\"rerequest\",\"sso\":\"chrome_custom_tab\"},\"scopes\":[\"email\",\"public_profile\"],\"user_id\":\"3386394381382928\"}}"
  end

  def account_id
    "3386394381382928"
  end

  def auth_token
    "token_test"
  end

end