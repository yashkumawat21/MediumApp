class AddPostsViewedTodayToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :posts_viewed_today, :integer, default: 0
  end
end
