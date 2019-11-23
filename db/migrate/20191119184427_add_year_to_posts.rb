class AddYearToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :year, :string
  end
end
