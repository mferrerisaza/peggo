class Budget < ApplicationRecord
  belongs_to :building
  has_many :expenses
  monetize :amount_cents, disable_validation: true

  validates :amount, numericality: { greater_than: 0 }
  validates :start_date, :end_date, presence: true
  validate :end_date_is_after_start_date

  private

  def end_date_is_after_start_date
    return if end_date.blank? || start_date.blank?
    errors.add(:end_date, "debe ser menor a la fecha inicial") if end_date < start_date
  end
end
