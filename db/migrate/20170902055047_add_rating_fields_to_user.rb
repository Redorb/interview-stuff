class AddRatingFieldsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :sitter_score, :decimal
    add_column :users, :rating_score, :decimal
    add_column :users, :overall_score, :decimal
  end
end
