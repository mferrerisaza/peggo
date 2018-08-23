class PropertiesController < ApplicationController
  before_action :set_building, only: %i[index show new create]
  before_action :set_property, only: [:show]

  def index
    @properties = policy_scope(Property.where(building: @building))
    authorize @building, :show_properties?
  end

  def show
    authorize @property
  end

  def new
    @property = Property.new
    authorize @property
  end

  def create
    raise
    @property = Property.new(property_params)
    authorize @property
    if @property.save
      redirect_to building_property_path(@building, @property)
    else
      render 'new'
    end
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
