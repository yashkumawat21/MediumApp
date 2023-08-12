class ResetPostsViewedTodayJob < ApplicationJob
  queue_as :default

  def perform
    User.update_all(posts_viewed_today: 0)
  end
end
