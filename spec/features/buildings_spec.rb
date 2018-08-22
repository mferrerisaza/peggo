require 'rails_helper'

RSpec.feature "Buildings", type: :feature do
  scenario "user creates a building" do
    user = FactoryBot.create(:user)
    visit root_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    expect do
      click_link "Crea una nueva copropiedad"
      fill_in "Nombre de la copropiedad", with: "Copropiedad de prueba"
      click_button "Crear"
      expect(page).to have_content "Copropiedad de prueba"
    end.to change(user.buildings, :count).by(1)
  end

  scenario "redirects to back after rendering errors" do
    user = FactoryBot.create(:user)
    visit root_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    click_link "Crea una nueva copropiedad"
    fill_in "Nombre de la copropiedad", with: ""
    click_button "Crear"
    expect(page).to have_content "Name can't be blank"
    click_link "cancelar"
    expect(page.current_path).to eq buildings_path
  end
end
