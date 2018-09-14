FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "miguef#{n}@gmail.com" }
    password "123456"

    after(:build) do |u|
      u.skip_confirmation!
    end

    trait :with_buildings do
      after(:create) { |user| create_list(:building, 2, user: user) }
    end

    trait :with_owners do
      after(:create) { |user| create_list(:owner, 10, user: user) }
    end
  end
end
