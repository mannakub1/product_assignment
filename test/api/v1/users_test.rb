require 'test_helper'

class UsersTest < ActiveSupport::TestCase

  test "[POST]_user_retirements" do
  
    user = create(:user_facebook)
    params = {
      retirement_data: {
        goal: { a: 1},
        salary: { a: 1},
        social_security: { a: 1},
        provident_fund: { a: 1},
        saving: { a: 1},
        post_retirment: { a: 1},
      }
    }
    
    post "/api/v1/users", params, user_header(user)

    puts "=== debug ==="
    p response_body
    assert_equal(1,2)
  end

end