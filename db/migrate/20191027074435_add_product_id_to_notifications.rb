class AddProductIdToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :product_id, :integer
  end
end
