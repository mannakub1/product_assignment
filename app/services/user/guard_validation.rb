class User::GuardValidation < ApplicationService
  
  def validate_get_info(user_id)
    error_validate_failed!("ไม่มี params user_id") if user_id.nil?
    error_validate_failed!("ไม่มี User นี้จาก user_id: #{user_id}") if User.find_by(id: user_id).nil?
  end

  def validate_accept_term(accept_term, version)
    error_validate_failed!("ไม่มี params version") if version.nil?
    error_validate_failed!("ข้อมูล version ไม่ใช่ Integer") if version.class != Integer
    
    return nil if accept_term.nil?
    error_validate_failed!("ได้ยืนยัน term & condition ใน version #{version} นี้ไปแล้ว") if is_already_version(accept_term, version)
    error_validate_failed!("ไม่สามารถยืนยัน term & condition ที่เก่ากว่า version #{accept_term['versions'].last['number']} ได้") if is_less_version(accept_term, version)
  end

  def is_less_version(accept_term, version)
    version = accept_term["versions"].select { |x| version < x["number"] }
    version.present?
  end

  def is_already_version(accept_term, version)
   version = accept_term["versions"].select { |x| x["number"] != version }
   version.empty?
  end
 
end

