require 'grape_logging'

class ApiBase < Grape::API
  helpers StrongParams
  include Constants
  format :json

  logger Rails.logger

  use GrapeLogging::Middleware::RequestLogger,
    instrumentation_key: 'grape_api',
    include: [
      GrapeLoggingClientEnv.new,
      GrapeLogging::Loggers::RequestHeaders.new,
      GrapeLogging::Loggers::Response.new
    ]

  formatter       :json, JsonFormatter::Success
  error_formatter :json, JsonFormatter::Error

  rescue_from ActiveRecord::RecordNotFound do |e|
    ApiBase.logger.error e
    error_not_found!
  end

  rescue_from Grape::Exceptions::MethodNotAllowed do |e|
    ApiBase.logger.error e
    error_method_not_allowed!
  end

  rescue_from Grape::Exceptions::ValidationErrors do |e|
    ApiBase.logger.error e
    errors = []
    messages = []

    e.each do |key, message|
      field = key.first.split(/\W+/).join('/')
      # one error per field
      next if errors.any? { |error| error[:field] == field }
      errors << { field: field, message: message }
      messages << I18n.t("grape.errors.attributes.#{field}", default: field) + ' ' + message.to_s
    end

    errors = errors.reject { |e| e[:field].to_s == 'base' }

    body = { code: CODE_VALIDATE_FAILED, message: messages }
    body[:errors] = errors if errors.any?

    error!(body, 422)
  end

  rescue_from ApiError::BaseError do |e|
    error!({ code: e.code, message: e.message }, e.status)
  end

  mount V1::Root => 'api/v1'
end