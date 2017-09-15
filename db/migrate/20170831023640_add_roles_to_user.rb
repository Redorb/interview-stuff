class AddRolesToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :roles_mask, :integer, default: 1, null: false
  end
end
