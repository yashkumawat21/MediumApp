# app/controllers/users_controller.rb
class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:create , :show]
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
  

  #this will show the followed authors by user
  def show
    @user = User.find(params[:id])
    # Load the posts of the user's followed authors
    render json: @user.followers
  end

  # POST /users/:id/follow
  def follow
    @user = User.find(params[:id])
    current_user.followers << @user
    render json: { message: "Successfully followed user with ID #{params[:id]}" }
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.followers.delete(@user)
    render json: { message: "Successfully unfollowed user with ID #{params[:id]}" }
  end

  # change subscription from free to 3,5,10 posts perday

  def change_subscription
    @user = current_user # Implement your user authentication logic
    @subscription = Subscription.find(params[:subscription_id])

    if @user.update(subscription: @subscription)
      render json: "Subscription changed successfully."
    else
      render json: "Failed to change subscription."
    end

    
  end
    private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
    end
  end
  