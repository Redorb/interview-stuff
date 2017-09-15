class AddProfileFieldsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :avatar_url, :string
    add_column :users, :phone_number, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
  end
end
