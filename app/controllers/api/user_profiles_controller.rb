class Api::UserProfilesController < ApplicationController
  before_action :set_user, only: [:show]

  # GET /api/pet_owners/:id
  def show
    render json: @user.as_json(include: [:bookings, :sittings, :pets])
  end

  private

  def set_user
    @user = User.with_details.find_by!(id: params[:id])
  end
end
