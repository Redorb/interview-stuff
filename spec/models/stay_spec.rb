require 'rails_helper'

# Test suite for the Item model
RSpec.describe Stay, type: :model do
  it { should belong_to(:sitter) }
  it { should belong_to(:pet_owner) }
  it { should have_and_belong_to_many(:pets) }
end