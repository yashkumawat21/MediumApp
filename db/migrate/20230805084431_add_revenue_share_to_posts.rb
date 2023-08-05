class AddRevenueShareToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :revenue_share, :float
  end
end
