FactoryBot.define do
  factory :payment do
    contact nil
    invoice nil
    date "2019-07-07"
    description "MyString"
    number ""
    observation "MyText"
    payment_method 1
  end
end
