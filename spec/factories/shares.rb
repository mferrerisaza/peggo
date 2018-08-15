FactoryBot.define do
  factory :share do
    association :property
    association :owner
    ownerability_percentage 1
    payment_percentage 1

    trait :with_bills do
      after(:create) { |share| create_list(:bill, 5, share: share) }
    end
  end
end
