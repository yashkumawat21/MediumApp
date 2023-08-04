# app/controllers/posts_controller.rb
class PostsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :search]
  
    def index
      @posts = Post.all
      @posts = filter_by_author(params[:author]) if params[:author].present?
      @posts = filter_by_date(params[:date]) if params[:date].present?
      @posts = filter_by_likes(params[:likes]) if params[:likes].present?
      @posts = filter_by_comments(params[:comments]) if params[:comments].present?
  
      render json: @posts, include: [:author, :topic], methods: [:num_likes, :num_comments, :views]
    end
    def search
      query = params[:query].strip.downcase
  
      @posts = Post.joins(:topic, :author).where(
        'lower(posts.title) LIKE :query OR lower(posts.text) LIKE :query OR lower(topics.name) LIKE :query OR lower(users.name) LIKE :query',
        query: "%#{query}%"
      ).distinct
  
      render json: @posts, include: [:author, :topic],methods: [:num_likes, :num_comments, :views]
    end
    def show
      @post = Post.find(params[:id])
      user_post_view = current_user.user_post_views.find_by(post: @post)

      if user_post_view
        # User has viewed the post before, increment the view count in UserPostView
        user_post_view.increment!(:views_count)
      else
        # User is viewing the post for the first time, create a new UserPostView record
        current_user.user_post_views.create(post: @post, views_count: 1)
      end
  
      # Increment the views_count for the post (separately from UserPostView)
      @post.increment!(:views_count)
      render json: @post, include: [:author, :topic],methods: [:num_likes, :num_comments, :views]

    end
  
    def create
      @post = current_user.posts.new(post_params)
  
      if @post.save
        render json: @post, status: :created
      else
        render json: { error: @post.errors.full_messages.join(', ') }, status: :unprocessable_entity
      end
    end
  
    def update
      @post = current_user.posts.find(params[:id])
  
      if @post.update(post_params)
        render json: @post
      else
        render json: { error: @post.errors.full_messages.join(', ') }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @post = current_user.posts.find(params[:id])
      @post.destroy
      head :no_content
    end

    

  
    private
  
    def post_params
      params.require(:post).permit(:title, :text, :featured_image, :published_at, :topic_id)
    end
  
    def filter_by_author(author)
      User.find_by(name: author)&.posts || []
    end
  
    def filter_by_date(date)
      Post.where('published_at >= ?', date.to_date.beginning_of_day)
    end
  
    def filter_by_likes(likes)
      Post.select { |post| post.likes.count >= likes.to_i }
    end
  
    def filter_by_comments(comments)
      Post.select { |post| post.comments.count >= comments.to_i }
    end
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
  