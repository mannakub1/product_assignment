class Auth::GetUser < ApplicationService

  def call(account_id, token, token_type)
    Auth::GuardValidation.new.validate_get_user(account_id, token, token_type)
    
    user = User.find_or_initialize_by(account_id: account_id, token: token, token_type: token_type)
    user.save!

    user
  end
end