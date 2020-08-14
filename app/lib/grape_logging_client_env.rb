class GrapeLoggingClientEnv < GrapeLogging::Loggers::Base
  def parameters(request, _)
    {
      ip:   request.env['HTTP_X_FORWARDED_FOR'] || request.env['REMOTE_ADDR'],
      ua:   request.env['HTTP_USER_AGENT']
      # user: request.env['warden'].authenticate(scope: :user)
    }
  end
end
