# app/controllers/pets_controller.rb
class Api::MessagesController < ApplicationController
  before_action :conversation_id
  before_action :set_message, only: [:show, :update, :destroy]

  # GET /api/pet_owners/:pet_owner_id/pets
  def index
    json_response(@conversation.messages)
  end

  # GET /api/pet_owners/:pet_owner_id/pets/:id
  def show
    json_response(@message)
  end

  # POST /api/pet_owners/:pet_owner_id/pets
  def create
    puts(message_params)
    @conversation.messages.create!(message_params)
    json_response(@conversation, :created)
  end

  # PUT /api/pet_owners/:pet_owner_id/pets/:id
  def update
    @message.update(message_params)
    head :no_content
  end

  # DELETE /api/pet_owners/:pet_owner_id/pets/:id
  def destroy
    @message.destroy
    head :no_content
  end

  private

  def message_params
    params.permit(:sender, :content, :msgHash, :source)
  end

  def conversation_id
    @conversation = Conversation.find(params[:conversation_id])
  end

  def set_message
    @message = @conversation.messages.find_by!(id: params[:id]) if @conversation_id
  end
end