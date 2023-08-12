class AddChargeIdToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :charge_id, :string
  end
end
