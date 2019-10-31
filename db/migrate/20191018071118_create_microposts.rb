class CreateMicroposts < ActiveRecord::Migration[5.2]
  def change
    create_table :microposts do |t|
      t.string :content
      t.string :easy
      t.string :info
      t.string :exam
      t.string :other
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
