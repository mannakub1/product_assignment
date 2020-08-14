class User::GetInfo < ApplicationService
 
  def call(user_id)
    # Guard
    User::GuardValidation.new.validate_get_info(user_id)

    # perform
    User.find_by(id: user_id)
  end
end

