FactoryBot.define do
  factory :share do
    association :property
    association :owner
    ownerability_percentage 1
    payment_percentage 1
  end
end
