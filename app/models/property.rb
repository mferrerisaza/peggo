class Property < ApplicationRecord
  enum property_type: ["Apartamento", "Casa", "Parqueadero"]
  # before_save :update_building_coeficients, if: :will_save_change_to_area?

  belongs_to :building
  has_many :shares, dependent: :destroy
  has_many :owners, through: :shares
  has_many :bills, through: :shares

  validates :building_coeficient,
            numericality: {
              greater_than: 0,
              less_than_or_equal_to: 1,
              allow_nil: true,
              message: "debe ser un valor númerico entre 0 y 100%"
            }
  validates :property_type, :name, :area, presence: true

  def full_name
    "#{property_type} #{name}"
  end

  def calc_building_coeficient
    area / building.area_sum.to_f
  end

  private

  def update_building_coeficients
    # binding.pry
    UpdateBuildingJob.perform_later(building.id)
  end
end
