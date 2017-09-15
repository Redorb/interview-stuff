class CreateMessage < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.references :sender, foreign_key: true
      t.string :content
      t.references :conversation, foreign_key: true
      t.string :msgHash
      t.string :source
      t.timestamps
    end
  end
end
