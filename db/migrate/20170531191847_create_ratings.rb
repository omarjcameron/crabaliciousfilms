class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.integer :stars, null: false
      t.references :user, foreign_key: true
      t.references :film, foreign_key: true

      t.timestamps null: false
    end
  end
end
