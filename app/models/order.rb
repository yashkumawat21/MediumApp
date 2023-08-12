class Order < ApplicationRecord
  belongs_to :user
  validates :charge_id, presence: true
end
