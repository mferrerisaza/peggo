class PropertiesController < ApplicationController
  before_action :set_building, only: [:index]
  before_action :set_property, only: [:show]

  def index
    @properties = policy_scope(Property.where(building: @building))
    authorize @building, :show_properties?
  end

  def show
    authorize @property
  end

  private

  def set_building
    @building = Building.find(params[:building_id])
  end

  def set_property
    @property = Property.find(params[:id])
  end
end
