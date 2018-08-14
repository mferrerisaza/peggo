FactoryBot.define do
  factory :expense do
    category "Aseo"
    amount 1_000_000
    date Date.current
    association :budget
    sequence(:description) { |n| "Gasto no #{n}" }
    attachment nil
  end
end
