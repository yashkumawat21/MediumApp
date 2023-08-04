class CreateUserAuthorViews < ActiveRecord::Migration[7.0]
  def change
    create_table :user_author_views do |t|
      t.references :user, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.integer :view_count

      t.timestamps
    end
  end
end
