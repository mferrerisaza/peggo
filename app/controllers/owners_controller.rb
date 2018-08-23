class OwnersController < ApplicationController
  before_action :set_building, only: [:index, :new, :create]

  def index
    @owners = policy_scope(@building.owners)
  end

  def show
  end

  def new
    @owner = Owner.new
    authorize @owner
  end

  def create
    @owner = Owner.new(owner_params)
    authorize @owner
    if @owner.save
      redirect_to building_owners_path
    else
      render :new
    end
  end

  private

  def owner_params
    params.require(:owner).permit(:name, :card_number, :phone, :email)
  end

  def set_building
    @building = Building.find(params[:building_id])
  end
end
