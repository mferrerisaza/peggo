puts "Cleaning database"

Bill.destroy_all
User.destroy_all
Building.destroy_all
Budget.destroy_all
Expense.destroy_all
Property.destroy_all
Share.destroy_all
Owner.destroy_all
Concept.destroy_all

puts "Creating Users"

mike = User.create!(email: "mike@gmail.com", password: "123456")
dan = User.create!(email: "dan@gmail.com", password: "123456")

puts "Creating Buildings"

mike_building = Building.create!(name: "El Recinto", user: mike)
dan_building = Building.create!(name: "Puebla", user: dan)

puts "Creating budgets"

mike_budget = Budget.create!(
  start_date: "2018-01-01",
  end_date: "2018-12-31",
  building: mike_building,
  amount: 100_000_000,
  status: true
)

dan_budget = Budget.create!(
  start_date: "2018-01-01",
  end_date: "2018-12-31",
  building: dan_building,
  amount: 1_000_000_000,
  status: true
)
puts "Creating properties"

mike_building_properties = 10

mike_building_properties.times do |n|
  p = Property.create!(
    property_type: "Apartamento",
    name: "#{n}",
    phone: "#{2660480 + n}",
    matricula_inmobiliaria: "#{50566 + n}",
    building_coeficient: 1 / mike_building_properties.to_f,
    building: mike_building,
    area: rand(50..60),
    address: Faker::Address.full_address
  )
  instance_variable_set("@mike_building_property_#{n}", p)
end


dan_building_properties = 15

dan_building_properties.times do |n|
  p = Property.create!(
    property_type: "Casa",
    name: "Casa #{n}",
    phone: "#{2660480 - n}",
    matricula_inmobiliaria: "#{50566 - n}",
    building_coeficient: 1 / dan_building_properties.to_f,
    building: dan_building,
    area: rand(100..120),
    address: Faker::Address.full_address
  )
  instance_variable_set("@dan_building_property_#{n}", p)
end

puts "Creating Owners"

number_of_owners = 10

number_of_owners.times do |n|
  o = Owner.create!(
    name: Faker::Name.name,
    card_number: Faker::IDNumber.valid,
    phone: Faker::PhoneNumber.cell_phone,
    email: Faker::Internet.free_email,
    user: mike,
    building: mike_building
  )
  instance_variable_set("@mike_building_owner_#{n}", o)
end

number_of_owners = 15

number_of_owners.times do |n|
  o = Owner.create!(
    name: Faker::Name.name,
    card_number: Faker::IDNumber.valid,
    phone: Faker::PhoneNumber.cell_phone,
    email: Faker::Internet.free_email,
    user: dan,
     building: dan_building,
  )
  instance_variable_set("@dan_building_owner_#{n}", o)
end

puts "Creating shares"
puts "Creating mike_building shares"

mike_building_properties.times do |n|
  Share.create!(
    property: instance_variable_get("@mike_building_property_#{n}"),
    owner: instance_variable_get("@mike_building_owner_#{n}"),
    ownerability_percentage: 1,
    payment_percentage: 1
  )
end

puts "Creating dan_building shares"
dan_building_properties.times do |n|
  Share.create!(
    property: instance_variable_get("@dan_building_property_#{n}"),
    owner: instance_variable_get("@dan_building_owner_#{n}"),
    ownerability_percentage: 1,
    payment_percentage: 1
  )
end
