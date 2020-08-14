module ApiError
  class BaseError < StandardError
    attr_reader :code, :message, :status
  
    def initialize(option = {})
      @code    = option[:code]
      @status  = option[:status] || 400
      @message = option[:message] 
    end
  end
end