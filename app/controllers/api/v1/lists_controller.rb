# app/controllers/lists_controller.rb
class Api::V1::ListsController < ApplicationController 
    before_action :authenticate_user!
    before_action :set_list, only: [:show, :edit, :update, :destroy]
    

  
    def index
      @lists = current_user.lists
    end
  
    def show
      @posts = @list.posts
    end
  
    def new
      @list = current_user.lists.build
    end
  
    def create
      @list = current_user.lists.build(list_params)
      
      if @list.save
        redirect_to @list, notice: 'List was successfully created.'
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @list.update(list_params)
        redirect_to @list, notice: 'List was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @list.destroy
      redirect_to lists_url, notice: 'List was successfully destroyed.'
    end

    def shared_lists
        user = User.find(params[:user_id])
        render json: user.shared_lists
      end
      
    
      def create_share
        @list = current_user.lists.find(params[:list_id])
        user = User.find(params[:user_id])
    
        if @list.shared_users.include?(user)
            @error_message = "List is already shared with that user."
        else
          @list.shared_users << user
          @success_message = "List shared successfully with #{user.name}."
        end
    
        redirect_to @list
      end

      def add_post
        @list = current_user.lists.find(params[:list_id])
        @post = Post.find(params[:post_id])
    
        if @list.posts.include?(@post)
          
        else
          @list.posts << @post
          
        end
    
        redirect_to @list
      end
  
    private
  
    def set_list
      @list = current_user.lists.find(params[:id])
    end
  
    def list_params
      params.require(:list).permit(:name)
    end
  end
  