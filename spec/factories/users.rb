FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "miguef#{n}@gmail.com" }
    password "123456"

    after(:build) do |u|
      u.skip_confirmation!
    end

    trait :with_businesses do
      after(:create) { |user| create_list(:business, 2, user: user) }
    end
  end
end
