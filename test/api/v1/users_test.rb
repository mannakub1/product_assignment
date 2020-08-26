require 'test_helper'

class UsersTest < ActiveSupport::TestCase

  test "[POST]_user_retirements" do
  
    user = create(:user_facebook)
    params = {
      retirement_data: {
        goal: nil,
        salary: nil,
        social_security: nil,
        provident_fund: nil,
        saving: nil,
        post_retirment: nil,
      }
    }

    # params = { }
    p params
    p params.class
    post "/api/v1/users", params, user_header(user)

    puts "=== debug ==="
    p response_body
    assert_equal(1,2)
  end

end