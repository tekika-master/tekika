class RemoveLikeIdFromNotifications < ActiveRecord::Migration[5.2]
  def change
    remove_column :notifications, :like_id, :integer
  end
end
