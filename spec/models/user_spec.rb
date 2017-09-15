require 'rails_helper'

# Test suite for the Item model
RSpec.describe User, type: :model do
  it { should have_many(:sittings).dependent(:destroy) }
  it { should have_many(:bookings).dependent(:destroy) }
  it { should have_many(:pets).dependent(:destroy) }

  describe 'user weighted score calculates correctly' do
    it 'calculates uses the sitter score if there are zero stays' do
      sitter = create(:sitter_for_calc)
      pet_owner = create(:pet_owner)
      sitter.update_all_scores
      expect(sitter.overall_score).to eq(2.5)
    end

    it 'calculates uses weighted score if there are 1 stay' do
      sitter = create(:sitter_for_calc)
      pet_owner = create(:pet_owner)
      sitter.sittings << create_list(:stay, 1, pet_owner_id: pet_owner.id, sitter_id: sitter.id)
      sitter.update_all_scores
      expect(sitter.overall_score).to eq(2.75)
    end

    it 'calculates uses weighted score if there are 5 stays' do
      sitter = create(:sitter_for_calc)
      pet_owner = create(:pet_owner)
      sitter.sittings << create_list(:stay, 5, pet_owner_id: pet_owner.id, sitter_id: sitter.id)
      sitter.update_all_scores
      expect(sitter.overall_score).to eq(3.75)
    end

    it 'calculates uses weighted score if there are 9 stays' do
      sitter = create(:sitter_for_calc)
      pet_owner = create(:pet_owner)
      sitter.sittings << create_list(:stay, 9, pet_owner_id: pet_owner.id, sitter_id: sitter.id)
      sitter.update_all_scores
      expect(sitter.overall_score).to eq(4.75)
    end

    it 'calculates uses rating score score if there are 10 stays' do
      sitter = create(:sitter_for_calc)
      pet_owner = create(:pet_owner)
      sitter.sittings << create_list(:stay, 10, pet_owner_id: pet_owner.id, sitter_id: sitter.id)
      sitter.update_all_scores
      expect(sitter.overall_score).to eq(5)
    end

    it 'calculates uses rating score score if there are 11 stays' do
      sitter = create(:sitter_for_calc)
      pet_owner = create(:pet_owner)
      sitter.sittings << create_list(:stay, 11, pet_owner_id: pet_owner.id, sitter_id: sitter.id)
      sitter.update_all_scores
      expect(sitter.overall_score).to eq(5)
    end
  end 
end