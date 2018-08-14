FactoryBot.define do
  factory :expense do
    category "Aseo"
    date Date.current
    association :budget
    sequence(:description) { |n| "Gasto no #{n}" }
    attachment nil
  end
end
