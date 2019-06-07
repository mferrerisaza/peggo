class BuildingsController < ApplicationController
  before_action :set_building, only: %w[show edit update destroy]

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

  def edit
    authorize @building
  end

  def update
    authorize @building
    if @building.update(building_params)
      redirect_to buildings_path
    else
      render 'new'
    end
  end

  def destroy
    authorize @building
    @building.destroy
    flash[:notice] = "Empresa eliminada existosamente"
    redirect_to buildings_path
  end

  private

  def building_params
    params.require(:building).permit(:name, :user_id,:address, :tax_id, :cell_phone, :logo, :logo_cache)
  end
end
