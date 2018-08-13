FactoryBot.define do
  factory :property do
    type "Apartamento"
    sequence(:name) { |n| "#{self.type} #{n}" }
    phone "2660480"
    sequence(:matricula_inmobiliaria) { |n| "50566#{n}" }
    building_coeficient 0.5
    association :building
    area 50
    address "Calle 11a 42-18"
  end
end
