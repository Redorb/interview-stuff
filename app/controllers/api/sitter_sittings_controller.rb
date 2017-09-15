class Api::SitterSittingsController < ApplicationController
  before_action :set_sitter
  before_action :set_sitting, only: [:show, :update, :destroy]

  # GET /api/sitters/:sitter_id/sittings
  def index
    json_response(@sitter.sittings)
  end

  # GET /api/sitters/:sitter_id/sittings/:id
  def show
    json_response(@sitting)
  end

  # POST /api/sitters/:sitter_id/sittings
  def create
    @sitter.sittings.create!(sitting_params)
    @sitter.update_all_scores
    json_response(@sitter, :created)
  end

  # PUT /api/sitters/:sitter_id/sittings/:id
  def update
    @sitting.update(sitting_params)
    head :no_content
  end

  # DELETE /api/sitters/:sitter_id/sittings/:id
  def destroy
    @sitting.destroy
    head :no_content
  end

  private

  def sitting_params
    params.permit(:text, :start_date, :end_date, :rating, :pet_owner_id)
  end

  def set_sitter
    @sitter = User.find(params[:sitter_id])
  end

  def set_sitting
    @sitting = @sitter.sittings.find_by!(id: params[:id]) if @sitter
  end
end
