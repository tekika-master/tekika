class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :title
      t.string :price
      t.string :lecture
      t.string :university
      t.string :place
      t.string :writing  
      t.integer :purchase
      
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
