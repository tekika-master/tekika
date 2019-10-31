class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
      t.string :title, null: false
      t.string :content, null: false
      t.string :feeling, null: false

      t.timestamps

      t.index [:user_id, :product_id]
    end
  end
end
