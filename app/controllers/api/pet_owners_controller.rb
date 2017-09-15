class Api::PetOwnersController < ApplicationController
  before_action :set_pet_owner, only: [:show]

  # GET /api/pet_owners
  def index
    json_response(User.pet_owners)
  end

  # GET /api/pet_owners/:id
  def show
    json_response(@pet_owner)
  end

  private

  def set_pet_owner
    @pet_owner = User.find_by!(id: params[:id])
  end
end
