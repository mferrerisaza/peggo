FactoryBot.define do
  factory :bill do
    association :share
    status "Pendiente"
    sequence(:period) { |n| "#{Time.now.year}-0#{Time.now.month-(n-1)}" }
    # period Time.current.strftime("%Y-%m")

    trait :with_concepts do
      after(:create) { |bill| create_list(:concept, 5, bill: bill) }
    end
  end
end
