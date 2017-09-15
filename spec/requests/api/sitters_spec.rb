require 'rails_helper'

RSpec.describe 'Sitters API', type: :request do
  # initialize test data
  let!(:sitters) { create_list(:sitter, 10) }
  let!(:pet_owners) { create_list(:pet_owner, 10) }
  let(:id) { sitters.first.id }

  # Test suite for GET /api/sitters
  describe 'GET /api/sitters' do
    before { get '/api/sitters/' }

    context 'when sitter exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all sitters' do
        expect(json.size).to eq(10)
      end
    end
  end

  # Test suite for GET /api/sitters/:id
  describe 'GET /api/sitters/:id' do
    before { get "/api/sitters/#{id}" }

    context 'when sitter exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the sitter' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when sitter does not exist' do
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