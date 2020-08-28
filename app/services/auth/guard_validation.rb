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

  def validate_get_or_initialize_user(account_id, token_type)
    error_validate_failed!("ไม่มี params account_id") if account_id.nil?
    error_validate_failed!("ไม่มี params token_type") if token_type.nil?
  end

  def validate_update_user(user, auth_token, email, name, first_name, last_name)
    error_validate_failed!("ไม่มี params user")       if user.nil?
    error_validate_failed!("ไม่มี params auth_token") if auth_token.nil?
    error_validate_failed!("ไม่มี params email")      if email.nil?
    error_validate_failed!("ไม่มี params name")       if name.nil?
    error_validate_failed!("ไม่มี params first_name") if first_name.nil?
    error_validate_failed!("ไม่มี params last_name")  if last_name.nil?
  end

  def validate_request_auth_facebook(response_hash)
    error_validate_failed!("request auth facebook error") if response_hash["data"]["error"].present?
  end

  def validate_request_profile_facebook(response_hash)
    error_validate_failed!("request profile facebook error") if response_hash["error"]
  end

  def validate_request_auth_google(response_hash)
    error_validate_failed!("request profile google error") if response_hash["error"]
  end
end

