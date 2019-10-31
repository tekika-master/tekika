class AddProductIdToRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :product_id, :integer
  end
end
