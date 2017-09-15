# app/controllers/pets_controller.rb
class Api::PetsController < ApplicationController
  before_action :pet_owner_id
  before_action :set_pet, only: [:show, :update, :destroy]

  # GET /api/pet_owners/:pet_owner_id/pets
  def index
    json_response(@pet_owner_id.pets)
  end

  # GET /api/pet_owners/:pet_owner_id/pets/:id
  def show
    json_response(@pet)
  end

  # POST /api/pet_owners/:pet_owner_id/pets
  def create
    @pet_owner_id.pets.create!(pet_params)
    json_response(@pet_owner_id, :created)
  end

  # PUT /api/pet_owners/:pet_owner_id/pets/:id
  def update
    @pet.update(pet_params)
    head :no_content
  end

  # DELETE /api/pet_owners/:pet_owner_id/pets/:id
  def destroy
    @pet.destroy
    head :no_content
  end

  private

  def pet_params
    params.permit(:name)
  end

  def pet_owner_id
    @pet_owner_id = User.find(params[:pet_owner_id])
  end

  def set_pet
    @pet = @pet_owner_id.pets.find_by!(id: params[:id]) if @pet_owner_id
  end
end