FactoryBot.define do
  factory :business do
    sequence(:name) { |n| "Business #{n}" }
    association :user
  end
end
