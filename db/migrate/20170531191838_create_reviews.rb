class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.references :user, foreign_key: true
      t.references :film, foreign_key: true

      t.timestamps null: false
    end

    add_index :reviews, [:user_id, :film_id], unique: true
  end
end
