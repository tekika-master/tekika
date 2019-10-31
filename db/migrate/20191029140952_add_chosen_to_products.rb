class AddChosenToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :chosen, :boolean, default: false, null: false
  end
end
