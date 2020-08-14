class Auth::GuardValidation < ApplicationService
  
  def validate_facebook(auth_token, access_token)
    validate_auth_token(auth_token)
    error_validate_failed!("ไม่มี params access_token") if access_token.nil?
  end

  def validate_google(auth_token)
    validate_auth_token(auth_token)
  end

  def validate_auth_token(auth_token)
    error_validate_failed!("ไม่มี params auth_token") if auth_token.nil?
  end
end

