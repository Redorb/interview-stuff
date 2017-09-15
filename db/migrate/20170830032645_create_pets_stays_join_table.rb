class CreatePetsStaysJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_table :pets_stays, id: false do |t|
      t.integer :pet_id
      t.integer :stay_id
    end
 
    add_index :pets_stays, :pet_id
    add_index :pets_stays, :stay_id
  end
end
