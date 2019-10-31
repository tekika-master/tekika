class AddFavoritesCountToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :likes_count, :integer
  end

  def up
   _up
 rescue => e
   _down
   raise e
 end

 def down
   _down
 end

 private

 def _up
   MigrationUser.reset_column_information

   add_column :products, :likes_count, :integer, null: false, default: 0 unless column_exists? :products, :likes_count
 end

 def _down
   MigrationUser.reset_column_information

   remove_column :products, :likes_count if column_exists? :products, :likes_count
 end
end
