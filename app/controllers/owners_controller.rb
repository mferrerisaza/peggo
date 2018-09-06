class OwnersController < ApplicationController
  before_action :set_building, except: :update
  before_action :set_owner, only: %i[show edit update destroy]

  def index
    @owners = policy_scope(@building.owners)
    authorize @building, :building_of_current_user?
  end

  def show
    authorize @owner
    @share = Share.new
    @render = "owners"
  end

  def new
    @owner = Owner.new
    authorize @building, :building_of_current_user?
  end

  def create
    @owner = Owner.new(owner_params)
    @owner.user = current_user
    authorize @building, :building_of_current_user?
    if @owner.save
      flash[:notice] = "Propietario creado existosamente"
      redirect_to building_owner_path(@building, @owner)
    else
      render :new
    end
  end

  def edit
    authorize @building, :building_of_current_user?
  end

  def update
    @building = Building.find(owner_params[:building_id])
    authorize @building, :building_of_current_user?
    if @owner.update(owner_params)
      flash[:notice] = "Propietario actualizado existosamente"
      redirect_to building_owner_path(@building, @owner)
    else
      render 'edit'
    end
  end

  def destroy
    authorize @owner
    @owner.destroy
    flash[:notice] = "Propietario eliminado existosamente"
    redirect_to building_owners_path(@building)
  end

  private

  def owner_params
    params.require(:owner).permit(:name, :card_number, :phone, :email, :building_id)
  end

  def set_owner
    @owner = Owner.find(params[:id])
  end
end
