class User::Retirement < ApplicationService

  def call(retirement_data)
    # Guard
    # User::GuardValidation.new.validate_get_info(user_id)

    # perform

    current_user.attributes = { retirement: retirement_data}
    current_user.save!
    current_user
  end
end