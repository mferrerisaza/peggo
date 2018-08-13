FactoryBot.define do
  factory :budget do
    start_date "2018-08-13"
    end_date "2018-08-13"
    association :building
  end
end
