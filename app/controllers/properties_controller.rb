class PropertiesController < ApplicationController
  before_action :set_building
  before_action :set_property, only: %i[show edit destroy]

  def index
    @properties = policy_scope(Property.where(building: @building))
    authorize @building, :show_properties?
  end

  def show
    authorize @property
  end

  def new
    @property = Property.new
    authorize @building, :create_property?
  end

  def create
    @property = Property.new(property_params)
    authorize @building, :create_property?
    if @property.save
      redirect_to building_property_path(@building, @property)
    else
      render 'new'
    end
  end

  def edit
    authorize @property
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
