require 'rails_helper'

RSpec.feature "Buildings features", type: :feature do
  scenario "user creates a building" do
    user = FactoryBot.create(:user)
    sign_in_as user

    expect do
      click_link "Crea una nueva copropiedad"
      fill_in "Nombre de la copropiedad", with: "Copropiedad de prueba"
      click_button "Crear"
      expect(page).to have_content "Copropiedad de prueba"
    end.to change(user.buildings, :count).by(1)
  end

  scenario "redirects to back after rendering errors" do
    user = FactoryBot.create(:user)
    sign_in_as user
    click_link "Crea una nueva copropiedad"
    fill_in "Nombre de la copropiedad", with: ""
    click_button "Crear"
    expect(page).to have_content "Name no puede estar en blanco"
    click_link "cancelar"
    expect(page.current_path).to eq buildings_path
  end
end
