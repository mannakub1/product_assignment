class Auth::JwtEncode < ApplicationService

  def call(user)
    Auth::GuardValidation.new.validate_encode(user)

    payload = {
      data: { 
        user_id: user.id
      }
    }

    JWT.encode(payload, Settings.jwt.secret)
  end
end