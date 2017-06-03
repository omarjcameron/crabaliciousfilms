class CreateFilms < ActiveRecord::Migration[5.1]
  def change
    create_table :films do |t|
      t.string :title, null: false
      t.references :category, foreign_key: true

      t.timestamps null: false
    end
    add_index :films, :title, unique: true
  end
end
