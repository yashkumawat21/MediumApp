# app/controllers/auth_controller.rb
class API::V1::AuthController < ApplicationController
    def login
      user = User.find_by(email: params[:email])
  
      if user&.authenticate(params[:password])
        token = JwtHelper.encode({ user_id: user.id })
        render json: { token: token }, status: :ok
      else
        render json: { error: 'Invalid email or password' }, status: :unauthorized
      end
    end
  end
  