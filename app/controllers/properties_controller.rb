class PropertiesController < ApplicationController
  before_action :set_building, except: :update
  before_action :set_property, only: %i[show edit update destroy]

  def index
    @properties = policy_scope(Property.where(building: @building))
    authorize @building, :building_of_current_user?
  end

  def show
    authorize @property
    @share = Share.new
  end

  def new
    @property = Property.new
    authorize @building, :building_of_current_user?
  end

  def create
    @property = Property.new(property_params)
    authorize @building, :building_of_current_user?
    if @property.save
      flash[:notice] = "Propiedad creada existosamente"
      redirect_to building_property_path(@building, @property)
    else
      render 'new'
    end
  end

  def edit
    authorize @property
  end

  def update
    @building = Building.find(property_params[:building_id])
    authorize @building, :building_of_current_user?
    if @property.update(property_params)
      flash[:notice] = "Propiedad editada existosamente"
      redirect_to building_properties_path(@building)
    else
      render 'edit'
    end
  end

  def destroy
    authorize @property
    @property.destroy
    flash[:notice] = "Propiedad eliminada con éxito"
    redirect_to building_properties_path(@building)
  end

  private

  def set_building
    @building = Building.find(params[:building_id])
  end

  def set_property
    @property = Property.find(params[:id])
  end

  def property_params
    params.require(:property).permit(
      :property_type,
      :name,
      :phone,
      :address,
      :matricula_inmobiliaria,
      :area,
      :building_coeficient,
      :building_id
    )
  end
end
