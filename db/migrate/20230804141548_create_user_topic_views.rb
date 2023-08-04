class CreateUserTopicViews < ActiveRecord::Migration[7.0]
  def change
    create_table :user_topic_views do |t|
      t.references :user, null: false, foreign_key: true
      t.references :topic, null: false, foreign_key: true
      t.integer :view_count

      t.timestamps
    end
  end
end
