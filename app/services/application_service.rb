class ApplicationService
  include ::Constants

  # def initialize(xxx)
  #   @xxx = xxx
  # end

  # def self.call(*args, &block)
  #   new(*args, &block).call
  # end

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

