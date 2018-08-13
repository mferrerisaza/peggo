class Bill < ApplicationRecord
  belongs_to :share
  has_many :concepts
  # TODO: add validations with TDD
end
