class Post < ApplicationRecord
  belongs_to :topic

  self.per_page=4
  has_one_attached :file

  has_paper_trail

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
  has_many :saved_posts


  def calculate_reading_time
    words_per_minute = 100 # Assuming an average reading speed of 200 words per minute
    word_count = self.text.split.size
    total_minutes = (word_count.to_f / words_per_minute).ceil
    self.reading_time = format("%02d:%02d", total_minutes, 0)
  end


  def update_revenue_share
    # Calculate the revenue share based on the number of views
    # For example, you can use a formula to calculate the share based on views and likes
    self.revenue_share = (views * 0.01) + (num_likes * 0.05)
    save
  end
end
