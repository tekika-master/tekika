class AddFigureIdToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :figure_id, :string
  end
end
