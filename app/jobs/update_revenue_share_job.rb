class UpdateRevenueShareJob < ApplicationJob
  queue_as :default

  def perform
    # Calculate and update the revenue share for each post
    Post.all.each do |post|
      post.update_revenue_share
    end

    # Calculate and distribute the revenue to the creators
    users = User.all
    total_revenue = users.sum(&:total_revenue)
    users.each do |user|
      user_revenue = user.total_revenue
      user.update(revenue_share: (user_revenue / total_revenue))
    end
  end
end
