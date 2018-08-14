FactoryBot.define do
  factory :building do
    sequence(:name) { |n| "Building #{n}" }
    association :user

    trait :with_propierties do
      after(:create) { |building| create_list(:property, 10, building: building) }
    end

    trait :with_budgets do
      after(:create) { |building| create_list(:budget, 11, status: false, building: building) }
    end
  end
end
