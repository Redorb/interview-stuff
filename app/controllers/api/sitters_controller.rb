class Api::SittersController < ApplicationController
  before_action :set_sitter, only: [:show]

  # GET /api/sitters
  def index
    json_response(User.sitters.order(overall_score: :desc))
  end

  # GET /api/sitters/:id
  def show
    json_response(@sitter)
  end

  private

  def set_sitter
    @sitter = User.find_by!(id: params[:id])
  end
end
