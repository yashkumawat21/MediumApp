class User < ApplicationRecord
    has_secure_password
    has_many :posts, foreign_key: 'author_id', dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :comments, dependent: :destroy ,  class_name: 'Comment'
    has_many :user_post_views
    has_many :user_topic_views
  has_many :user_author_views
    has_many :viewed_posts, through: :user_post_views, source: :post
    has_many :saved_posts
   
    has_many :follower_relationships, class_name: 'Relationship', foreign_key: 'followee_user_id'
  has_many :followers, through: :follower_relationships, source: :follower_user

  has_many :followee_relationships, class_name: 'Relationship', foreign_key: 'follower_user_id'
  has_many :followees, through: :followee_relationships, source: :followee_user

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password_digest, presence: true


    def followed_authors
      followees = followings_as_follower.map(&:followee_id)
      User.where(id: followees)
    end
   
end
