class CreateStays < ActiveRecord::Migration[5.1]
  def change
    create_table :stays do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.integer :rating
      t.references :sitter, references: :users
      t.references :pet_owner, references: :users
      t.string :text
    end

    add_foreign_key :stays, :users, column: :sitter_id
    add_foreign_key :stays, :users, column: :pet_owner_id
  end
end
