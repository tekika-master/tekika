class AddFavoriteToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :favorite_id, :integer
  end
end
