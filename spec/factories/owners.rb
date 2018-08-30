FactoryBot.define do
  factory :owner do
    sequence(:name) { |n| "Owner no: #{n}" }
    sequence(:card_number) { |n| "104018286#{n}" }
    phone "3148509472"
    sequence(:email) { |n| "test#{n}@peggo.com" }
    association :user
    association :building
    trait :with_shares do
      after(:create) { |owner| create_list(:share, 2, owner: owner) }
    end
  end
end
