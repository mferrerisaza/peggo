FactoryBot.define do
  factory :property do
    property_type "Apartamento"
    sequence(:name) { |n| "#{property_type} #{n}" }
    phone "2660480"
    sequence(:matricula_inmobiliaria) { |n| "50566#{n}" }
    building_coeficient 0.1
    association :building
    area 50
    address "Calle 11a 42-18"

    trait :type_house do
      type "Casa"
    end

    trait :type_parking_space do
      type "Parqueadero"
    end

    trait :fifty_fifty do
      after(:create) do |property|
        create_list(
          :share,
          2,
          property: property,
          ownerability_percentage: 0.5,
          payment_percentage: 0.5
        )
      end
    end
  end
end
