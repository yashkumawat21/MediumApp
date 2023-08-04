# app/controllers/users_controller.rb
class UsersController < ApplicationController
 
    def create
      user = User.new(user_params)

  
      if user.save
        render json: { message: 'User created successfully' }, status: :created
      else
        render json: { error: user.errors.full_messages.join(', ') }, status: :unprocessable_entity
      end
    end

  def index
     render json: User.all
  end
  def show 

    render json: User.find(params[:id])
  end

    private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  end
  