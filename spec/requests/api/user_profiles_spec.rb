require 'rails_helper'

RSpec.describe 'Pets API', type: :request do
  # initialize test data
  let!(:sitter) { create(:sitter) }
  let(:id) { sitter.id }

  # Test suite for GET /api/pet_owners/:owner_id/pets/:id
  describe 'GET /api/user_profiles/:id' do
    before { get "/api/user_profiles/#{id}" }

    context 'when user profile exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the user profile' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when user profile does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end
end