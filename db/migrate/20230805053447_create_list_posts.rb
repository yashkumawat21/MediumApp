class CreateListPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :list_posts do |t|
      t.references :list, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
