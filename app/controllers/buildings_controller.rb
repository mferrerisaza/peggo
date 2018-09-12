class BuildingsController < ApplicationController
  before_action :set_building, only: %w[show]

  def index
    @buildings = policy_scope(Building)
  end

  def show
    authorize @building
    @owners = @building.owners.sort_by {|owner| owner.owner_debt}.reverse!
  end

  def new
    @building = Building.new
    authorize @building
  end

  def create
    @building = Building.new(building_params)
    authorize @building
    if @building.save
      redirect_to building_path(@building)
    else
      render 'new'
    end
  end

  private

  def building_params
    params.require(:building).permit(:name, :user_id)
  end
end
