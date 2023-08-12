class AddRevenueShareToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :revenue_share, :decimal, default: 0, precision: 10, scale: 2
  end
end
