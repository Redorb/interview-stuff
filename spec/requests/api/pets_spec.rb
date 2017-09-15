require 'rails_helper'

RSpec.describe 'Pets API', type: :request do
  # initialize test data
  let!(:pet_owner) { create(:pet_owner) }
  let!(:pets) { create_list(:pet, 10, owner_id: pet_owner.id) }
  let(:owner_id) { pet_owner.id }
  let(:id) { pets.first.id }

  # Test suite for GET /api/pet_owners/:owner_id/pets
  describe 'GET /api/pet_owners/:owner_id/pets' do
    before { get "/api/pet_owners/#{owner_id}/pets" }

    context 'when pet exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all pet owner pets' do
        expect(json.size).to eq(10)
      end
    end

    context 'when pet does not exist' do
      let(:owner_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  # Test suite for GET /api/pet_owners/:owner_id/pets/:id
  describe 'GET /api/pet_owners/:owner_id/pets/:id' do
    before { get "/api/pet_owners/#{owner_id}/pets/#{id}" }

    context 'when pet exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the pet' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when pet does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Pet/)
      end
    end
  end

  # Test suite for PUT /api/pet_owners/:owner_id/pets
  describe 'POST /api/pet_owners/:owner_id/pets' do
    let(:valid_attributes) { { name: 'Paul' } }

    context 'when request attributes are valid' do
      before { post "/api/pet_owners/#{owner_id}/pets", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/api/pet_owners/#{owner_id}/pets", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /api/pet_owners/:owner_id/pets/:id
  describe 'PUT /api/pet_owners/:owner_id/pets/:id' do
    let(:valid_attributes) { { name: 'Mozart' } }

    before { put "/api/pet_owners/#{owner_id}/pets/#{id}", params: valid_attributes }

    context 'when pet exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the pet' do
        updated_pet = Pet.find(id)
        expect(updated_pet.name).to match(/Mozart/)
      end
    end

    context 'when the pet does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Pet/)
      end
    end
  end

  # Test suite for DELETE /api/pet_owners/:id/pets/:id
  describe 'DELETE /api/pet_owners/:id/pets/:id' do
    before { delete "/api/pet_owners/#{owner_id}/pets/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end