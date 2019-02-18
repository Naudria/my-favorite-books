class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :book_id
      t.integer :stars
      t.text :notes

      t.timestamps
    end
  end
end
