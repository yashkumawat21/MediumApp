class AddViewsCountToUserPostViews < ActiveRecord::Migration[7.0]
  def change
    add_column :user_post_views, :views_count, :integer , default:0
  end
end
