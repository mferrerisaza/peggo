class Share < ApplicationRecord
  belongs_to :property
  belongs_to :owner
  has_many :bills

  # TODO: add validations with TDD
end
