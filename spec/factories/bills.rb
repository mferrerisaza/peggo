FactoryBot.define do
  factory :bill do
    association :share
    status "Pendiente"
    sequence(:period) { |n| (Date.today - n.month).strftime("%Y/%m") }

    trait :with_concepts do
      after(:create) { |bill| create_list(:concept, 5, bill: bill) }
    end
  end
end
