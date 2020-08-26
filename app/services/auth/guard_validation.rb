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

  def validate_get_user(account_id, token, token_type)
    error_validate_failed!("ไม่มี params account_id") if account_id.nil?
    error_validate_failed!("ไม่มี params token") if token.nil?
    error_validate_failed!("ไม่มี params token_type") if token_type.nil?
  end

  def validate_encode(user)
    error_validate_failed!("ไม่มี params user") if user.nil?
    error_validate_failed!("ไม่มี user id: #{user.id} นี้อยู่ในระบบ") if User.find_by(id: user.id).nil?
  end

  def validate_decode(token)
    error_validate_failed!("ไม่มี params token") if token.nil?
  end
end

