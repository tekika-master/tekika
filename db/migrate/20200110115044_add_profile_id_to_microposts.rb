class AddProfileIdToMicroposts < ActiveRecord::Migration[5.2]
  def change
    add_column :microposts, :profile_id, :string
  end
end
