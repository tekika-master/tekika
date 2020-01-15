class AddPictureIdToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :picture_id, :string
  end
end
