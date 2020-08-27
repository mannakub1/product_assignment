class User::Retirement < ApplicationService

  def call(params)
    # Guard
    # User::GuardValidation.new.validate_get_info(user_id)

    # perform

    current_user.attributes = { retirement: params}
    current_user.save!
    current_user
  end
end