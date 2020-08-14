class GrapeLoggingPayload
  attr_reader :payload

  def initialize(payload)
    @payload = payload
  end

  def to_hash
    {
      method:     payload[:method],
      path:       payload[:path],
      format:     payload[:format].presence,
      status:     payload[:status],
      duration:   payload[:time][:total],
      view:       payload[:time][:view],
      db:         payload[:time][:db],
      remote_ip:  payload[:ip],
      ua:         payload[:ua],
      user_id:    user_id,
      headers:    headers,
      params:     params,
      response:   response
    }.compact
  end

  def to_json
    to_hash.to_json
  end

  private

  def user_id
    return payload[:user].id if payload[:user].present?

    token = payload[:headers]['Sdc-Auth-Token']
    return if token.blank?
    decoded_token = JWT.decode(token, Settings.jwt.secret, false) rescue nil
    return if decoded_token.nil?
    decoded_token[0]['data']['user_id']
  end

  def headers
    except_headers = %w(Version Authorization Accept-Encoding Accept-Language Cookie If-None-Match)
    payload[:headers].except(*except_headers)
  end

  def params
    filter_parameters = Rails.application.config.filter_parameters
    filter_parameters << 'tempfile'
    filter_parameters << 'head'
    ActionDispatch::Http::ParameterFilter.new(filter_parameters).filter(payload[:params])
  end

  def response
    return if payload[:response].nil?
    resp = payload[:response][0]
    resp.is_a?(Hash) ? resp : 'non-json response'
  end
end
