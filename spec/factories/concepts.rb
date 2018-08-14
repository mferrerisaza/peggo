FactoryBot.define do
  factory :concept do
    association :bill
    amount 100_000
    sequence(:description) { |n| "Concepto Cuota Admin#{n}" }
  end
end
