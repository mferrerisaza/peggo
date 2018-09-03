class UpdateBuildingJob < ApplicationJob
  queue_as :default

  def perform(building_id)
    building = Building.find(building_id)
    properties = building.properties

    properties.each { |property| property.update(building_coeficient: property.calc_building_coeficient) }
  end
end
