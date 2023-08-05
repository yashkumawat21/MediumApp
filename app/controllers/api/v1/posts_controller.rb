# app/controllers/posts_controller.rb

require 'will_paginate/array'

class Api::V1::PostsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :search, :topposts]
  
    def index
      @posts = Post.where(draft: false).paginate(page: params[:page])
      @posts = filter_by_author(params[:author]) if params[:author].present?
      @posts = filter_by_date(params[:date]) if params[:date].present?
      @posts = filter_by_likes(params[:likes]) if params[:likes].present?
      @posts = filter_by_comments(params[:comments]) if params[:comments].present?
      @posts = sort_by_likes(@posts) if params[:sort] == 'likes'
      @posts = sort_by_comments(@posts) if params[:sort] == 'comments'
  
      render json: @posts, include: [:author, :topic], methods: [:num_likes, :num_comments]
    end
    def search
      query = params[:query].strip.downcase

  
      @posts = Post.joins(:topic, :author).where(
        'lower(posts.title) LIKE :query OR lower(posts.text) LIKE :query OR lower(topics.name) LIKE :query OR lower(users.name) LIKE :query',
        query: "%#{query}%"
      ).distinct
  
      render json: @posts, include: [:author, :topic],methods: [:num_likes, :num_comments]
    end
    def show
      @post = Post.find(params[:id])
      @post.calculate_reading_time
      user_post_view = current_user.user_post_views.find_by(post: @post)
      user_topic_view = current_user.user_topic_views.find_by(topic: @post.topic)
      user_author_view = current_user.user_author_views.find_by(author: @post.author)

      if user_post_view
        # User has viewed the post before, increment the view count in UserPostView
        user_post_view.increment!(:views_count)
       
      else
        # User is viewing the post for the first time, create a new UserPostView record
        current_user.user_post_views.create(post: @post, views_count: 1)
       
      end
      if user_topic_view
        # User has viewed the post before, increment the view count in UserPostView
       
        user_topic_view.increment!(:view_count)
        
      else
        # User is viewing the post for the first time, create a new UserPostView record
       
        current_user.user_topic_views.create(topic: @post.topic, view_count: 1)
        
      end

    
      if user_author_view
        # User has viewed the post before, increment the view count in UserPostView
        
        user_author_view.increment!(:view_count)
      else
        # User is viewing the post for the first time, create a new UserPostView record
        
        current_user.user_author_views.create(author: @post.author, view_count: 1)
      end
  
      # Increment the views_count for the post (separately from UserPostView)
      @post.increment!(:views_count)
      render json: @post, include: [:author, :topic],methods: [:num_likes, :num_comments, :views]

    end

    def upload_file
    end
  
    def create
      @post = current_user.posts.new(post_params)
      @post.calculate_reading_time

      @post.draft = true if params[:draft] == 'true'
  
      if @post.save
        render json: @post, status: :created
      else
        render json: { error: @post.errors.full_messages.join(', ') }, status: :unprocessable_entity
      end
    end

    def getdrafts

      render json: Post.where(draft: true)
    end

  
    def update
      @post = current_user.posts.find(params[:id])
      @post.draft = true if params[:draft] == 'true'
      @post.draft = false if params[:draft] == 'false'
  
      if @post.update(post_params)
        render json: @post, include: [:author, :topic],methods: [:num_likes, :num_comments, :views]
      else
        render json: { error: @post.errors.full_messages.join(', ') }, status: :unprocessable_entity
      end
    end

    def save_post_for_later
      post = Post.find(params[:id])
      current_user.saved_posts.create(post: post)
      render json: { message: "Post saved for later" }
    end

    def get_saved_posts
      saved_posts = current_user.saved_posts
      render json: saved_posts, include: :post
    end
  
    def destroy
      @post = current_user.posts.find(params[:id])
      @post.destroy
      head :no_content
    end

    def topposts
      @posts = Post.all
      @posts.each do |post|
        post.score = 0.6 * post.num_likes + 0.4 * post.views+ 0.000001 * (post.created_at - Time.now).to_i
        
      end
  
      # Sort posts in descending order of their scores
      @posts = @posts.sort_by { |post| post.score }.reverse
      render json: @posts, include: [:author, :topic] , methods: [:num_likes, :num_comments]
    end

    def recommendbytopic
      postsviewed = current_user.user_topic_views

    
      # Calculate scores for each post
      posts = Post.all
    
      # Get topics with posts authored by the current_user
      
      posts.each do |post|
        topic = post.topic
        num_likes = post.num_likes
        num_views = post.views
        num_posts_in_topic = postsviewed.find_by(topic_id: topic).view_count
        post.score = 0.3 * num_likes + 0.2 * num_views + 0.000001 * (post.created_at - Time.now).to_i+ 0.5*num_posts_in_topic
      end
    
      # Sort filtered posts in descending order of their scores
      sorted_posts = posts.sort_by { |post| post.score }.reverse
    
      # Get top 10 recommended posts
      recommended_posts = sorted_posts.take(10)
    
      render json: recommended_posts, include: [:author, :topic], methods: [:num_likes, :num_comments]
    end

    def recommendbyauthor
      postsviewed = current_user.user_author_views

    
      # Calculate scores for each post
      posts = Post.all
    
      # Get topics with posts authored by the current_user
      
      posts.each do |post|
        topic = post.author
        num_likes = post.num_likes
        num_views = post.views
        num_posts_in_topic = postsviewed.find_by(author_id: topic).view_count
        post.score = 0.3 * num_likes + 0.2 * num_views + 0.000001 * (post.created_at - Time.now).to_i+ 0.5*num_posts_in_topic
      end
    
      # Sort filtered posts in descending order of their scores
      sorted_posts = posts.sort_by { |post| post.score }.reverse
    
      # Get top 10 recommended posts
      recommended_posts = sorted_posts.take(10)
    
      render json: recommended_posts, include: [:author, :topic], methods: [:num_likes, :num_comments]
    end
    
    

    

  
    private

    def sort_by_likes(posts)
      posts.sort_by { |post| -post.likes.count }
    end
  
    def sort_by_comments(posts)
      posts.sort_by { |post| -post.comments.count }
    end
  
    def post_params
      params.require(:post).permit(:title, :text, :featured_image, :published_at, :topic_id, :draft)
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
  