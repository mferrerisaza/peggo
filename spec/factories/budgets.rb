FactoryBot.define do
  factory :budget do
    start_date "2018-01-01"
    end_date "2018-12-31"
    association :building
    amount 100_000_000

    trait :with_expenses do
      after(:create) { |budget| create_list(:expense, 10, budget: budget) }
    end
  end
end
