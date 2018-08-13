class Owner < ApplicationRecord
  has_many :shares
  has_many :properties, through: :shares

  # TODO: add validations with TDD
end
