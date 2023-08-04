class Post < ApplicationRecord
  belongs_to :topic
  belongs_to :author

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy ,  class_name: 'Comment'
  has_many :user_post_views
  has_many :viewed_by_users, through: :user_post_views, source: :user
  validates :title, presence: true
  validates :text, presence: true
  validates :published_at, presence: true


  def num_likes
    likes.count
  end

  def num_comments
    comments.count
  end
  def views
    user_post_views.count
  end

  def liked_by?(user)
    likes.exists?(user: user)
  end

  def like(user)
    likes.create(user: user) unless liked_by?(user)
  end

  def unlike(user)
    likes.where(user: user).destroy_all if liked_by?(user)
  end
end
