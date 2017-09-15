class Conversation < ApplicationRecord
  has_many :conversation_recipients
  has_many :users, through: :conversation_recipients
  has_many :messages
end