class CreateConversationRecipients < ActiveRecord::Migration[5.1]
  def change
    create_table :conversation_recipients do |t|
      t.references :user, foreign_key: true
      t.references :conversation, foreign_key: true
    end
  end
end
