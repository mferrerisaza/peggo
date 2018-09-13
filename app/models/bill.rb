class Bill < ApplicationRecord
  after_create :add_property_monthly_fee
  enum status: ["Pagada", "Pendiente"]

  belongs_to :share
  has_many :concepts, dependent: :destroy

  validates :status, :period, presence: true
  validates_format_of :period, with: /(?<year>\d{4})\/(?<month>\d{1,2})/, message: "Ingesa una fecha válida"

  def add_property_monthly_fee
    concept = Concept.new(
      amount_cents: share.bill_payment,
      description: "Cuota administración #{share.owner.building.name} #{share.property.full_name}"
    )
    concepts << concept
  end

  def sum_concepts_amount
    concepts.sum(:amount_cents)
  end
end
