module JsonFormatter
  module Success
    include Constants 
    def self.call(object, env)
      response = { code: CODE_SUCCESS }

      case object
      when Hash
        response[:data] = object
      when Array
        response[:code] = object[0]
        response[:data] = object[1]
      when String, TrueClass
        response[:data] = nil
      else
        # use present method without scope
        # e.g. present user, with: Entities::User
        response[:data] = object
      end

      response.to_json
    end
  end

  module Error
    include Constants 
    def self.call(message, backtrace, options, env, original_exception)
      response = {}

      if message.is_a?(Hash)
        # From respond_error helper method
        response[:code]    = message[:code]
        response[:message] = message[:message] unless message[:message].nil?
        response[:errors]  = message[:errors]  unless message[:errors].nil?
        response[:data]    = message[:data]    unless message[:data].nil?
      else
        # Grape api error, e.g. error!('Message only')
        ApiBase.logger.error '== Grape api error!'
        ApiBase.logger.error message
        ApiBase.logger.fatal backtrace.first(100).join("\n")

        response[:code]    = CODE_SERVER_ERROR
        response[:message] = "API error, #{message}."
      end

      ApiBase.logger.info({ response: response }.to_json)

      response.to_json
    end
  end
end
