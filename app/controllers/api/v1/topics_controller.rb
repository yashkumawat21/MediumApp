# app/controllers/topics_controller.rb
class Api::V1::TopicsController < ApplicationController
    before_action :authenticate_user!, except: [:index]
  
    def index
      @topics = Topic.all
      render json: @topics
    end
  
    def create
      @topic = Topic.new(topic_params)
  
      if @topic.save
        render json: @topic, status: :created
      else
        render json: { error: @topic.errors.full_messages.join(', ') }, status: :unprocessable_entity
      end
    end
  
    private
  
    def topic_params
      params.require(:topic).permit(:name)
    end
  end
  