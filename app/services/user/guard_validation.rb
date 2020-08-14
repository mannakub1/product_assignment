class User::GuardValidation < ApplicationService
  
  def validate_get_info(user_id)
    error_validate_failed!("ไม่มี params user_id") if user_id.nil?
    error_validate_failed!("ไม่มี User นี้จาก user_id: #{user_id}") if User.find_by(id: user_id).nil?
  end
end

