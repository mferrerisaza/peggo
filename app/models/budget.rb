class Budget < ApplicationRecord
  before_save :transpose_dates
  belongs_to :building
  has_many :expenses, dependent: :destroy
  monetize :amount_cents, disable_validation: true

  validates :amount, numericality: { greater_than: 0 }
  validates :start_date, :end_date, :amount, presence: true
  validate :end_date_is_after_start_date
  validate :only_one_active_budget?

  def months
    (end_date.year * 12 + end_date.month) - (start_date.year * 12 + start_date.month) + 1
  end

  def monthly_budget
    amount / months
  end

  private

  def transpose_dates
    return if start_date.blank? || end_date.blank?
    self.start_date = start_date.beginning_of_month
    self.end_date = end_date.end_of_month
  end

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
