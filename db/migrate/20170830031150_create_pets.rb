class CreatePets < ActiveRecord::Migration[5.1]
  def change
    create_table :pets do |t|
      t.string :name
      t.references :owner, references: :users
    end

    add_foreign_key :pets, :users, column: :owner_id
    add_index :pets, [:name, :owner_id], unique: true
  end
end
