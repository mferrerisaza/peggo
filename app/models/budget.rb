class Budget < ApplicationRecord
  belongs_to :building
  has_many :expenses
  monetize :amount_cents, disable_validation: true

  validates :amount, numericality: { greater_than: 0 }
  validates :start_date, :end_date, presence: true
  validate :end_date_is_after_start_date
  validate :only_one_active_budget?

  private

  def end_date_is_after_start_date
    return if end_date.blank? || start_date.blank?
    errors.add(:end_date, "debe ser menor a la fecha inicial") if end_date < start_date
  end

  def only_one_active_budget?
    active_budgets = Budget.where(building: building).where(status: true)
    budgets_size = active_budgets.size
    return true if budgets_size < 1 || (budgets_size == 1 && active_budgets.include?(self))
    errors.add(:building, "ya tiene un presupuesto activo")
  end
end
