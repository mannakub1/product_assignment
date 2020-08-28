class Auth::GuardValidation < ApplicationService
  
  def validate_facebook(auth_token)
    validate_auth_token(auth_token)
  end

  def validate_google(auth_token)
    validate_auth_token(auth_token)
  end

  def validate_auth_token(auth_token)
    error_validate_failed!("ไม่มี params auth_token") if auth_token.nil?
  end

  def validate_get_user(account_id, token_type)
    error_validate_failed!("ไม่มี params account_id") if account_id.nil?
    error_validate_failed!("ไม่มี params token_type") if token_type.nil?
  end
end

