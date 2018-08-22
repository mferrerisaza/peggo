require 'rails_helper'

RSpec.feature "Owners", type: :feature do
  scenario  "allows a user to create an owner" do
    user = FactoryBot.create(:user)
    building = FactoryBot.create(:building)
    login_as(user, scope: :user)
    visit new_building_owner_path(building)
    fill_in "Nombre del propietario", with: "Daniel José López"
    fill_in "Cédula del propietario", with: "1040182859"
    fill_in "Teléfono del propietario", with: "2660480"
    fill_in "Correo electrónico del propietario", with: "daniel@gmail.com"
    click_on("Crear Propietario")
    visit owners_path
    expect(page).to have_content("Daniel José López")
  end
end
