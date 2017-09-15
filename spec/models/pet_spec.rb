require 'rails_helper'

# Test suite for the Item model
RSpec.describe Pet, type: :model do
  it { should belong_to(:owner) }
  it { should have_and_belong_to_many(:stays) }

  it { should validate_presence_of(:name) }
end