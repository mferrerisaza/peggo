FactoryBot.define do
  factory :expense do
    type 1
    date "2018-08-13"
    budget nil
    description "MyString"
    attachment "MyString"
  end
end
