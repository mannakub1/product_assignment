class ApplicationService
  include ::Constants

  attr_accessor :current_user, :current_headers

  def self.init(header)
    @model = @model || self.new
    @model.set_attrs(header)

    @model
  end

  def set_attrs(headers)
    self.current_user = jwt_decoder(headers[HEADER_AUTH_TOKEN])
  end

  def jwt_encoder(user)
    error_validate_failed!("ไม่มี params user") if user.nil?
    error_validate_failed!("ไม่มี user id: #{user.id} นี้อยู่ในระบบ") if User.find_by(id: user.id).nil?

    payload = {
      data: { 
        user_id: user.id
      }
    }

    JWT.encode(payload, Settings.jwt.secret)
  end

  def jwt_decoder(token)
    error_validate_failed!("ไม่มี params token header") if token.nil?

    decoded_token = JWT.decode(token, Settings.jwt.secret, true)
    user_id       = decoded_token[0]['data']['user_id']
    user          = User.find_by(id: user_id)
    error_validate_failed!("ไม่มี user id: #{user.id} นี้อยู่ในระบบ") if user.nil?

    user
  end

  def error_validate_failed!(message)
   error!(code: CODE_VALIDATE_FAILED,  status: 422, message: message)
  end

  def error_not_found!(message)
    error!(code: CODE_NOT_FOUND,  status: 401, message: message)
  end

  def error!(params)
    raise ApiError::BaseError.new(params)
  end
end

