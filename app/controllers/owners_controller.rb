class OwnersController < ApplicationController
  before_action :set_building, only: [:index, :new, :create]

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

  def index
    @owners = policy_scope(Owner.all)
    @shares = Owner.building_owners(@building)
  end

  def show
  end

  private

  def owner_params
    params.require(:owner).permit(:name, :card_number, :phone, :email)
  end

  def set_building
    @building = Building.find(params[:building_id])
  end
end
