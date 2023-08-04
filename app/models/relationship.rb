class Relationship < ApplicationRecord

    belongs_to :follower_user, class_name: 'User', foreign_key: 'follower_user_id'
    belongs_to :followee_user, class_name: 'User', foreign_key: 'followee_user_id'
  
    validates :follower_user_id, presence: true
    validates :followee_user_id, presence: true
end
