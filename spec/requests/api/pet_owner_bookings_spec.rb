require 'rails_helper'

RSpec.describe 'Pet Owner Bookings API', type: :request do
  # initialize test data
  let!(:sitter) { create(:sitter) }
  let!(:pet_owner) { create(:pet_owner) }
  let!(:bookings) { create_list(:stay, 10, pet_owner_id: pet_owner.id, sitter_id: sitter.id) }
  let(:pet_owner_id) { pet_owner.id }
  let(:sitter_id) { sitter.id }
  let(:id) { bookings.first.id }

  # Test suite for GET /pet_owners/:owner_id/bookings
  describe 'GET /api/pet_owners/:pet_owner_id/bookings' do
    before { get "/api/pet_owners/#{pet_owner_id}/bookings" }

    context 'when booking exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all bookings' do
        expect(json.size).to eq(10)
      end
    end

    context 'when pet owner does not exist' do
      let(:pet_owner_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  # Test suite for GET /pet_owners/:pet_owner_id/bookings/:id
  describe 'GET /api/pet_owners/:pet_owner_id/bookings/:id' do
    before { get "/api/pet_owners/#{pet_owner_id}/bookings/#{id}" }

    context 'when booking exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the booking' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when booking does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Stay/)
      end
    end
  end

  # Test suite for POST /pet_owners/:pet_owner_id/bookings
  describe 'POST /api/pet_owners/:pet_owner_id/bookings' do
    let(:valid_attributes) do
      {
        text: 'Paul paul paul',
        rating: 5,
        start_date: Faker::Date.backward(23),
        end_date: Faker::Date.forward(23),
        sitter_id: sitter_id
      }
    end

    context 'when request attributes are valid' do
      before { post "/api/pet_owners/#{pet_owner_id}/bookings", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/api/pet_owners/#{pet_owner_id}/bookings", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Sitter must exist/)
      end
    end
  end

  # Test suite for PUT /api/pet_owners/:pet_owner_id/bookings/:id
  describe 'PUT /api/pet_owners/:pet_owner_id/bookings/:id' do
    let(:valid_attributes) { { rating: 1 } }

    before { put "/api/pet_owners/#{pet_owner_id}/bookings/#{id}", params: valid_attributes }

    context 'when booking exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the booking' do
        updated_booking = Stay.find(id)
        expect(updated_booking.rating).to match(1)
      end
    end

    context 'when the booking does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Stay/)
      end
    end
  end

  # Test suite for DELETE /pet_owners/:id/bookings/:id
  describe 'DELETE /api/pet_owners/:id/bookings/:id' do
    before { delete "/api/pet_owners/#{pet_owner_id}/bookings/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end