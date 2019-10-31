class AddProductIdToEntries < ActiveRecord::Migration[5.2]
  def change
    add_column :entries, :product_id, :integer
  end
end
