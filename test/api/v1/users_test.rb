require 'test_helper'

class UsersTest < ActiveSupport::TestCase

  test "[PUT]_user_update_retirements" do
  
    user = create(:user_facebook)
    params = {
      "retirement_data": {
        "goal": { "a": 1},
        "salary": { "a": 1},
        "social_security": { "a": 1},
        "provident_fund": { "a": 1},
        "saving": { "a": 1},
        "post_retirement": { "a": 1},
      }
    }
    
    put "/api/v1/users/retirements", params, user_header(user)

    assert_equal("success", response_body[:code])
    assert_equal([:goal, 
                  :salary, 
                  :social_security, 
                  :provident_fund, 
                  :saving, 
                  :post_retirement
                ], response_body[:data][:user][:retirement_data].keys())
  end

  test "[PUT]_user_update_terms" do

    user = create(:user_facebook)
    params = { "version": 1 }

    put "/api/v1/users/terms", params, user_header(user)
    assert_equal("success", response_body[:code])
  end

  test "[PUT]_user_update_terms_withl_nil" do

    user = create(:user_facebook)
    params = { "version": nil }

    put "/api/v1/users/terms", params, user_header(user)
    
    assert_equal("validate_failed", response_body[:code])
    assert_equal("ไม่มี params version", response_body[:message])
  end
  
  test "[PUT]_user_update_terms_with_version_duplicate" do

    user    = create(:user_facebook)
    version = 1

    user.accept_term = { versions: [{ number: version, timestamp: DateTime.now }] }
    user.save!
    params = { "version": version}

    put "/api/v1/users/terms", params, user_header(user)
    
    assert_equal("validate_failed", response_body[:code])
    assert_equal("ได้ยืนยัน term & condition ใน version #{version} นี้ไปแล้ว", response_body[:message])
  end

  test "[PUT]_user_update_terms_with_version_less" do

    user    = create(:user_facebook)
    version = 2

    user.accept_term = { versions: [{ number: version, timestamp: DateTime.now }] }
    user.save!
    params = { "version": 1}

    put "/api/v1/users/terms", params, user_header(user)
    
    assert_equal("validate_failed", response_body[:code])
    assert_equal("ไม่สามารถยืนยัน term & condition ที่เก่ากว่า version #{version} ได้", response_body[:message])
  end

end