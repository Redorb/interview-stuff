require 'rails_helper'

RSpec.describe 'Pet Owners API', type: :request do
  # initialize test data
  let!(:pet_owners) { create_list(:pet_owner, 10) }
  let!(:sitters) { create_list(:sitter, 10) }
  let(:id) { pet_owners.first.id }

  # Test suite for GET /pet_owners
  describe 'GET /api/pet_owners' do
    before { get '/api/pet_owners/' }

    context 'when pet owner exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all pet owners' do
        expect(json.size).to eq(10)
      end
    end
  end

  # Test suite for GET /api/pet_owners/:id
  describe 'GET /api/pet_owners/:id' do
    before { get "/api/pet_owners/#{id}" }

    context 'when pet owner exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the pet owner' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when pet owner does not exist' do
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