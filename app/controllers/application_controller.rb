# app/controllers/application_controller.rb
class ApplicationController < ActionController::API
   
  def authenticate_user!
    # Get the token from the request headers
    token = request.headers['Authorization']&.split(' ')&.last
  
    puts "Token: #{token}"
  
    begin
      # Decode the token using the JWT gem and retrieve the user_id
      decoded_token = JWT.decode(token, Rails.application.credentials.secret_key_base, true, algorithm: 'HS256')
      user_id = decoded_token[0]['user_id']
      puts "Decoded Token: #{decoded_token}"
  
      # Find the user with the given user_id and set it as the current_user
      @current_user = User.find(user_id)
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound => e
      puts "Error: #{e.message}"
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
  def current_user
    @current_user
  end
    
  end
  