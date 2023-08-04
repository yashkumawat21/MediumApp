# app/helpers/jwt_helper.rb
module JwtHelper
    SECRET_KEY = Rails.application.credentials.secret_key_base
    ALGORITHM = 'HS256'
  
    def self.encode(payload)
      JWT.encode(payload, SECRET_KEY, ALGORITHM)
    end
  
    def self.decode(token)
      JWT.decode(token, SECRET_KEY, true, algorithm: ALGORITHM)
    rescue JWT::DecodeError
      nil
    end
  end
  