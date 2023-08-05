class List < ApplicationRecord
  belongs_to :user

  has_many :list_posts, dependent: :destroy
  has_many :posts, through: :list_posts
  has_many :list_sharings
  has_many :shared_users, through: :list_sharings, source: :user
end
