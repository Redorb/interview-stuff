require 'rails_helper'

# Test suite for the Item model
RSpec.describe Message, type: :model do
  it { should belong_to(:sender) }
  it { should belong_to(:conversation) }
end