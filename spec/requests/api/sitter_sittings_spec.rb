require 'rails_helper'

RSpec.describe 'Sitter Sittings API', type: :request do
  # initialize test data
  let!(:sitter) { create(:sitter) }
  let!(:pet_owner) { create(:pet_owner) }
  let!(:sittings) { create_list(:stay, 10, pet_owner_id: pet_owner.id, sitter_id: sitter.id) }
  let(:pet_owner_id) { pet_owner.id }
  let(:sitter_id) { sitter.id }
  let(:id) { sittings.first.id }

  # Test suite for GET /sitters/:owner_id/sittings
  describe 'GET /api/sitters/:sitter_id/sittings' do
    before { get "/api/sitters/#{sitter_id}/sittings" }

    context 'when sitting exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all sittings' do
        expect(json.size).to eq(10)
      end
    end

    context 'when pet owner does not exist' do
      let(:sitter_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  # Test suite for GET /api/sitters/:sitter_id/sittings/:id
  describe 'GET /api/sitters/:sitter_id/sittings/:id' do
    before { get "/api/sitters/#{sitter_id}/sittings/#{id}" }

    context 'when sitting exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the sitting' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when sitting does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Stay/)
      end
    end
  end

  # Test suite for POST /api/sitters/:sitter_id/sittings
  describe 'POST /api/sitters/:sitter_id/sittings' do
    let(:valid_attributes) do
      {
          text: 'Paul paul paul',
          rating: 5,
          start_date: Faker::Date.backward(23),
          end_date: Faker::Date.forward(23),
          pet_owner_id: pet_owner_id
      }
    end

    context 'when request attributes are valid' do
      before { post "/api/sitters/#{sitter_id}/sittings", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/api/sitters/#{sitter_id}/sittings", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Pet owner must exist/)
      end
    end
  end

  # Test suite for PUT /api/sitters/:sitter_id/sittings/:id
  describe 'PUT /api/sitters/:sitter_id/sittings/:id' do
    let(:valid_attributes) { { rating: 1 } }

    before { put "/api/sitters/#{sitter_id}/sittings/#{id}", params: valid_attributes }

    context 'when sitting exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the sitting' do
        updated_sitting = Stay.find(id)
        expect(updated_sitting.rating).to match(1)
      end
    end

    context 'when the sitting does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Stay/)
      end
    end
  end

  # Test suite for DELETE /api/sitters/:id/sittings/:id
  describe 'DELETE /api/sitters/:id/sittings/:id' do
    before { delete "/api/sitters/#{sitter_id}/sittings/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end