require 'rails_helper'

RSpec.describe 'Pet Owner Bookings API', type: :request do
  # initialize test data
  let!(:user) { create(:user) }
  let!(:conversation) { create(:conversation) }
  let!(:conversation_id) { conversation.id }
  let(:user_id) { user.id }

  # Test suite for POST /pet_owners/:pet_owner_id/bookings
  describe 'POST /api/conversations/:conversation_id/messages' do
    let(:valid_attributes) do
      {
        content: 'Paul paul paul',
        msgHash: 'blahblahblah',
        sender: user_id
      }
    end

    context 'when request attributes are valid' do
      before { post "/api/conversations/#{conversation_id}/messages", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    # context 'when an invalid request' do
    #   before { post "/api/conversations/#{conversation_id}/bookings", params: {} }

    #   it 'returns status code 422' do
    #     expect(response).to have_http_status(422)
    #   end

    #   it 'returns a failure message' do
    #     expect(response.body).to match(/Validation failed: Sitter must exist/)
    #   end
    # end
  end
end