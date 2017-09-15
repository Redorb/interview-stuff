class Api::PetOwnerBookingsController < ApplicationController
  before_action :set_pet_owner
  before_action :set_sitter, only: [:create]
  before_action :set_booking, only: [:show, :update, :destroy]

  # GET /api/pet_owners/:owner_id/bookings
  def index
    json_response(@pet_owner.bookings)
  end

  # GET /api/pet_owners/:owner_id/bookings/:id
  def show
    json_response(@booking)
  end

  # POST /api/pet_owners/:owner_id/bookings
  def create
    @pet_owner.bookings.create!(booking_params)
    @sitter.update_all_scores if @sitter
    json_response(@pet_owner, :created)
  end

  # PUT /api/pet_owners/:owner_id/bookings/:id
  def update
    @booking.update(booking_params)
    head :no_content
  end

  # DELETE /api/pet_owners/:owner_id/bookings/:id
  def destroy
    @booking.destroy
    head :no_content
  end

  private

  def booking_params
    params.permit(:text, :start_date, :end_date, :rating, :sitter_id)
  end

  def set_pet_owner
    @pet_owner = User.find(params[:pet_owner_id])
  end

  def set_sitter
    @sitter = User.find(params[:sitter_id]) if params[:sitter_id]
  end

  def set_booking
    @booking = @pet_owner.bookings.find_by!(id: params[:id]) if @pet_owner
  end
end
