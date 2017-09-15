class CreateConversation < ActiveRecord::Migration[5.1]
  def change
    create_table :conversations do |t|
      t.references :conversation_recipients, foreign_key: true
      t.timestamps
    end
  end
end
