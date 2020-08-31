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

end