puts "Cleaning database"

Bill.destroy_all
User.destroy_all
Business.destroy_all
Budget.destroy_all
Expense.destroy_all
Property.destroy_all
Share.destroy_all
Owner.destroy_all
Concept.destroy_all

puts "Creating Users"

mike = User.create!(email: "mike@gmail.com", password: "123456")
dan = User.create!(email: "dan@gmail.com", password: "123456")

puts "Creating Businessess"

mike_business = Business.create!(name: "El Recinto", user: mike)
dan_business = Business.create!(name: "Puebla", user: dan)
