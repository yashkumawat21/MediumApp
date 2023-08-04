# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
    before_action :authenticate_user!
  
    def create
      @post = Post.find(params[:post_id])
      @comment = current_user.comments.build(comment_params)
      @comment.post = @post
  
      if @comment.save
        render json: @comment, status: :created
      else
        render json: { error: 'Failed to create the comment.' }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @comment = current_user.comments.find_by(post_id: params[:post_id], id: params[:id])
  
      if @comment
        @comment.destroy
        head :no_content
      else
        render json: { error: 'Comment not found.' }, status: :not_found
      end
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:content)
    end
  end
  