# lib/tasks/reset_posts_viewed_today.rake

namespace :posts do
    desc "Reset posts_viewed_today count for all users"
    task :reset_view_count => :environment do
      ResetPostsViewedTodayJob.perform_now
    end
  end
  