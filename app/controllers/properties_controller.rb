class PropertiesController < ApplicationController
  before_action :set_building, only: [:index]
  def index
    @properties = policy_scope(Property.where(building: @building))
  end

  private

  def set_building
    @building = Building.find(params[:building_id])
  end
end
