# app/controllers/likes_controller.rb
class API::V1::LikesController < ApplicationController
    before_action :authenticate_user!
  
    def create
      @post = Post.find(params[:post_id])
  
      if current_user.likes.where(post: @post).exists?
        render json: { error: 'You have already liked this post.' }, status: :unprocessable_entity
      else
        like = current_user.likes.new(post: @post)
  
        if like.save
          render json: { message: 'Post liked successfully.' }, status: :created
        else
          render json: { error: 'Failed to like the post.' }, status: :unprocessable_entity
        end
      end
    end
  
    def destroy
      @post = Post.find(params[:post_id])
      like = current_user.likes.find_by(post: @post)
  
      if like
        like.destroy
        render json: { message: 'Like removed successfully.' }, status: :ok
      else
        render json: { error: 'Like not found.' }, status: :not_found
      end
    end
  end
  