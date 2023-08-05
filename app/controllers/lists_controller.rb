# app/controllers/lists_controller.rb
class ListsController < ApplicationController
    before_action :authenticate_user!
  
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

    def share
        @list = current_user.lists.find(params[:id])
        @users = User.where.not(id: current_user.id)
      end
    
      def create_share
        @list = current_user.lists.find(params[:id])
        user = User.find(params[:user_id])
    
        if @list.shared_users.include?(user)
          flash[:alert] = "List is already shared with that user."
        else
          @list.shared_users << user
          flash[:notice] = "List shared successfully with #{user.name}."
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
  