class BuildingsController < ApplicationController
  before_action :set_building, only: [:show]
  def index
    @buildings = policy_scope(Building)
  end

  def show
    authorize @building
  end

  def new
  end

  def create
  end

  private

  def set_building
    @building = Building.find(params[:id])
  end
end
