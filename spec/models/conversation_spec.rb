require 'rails_helper'

# Test suite for the Item model
RSpec.describe Conversation, type: :model do
  it { should have_many(:conversation_recipients) }
  it { should have_many(:users) }
  it { should have_many(:messages) }
end