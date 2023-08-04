class User < ApplicationRecord
    has_secure_password
    has_many :posts, foreign_key: 'author_id', dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :comments, dependent: :destroy ,  class_name: 'Comment'
    has_many :user_post_views
    has_many :user_topic_views
  has_many :user_author_views
    has_many :viewed_posts, through: :user_post_views, source: :post
   
    has_many :follows_as_follower, foreign_key: :follower_id, class_name: 'Follow'
  has_many :follows_as_followee, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :follows_as_followee, source: :follower
  has_many :followees, through: :follows_as_follower, source: :followee

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password_digest, presence: true


   
   
end
